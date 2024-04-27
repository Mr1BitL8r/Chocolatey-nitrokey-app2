$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/Nitrokey/nitrokey-app2/releases/download/v2.3.0/nitrokey-app-v2.3.0-x64-windows-installer.msi'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  url64bit      = $url64

  softwareName  = 'Nitrokey App 2'

  checksum64    = '3DC0E4AFA0B3CF8F44845B7DBCF71B4CDD49688EADAAA003C3074E6F5431823D'
  checksumType64= 'sha256'

  silentArgs   = '/qn'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
