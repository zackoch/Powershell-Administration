$globaladmin = "admin.email@example.com"
$credentials = Get-Credential -Credential $globaladmin
Connect-AzureAD -Credential $credentials

$user_email = read-host "What's the users email address?"

write-host "Blocking $user_email from signing into AzureAD authenticated resources..."
set-azureadUser -ObjectID $user_email -AccountEnabled $false
write-host "Done."
