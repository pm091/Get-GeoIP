$PSVersion = $PSVersionTable.PSVersion.Major
. $env:BHProjectPath\Get-GeoIP\Get-GeoIP.ps1

#Unit test example
Describe "Get-GeoIP PS$PSVersion Unit tests" {

   It 'Should Return Google LLC' {
    $Output = Get-GeoIP 8.8.8.8
    $Output.ISP | Should be 'Google LLC'
   }

   It 'Should Return Google LLC' {
    $Output = Get-GeoIP 8.8.4.4
    $Output.ISP | Should be 'Google LLC'
   }
}

