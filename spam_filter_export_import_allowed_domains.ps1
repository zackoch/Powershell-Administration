# edit the PolicyName variable to reflect your filter's identity
$PolicyName = 'Main Spam Policy'
$CSVOutFile = 'PermittedDomainExport.csv'
# to avoid mistakes the exported csv will be copied and the working copy will be the one you should edit and import not the original
$CSVInFile = 'PermittedDomainImport.csv'

$menu = Read-Host '(e)xport, (i)mport, or (q)uit?'
if ($menu -eq 'e') {
    # exports just the allowed domains as a csv
    Get-HostedContentFilterPolicy -Identity $PolicyName | select -ExpandProperty AllowedSenderDomains | Select-Object @{Name=’Domain’;Expression={$_}} | Export-Csv .\$CSVOutFile -NoType
    copy-item .\$CSVOutFile -Destination .\$CSVInFile
}
if ($menu -eq 'i') {
    # if exists: import allowed domains from a working copy of the csv to the proper filter policy
    if (Test-Path .\$CSVInFile) {
        $DomainList = Import-Csv .\$CSVInFile
        ForEach ($Domain in $DomainList) {
            Set-HostedContentFilterPolicy -Identity $PolicyName -AllowedsenderDomains @{Add=$Domain.Domain}
        }
        Get-HostedContentFilterPolicy -Identity $PolicyName | select -ExpandProperty AllowedSenderDomains | Select-Object @{Name=’Domain’;Expression={$_}}
    }
    else {
        Write-Host 'Import CSV does not exist. Nothing to upload.'
    }
}
if ($menu -eq 'q') {
    exit
}
