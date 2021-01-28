## POWERSHELL API practice script
# testing methods to view local data api

 

$street = Invoke-WebRequest -Uri "https://secure2.hamiltoncounty.in.gov/PropertyReports/api/Search?selector=thornberry%20dr" -Headers @{"Sec-Fetch-Mode"="cors"; "Sec-Fetch-Site"="same-origin"; "Accept-Encoding"="gzip, deflate, br"; "Accept-Language"="en-US,en;q=0.9"; "User-Agent"="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36"; "Accept"="*/*"; "Referer"="https://secure2.hamiltoncounty.in.gov/PropertyReports/index.aspx"; "X-Requested-With"="XMLHttpRequest"}

#$street | ConvertFrom-Json

$street2 = $street | convertfrom-json

 

$street2[1]

$street2[1].parcel

$street2[1].mailaddress

 

$street2 | where {$_.propaddress -like "*thornberry dr*"} | measure

$street2 | where {$_.propaddress -like "*thornberry dr*"}

$street2 | where {$_.mailaddress -notlike "*thornberry*"} | measure

$street2 | where {$_.mailaddress -notlike "*thornberry*"}

 

$street2 | where {($_.mailaddress -notlike "*thornberry dr*") -or ($_.propaddress -notlike "*thornberry dr*")}

$street2 | where {($_.mailaddress -notlike "*thornberry dr*") -or ($_.propaddress -notlike "*thornberry dr*")} | select parcel, propaddress, mailaddress | ft -AutoSize

 

$street2[3] | select -Property *

 

$parcels304 = Invoke-WebRequest -Uri "https://secure2.hamiltoncounty.in.gov/PropertyReports/api/Property?selector=general&parcel=1609240201011000" -Headers @{"Sec-Fetch-Mode"="cors"; "Sec-Fetch-Site"="same-origin"; "Accept-Encoding"="gzip, deflate, br"; "Accept-Language"="en-US,en;q=0.9"; "User-Agent"="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36"; "Accept"="*/*"; "Referer"="https://secure2.hamiltoncounty.in.gov/PropertyReports/reports.aspx?parcel=1609240201011000"; "X-Requested-With"="XMLHttpRequest"}

$parcels304 = $parcels304 | ConvertFrom-Json

$parcels304.owner

 

$street = Invoke-WebRequest -Uri "https://secure2.hamiltoncounty.in.gov/PropertyReports/api/Search?selector=thornberry%20dr" -Headers @{"Sec-Fetch-Mode"="cors"; "Sec-Fetch-Site"="same-origin"; "Accept-Encoding"="gzip, deflate, br"; "Accept-Language"="en-US,en;q=0.9"; "User-Agent"="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36"; "Accept"="*/*"; "Referer"="https://secure2.hamiltoncounty.in.gov/PropertyReports/index.aspx"; "X-Requested-With"="XMLHttpRequest"}

$street2 = $street | convertfrom-json

 

$street2 | where {($_.mailaddress -like "30* thornberry dr*") -or ($_.propaddress -like "30* thornberry dr*")} |

    select parcel, propaddress, mailaddress |

    foreach{

        $uristring = "https://secure2.hamiltoncounty.in.gov/PropertyReports/api/Property?selector=general&parcel=" + $_.parcel

        $parcels = Invoke-WebRequest -Uri $uristring | ConvertFrom-Json

 

        Write-output $parcels.subdivisionName, $parcels.owner, $_.parcel, $_.propaddress, $_.mailaddress  "`n"

 

    }

 
