$globaladmin = "admin.email@example.com"
$credentials = Get-Credential -Credential $globaladmin
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credentials -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

$user_email = read-host "Email address of the user to convert to a shared mailbox?"

write-host "Converting to shared mailbox for $user_email..."
Set-Mailbox $user_email -Type Shared
write-host "Done." -ForegroundColor Green
