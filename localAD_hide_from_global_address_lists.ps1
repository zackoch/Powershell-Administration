# quick and dirty - sets the msExhHideFromAddressLists = True in local AD. 
# If in a hybrid o365 environment, it will push changes to hosted exchange on the next adsync

$ADsession = New-PSSession -ComputerName dc.yourdomaincontroller.com
Import-Module -PSSession $ADsession ActiveDirectory

$user_email = Read-Host -Prompt "What's the UPN? (Hint: Email Address)"
$user_object = Get-ADUser -LDAPFilter "(userPrincipalName=$($user_email))"

Write-Host "Hiding the user in the GAL..."
Set-ADObject -Identity $user_object.DistinguishedName -replace @{msExchHideFromAddressLists=$true}
