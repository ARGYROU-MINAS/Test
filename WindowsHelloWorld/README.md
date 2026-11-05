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

The manifest also includes `PhoneIdentity` metadata required by the UWP packaging
tools. Its `PhoneProductId` (`b64e7f0d-53c2-56f3-84e6-e06e5354257b`) was
generated locally as UUIDv5 in the URL namespace from
`msix:48508ArgyrouMinas.eu.argyrouminas.test`; it did not come from Partner
Center. `PhoneProductId` is a GUID, not a human-readable phone name. Its value
should remain stable across updates; Windows does not require it to be derived
from the package name. The zero `PhonePublisherId` is the standard placeholder
for this desktop-only app. The app still targets only `Windows.Desktop` and
declares no capabilities.

The Store package version is `1.0.1.0`. For each subsequent release, increment
only the third component: `1.0.2.0`, `1.0.3.0`, and so on (up to `65535` in that
component). For a Windows 10/11 UWP package, the Microsoft Store requires a
nonzero first version component and reserves the fourth component as `0`.
Therefore `0.0.1.0` is not valid for Store submission.

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
