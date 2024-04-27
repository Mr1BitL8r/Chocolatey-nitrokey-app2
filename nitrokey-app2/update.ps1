import-module au

$releases = 'https://github.com/Nitrokey/nitrokey-app2/releases'
$synology_note_station_client_base_url = 'https://github.com/Nitrokey/nitrokey-app2/releases/download/'

function global:au_SearchReplace {
    @{
       ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
     }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }
function global:au_GetLatest {
    # Get the content of the website with the release notes
    $release_versions_page = Invoke-WebRequest -Uri $releases
    #Write-Host "Release version page: $release_versions_page"
    # Use a regular expression to look for all the data in the form of e.g. "v2.3.0" in the website
    $found = "$release_versions_page" -match '.*"(\d+\.\d+\.\d+)".*'
    if ($found) {
        # Use the first found entry matching the regex as latest version as this one shows up first on the website (latest entry is first)
        $latest_version = $matches[1]
    }
    #Write-Host "Found: $found"
    #Write-Host "Latest version: $latest_version"
    
    $url64   = $synology_note_station_client_base_url + $latest_version + 'v2.3.0/nitrokey-app-v' + $latest_version + '-x64-windows-installer.msi'
    # Replace the '-' with a '.' to match the Chocolatey versioning schema
    $version = $latest_version -replace "\-", "."

    return @{
        Version = $version
        URL64 = $url64
        ReleaseNotes = "$releases"
    }
}

update -ChecksumFor none
#au_GetLatest