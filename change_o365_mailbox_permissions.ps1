$globaladmin = "admin.email@example.com"
$credentials = Get-Credential -Credential $globaladmin
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credentials -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

$user_email = read-host "Email address of the user you want to add permission for?"
$access_email = read-host "Email address of the person you want to give permission to (manager, etc.)?" 
$access_level = read-host "Type 'f' for full access`nType 'r' for read access`nType 'sb' for send on behalf`nType 'sa' for send as`nType 'a' for all`nChoose option"

if ($access_level.ToLower() -eq 'f') {
    Add-MailboxPermission -Identity $user_email -User $access_email -AccessRights FullAccess -InheritanceType All -AutoMapping $false
    }
elseif ($access_level.ToLower() -eq 'r') {
    Add-MailboxPermission -Identity $user_email -User $access_email -AccessRights ReadPermission -InheritanceType All -AutoMapping $false
    }
elseif ($access_level.ToLower() -eq 'sb') {
    Set-Mailbox -Identity $user_email -GrantSendOnBehalfTo $access_email
    }      
elseif ($access_level.ToLower() -eq 'sa') {
    Add-RecipientPermission $user_email -AccessRights SendAs -Trustee $access_email 
}
elseif ($access_level.ToLower() -eq 'a') {
    write-host "Adding full access permission..."
    Add-MailboxPermission -Identity $user_email -User $access_email -AccessRights FullAccess -InheritanceType All -AutoMapping $false
    write-host "Adding send on behalf permission..."
    Add-RecipientPermission $user_email -AccessRights SendAs -Trustee $access_email -confirm:$false 
}
write-host "Done." -ForegroundColor Green
