$PSVersion = $PSVersionTable.PSVersion.Major
. $env:BHProjectPath\Get-GeoIP\Get-GeoIP.ps1

#Unit test example
Describe "Get-GeoIP PS$PSVersion Unit tests" {

   It 'Should Return Cisco' {
    $Output = Get-GeoIP 8.8.8.8
    $Output.ISP | Should be 'Google LLC'
   }

   It 'Should accept "-" seperators in macaddresses and Return Xerox (Valid Vendor)' {
    $Output = Get-GeoIP 8.8.4.4
    $Output.ISP | Should be 'Google LLC'
   }
}

