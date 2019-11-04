$globaladmin = "admin.email@example.com"
$credentials = Get-Credential -Credential $globaladmin
Connect-AzureAD -Credential $credentials

$user_email = read-host "What's the users email address?"

write-host "Killing all user sessions for $user_email..."
get-azureaduser -SearchString $user_email | Revoke-AzureADUserAllRefreshToken
write-host "Done."

