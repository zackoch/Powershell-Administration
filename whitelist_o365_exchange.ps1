$globaladmin = "admin.account@exampledomain.com"
$credentials = Get-Credential -Credential $globaladmin
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credentials -Authentication Basic -AllowRedirection


Import-PSSession $Session -DisableNameChecking

$domainlist = Read-Host -Prompt 'Domain(s) to add to Allow list (press ENTER if none, use single space between entries)'
$addresslist = Read-Host -Prompt 'Email(s) to add to Allow list (press ENTER if none, use single space between entries)'
$domains = $domainlist -split " "
$addresses = $addresslist -split " "

if (!$domainlist) {
	Write-Host "No domains to add...skipping"
} else {
	Write-Host "Adding domain name(s) to Company Main Spam Policy Allow list...."
	Set-HostedContentFilterPolicy -Identity "Company Main Spam Policy" -AllowedSenderDomains @{Add=$domains}
}

if (!$addresslist) {
	Write-Host "No addresses to add...skipping"
} else {
	Write-Host "Adding email address(es) to Company Main Spam Policy Allow list...."
	Set-HostedContentFilterPolicy -Identity "Company Main Spam Policy" -AllowedSenders @{Add=$addresses}
}

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

Remove-PSSession $Session
