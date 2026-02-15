$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/Nitrokey/nitrokey-app2/releases/download/v2.5.2/nitrokey-app-v2.5.2-x64-windows-installer.msi'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  url64bit      = $url64

  softwareName  = 'Nitrokey App 2'

  checksum64    = 'e951147473c83aaf41a47df2f27299dfbfa6e53771918d405060889e06778471'
  checksumType64= 'sha256'

  silentArgs   = '/qn'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
