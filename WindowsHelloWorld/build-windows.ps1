$ErrorActionPreference = 'Stop'

$vswhere = Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio\Installer\vswhere.exe'
if (-not (Test-Path $vswhere)) {
    throw 'Install Visual Studio 2022 with the Universal Windows Platform development workload.'
}

$msbuild = & $vswhere -latest -products '*' -find 'MSBuild\**\Bin\MSBuild.exe' |
    Select-Object -First 1
if (-not $msbuild) {
    throw 'Visual Studio MSBuild was not found.'
}

& $msbuild (Join-Path $PSScriptRoot 'WindowsHelloWorld.sln') /restore /m `
    /p:Configuration=Release /p:Platform=x64 /p:AppxBundle=Never `
    /p:GenerateAppxPackageOnBuild=true /p:AppxPackageSigningEnabled=false `
    /p:UapAppxPackageBuildMode=StoreUpload
if ($LASTEXITCODE -ne 0) {
    throw "MSBuild failed with exit code $LASTEXITCODE."
}

$packages = Get-ChildItem $PSScriptRoot -Recurse -File | Where-Object {
    $_.Extension -in '.msix', '.appx', '.msixupload', '.appxupload'
}
if (-not $packages) {
    throw 'The build completed, but no Windows app package was found.'
}
$packages | Select-Object FullName, Length
