Describe "Get-GeoIP PS$PSVersion Unit tests" {

   It 'Should Return Google LLC' {
    $Output = Get-GeoIP 8.8.8.8
    $Output.ISP | Should -Be 'Google LLC'
   }

   It 'Should Return Google LLC' {
    $Output = Get-GeoIP 8.8.4.4
    $Output.ISP | Should -Be 'Google LLC'
   }

   It 'Should Return Google LLC' {
    $Output = Get-GeoIP 2001:4860:4860::8888
    $Output.ISP | Should -Be 'Google LLC'
   }

   It 'Should Return Google LLC' {
    $Output = Get-GeoIP 2001:4860:4860::8844
    $Output.ISP | Should -Be 'Google LLC'
   }
}

