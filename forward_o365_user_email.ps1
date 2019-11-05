$globaladmin = "admin.email@example.com"
$credentials = Get-Credential -Credential $globaladmin
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credentials -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

$choice = read-host "Type N for new forward address`nType R to remove forwarding address"

if ($choice.tolower() -eq 'n') {
    $user_email = read-host "Email address of the user you want to forward email for?"
    $forward_to_email = read-host "Forward-To email (manager, etc.)?" 
    write-host "Setting up forwarding rule for emails from $user_email to $forward_to_email..."
    Set-Mailbox -Identity $user_email -DeliverToMailboxAndForward $true -ForwardingSMTPAddress $forward_to_email
}
elseif ($choice.tolower() -eq 'r') {
    $user_email = read-host "Email address of the user you want to remove forwarding?"
    write-host "Removing forwarding rule on $user_email's mailbox..."
    Set-Mailbox -Identity $user_email -ForwardingAddress $NULL -ForwardingSmtpAddress $NULL
}

write-host "Done." -ForegroundColor Green
