function Get-GeoIP {
    <#
    .Synopsis
    Lookup IP Address Geo IP Location
    .Description
    This Function Queries The IP API With Supplied IP Adderess And Returns Geo IP Location
    .Parameter IPAddress
    IP Address To Lookup
    .Example
    Get-GeoIP -IPAddress 8.8.8.8
    .Example
    $IP = Get-NetStat | select -ExpandProperty ForeignAddressIP | Where-Object {$_ -notlike '`['}
    Get-GeoIP -IPAddress $IP
    .Example
    $IP = (Get-NetTCPConnection).remoteaddress | Where-Object {$_ -notmatch '0.0.0.0|:'}
    Get-GeoIP -IPAddress $IP
    #>
    [CmdletBinding()]
    param(
        [Parameter (Mandatory = $true,
            ValueFromPipeline = $false)]
        [ValidatePattern("(?:(?:1\d\d|2[0-5][0-5]|2[0-4]\d|0?[1-9]\d|0?0?\d)\.){3}(?:1\d\d|2[0-5][0-5]|2[0-4]\d|0?[1-9]\d|0?0?\d)")]
        [string[]]$IPAddress
    )
    begin {
        $CurrentIP = 0
    }
    process {	
        foreach ($IP in $IPAddress) {
            $CurrentIP++
            Write-Progress -Activity "Searching: $IP" -Status "$CurrentIP of $($IPAddress.Count)" -PercentComplete (($CurrentIP / $IPAddress.Count) * 100)
            try {
                Write-Verbose 'Sending Request to http://ip-api.com/json/'
                Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$IP" -ErrorAction SilentlyContinue | Foreach-object {
                    [pscustomobject]@{
                        IPAddress     = $IP
                        Country       = $_.Country
                        CountryCode   = $_.CountryCode
                        Region        = $_.Region
                        RegionName    = $_.RegionName
                        City          = $_.City
                        'Postal Code' = $_.Zip
                        Org           = $_.Org
                        ISP           = $_.ISP
                        as            = $_.as
                        Query         = $_.Query
                        Lat           = $_.Lat
                        Lon           = $_.Lon
                        TimeZone      = $_.TimeZone
                    }
                }
            }
            catch {
                Write-Warning -Message "$IP : $_"
            }
            Start-Sleep -Seconds 1
        }
    }
    end { }
        
}