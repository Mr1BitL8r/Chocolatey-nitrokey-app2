## Chocolatey community package for Synology Note Station Client
This is just a [Chocolatey community](https://community.chocolatey.org/) package for installing and uninstalling the Synology Note Station Client on Windows.

## How to upgrade for a newer version
If there is a new version available of the Synology Note Station Client, which you can e.g. find at https://www.synology.com/de-de/releaseNote/NoteStationClient please perform the following steps:
1. Navigate into the _sub_directory: **nitrokey-app2/tools**
2. Adjust the file **chocolateyinstall.ps1**, so that entries
    * **$url64** is set to the download URL of the 64-bit Setup.exe
    * **checksum64** is set to the sha256 checksum of the 64-bit Setup.exe
    _Hints_: You can find the download link e.g. https://github.com/Nitrokey/nitrokey-app2/releases and can calculate the SHA256 checksum e.g. in PowerShell with: Get-FileHash .\nitrokey-app-v2.3.0-x64-windows-installer.msi | Format-List
3. Navigate into the parent directory: **nitrokey-app2**
4. Adjust the file **nitrokey-app2.nuspec**, so that the
    * <version> is correct, but make sure **NOT** to use the '-', so e.g. "2.2.4-703" needs to be "2.2.4.703" for chocolatey.
    * <copyright> is set to the correct year.
5. Open a PowerShell with **administrator** privileges and navigate into the folder **nitrokey-app2** that is containing the file **nitrokey-app2.nuspec**
    * Create the package for chocolatey via executing the command: _choco pack_
    * _Hint:_ If there are other *.nupkg files than the one that you want to test in the folder, delete or move them.
6. Test the newly created package by 
    * Upgrading it, e.g. via executing: _choco **upgrade** nitrokey-app2 -dv -s ._
    * Uninstalling it, e.g. via executing: _choco **uninstall** nitrokey-app2 -dv -s ._
    * Installing it, e.g. via executing: _choco **install** nitrokey-app2 -dv -s ._
7. Push the package to the chocolatey community repository: _choco push .\nitrokey-app2.**2.3.0**.nupkg -s https://push.chocolatey.org/_