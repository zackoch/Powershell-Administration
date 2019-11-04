$ADsession = New-PSSession -ComputerName dc.yourdomaincontroller.com
Import-Module -PSSession $ADsession ActiveDirectory

$user_email = Read-Host -Prompt "What's the users email address?"
$user_object = Get-ADUser -LDAPFilter "(userPrincipalName=$($user_email))"

Write-Host "Disabling $($user_object.Name) in Local AD..."
Disable-ADAccount -Identity $user_object.DistinguishedName
Write-Host "Done!"
