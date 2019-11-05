$globaladmin = "admin.email@example.com"
$credentials = Get-Credential -Credential $globaladmin
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credentials -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

$user_email = read-host "Email address of the user you want to disable ActiveSync for?"

write-host "Disabling activesync for $user_email"
Set-CasMailbox -Identity $user_email -ActiveSyncEnabled $false
write-host "Done." -ForegroundColor Green

