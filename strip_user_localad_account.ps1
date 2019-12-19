$ADsession = New-PSSession -ComputerName dc.yourdomaincontroller.com
Import-Module -PSSession $ADsession ActiveDirectory

$user_email = Read-Host -Prompt "What's the users email address?"
$user_object = Get-ADUser -LDAPFilter "(userPrincipalName=$($user_email))" -Properties *

write-host "Clearing AD attributes..."
set-ADObject -Identity $user_object.DistinguishedName -clear Department, Description, DisplayName, extensionAttribute1, mail, Manager, physicalDeliveryOfficeName, telephoneNumber, Title, Mobile, Company, homePhone, l, postalCode, streetAddress, st
write-host "Done!"
