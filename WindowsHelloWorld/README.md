# Hello World for Windows 11

This is a minimal UWP app: one page displaying “Hello World!”. UWP runs in an
AppContainer. The package manifest declares **no capabilities**, so the app does
not request network, location, camera, microphone, or file-library access.

The manifest uses the app's reserved Microsoft Store identity:

- Package name: `48508ArgyrouMinas.eu.argyrouminas.test`
- Publisher: `CN=C864DBCB-FDA0-47B0-AFB3-BC7C2899BD5F`
- Publisher display name: `ARGYROU MINAS`

These values must match the reservation in Partner Center. If Visual Studio asks
you to associate the project with a Store app, select that same reservation and
verify the manifest still contains these values afterward.

On a Windows 11 computer, install Visual Studio 2022 with the **Universal
Windows Platform development** workload and Windows 11 SDK **10.0.22621.0**.
Open `WindowsHelloWorld.sln`, restore NuGet packages, select **Release | x64**,
and build. `build-windows.ps1` runs a Release build and looks for the generated
MSIX/AppX package. It disables local signing; its output is for build validation,
not direct installation.

To avoid installing Visual Studio locally, push this project together with
`.github/workflows/build-windows-uwp.yml` to GitHub. A push that changes these
files starts a build on a hosted Windows runner. Download the unsigned package
from the **WindowsHelloWorld-x64** artifact on the Actions run. The workflow can
also be started manually once it is on the repository's default branch.

For a Store upload, use Visual Studio’s **Publish > Create App Packages** flow,
select the reserved app, choose the Microsoft Store destination, and create the
x64 upload package. The Windows packaging tools are required for a
submission-ready file.

The included 512-pixel icon at `Assets/StoreListingIcon.png` can be used for the
Store listing.
