$globaladmin = "admin.email@example.com"
$credentials = Get-Credential -Credential $globaladmin
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credentials -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

$user_email = read-host "What's the users email address?"
$mail = get-mailbox $user_email

$all_groups = Get-DistributionGroup | select *

foreach($group in $all_groups){
    $group_members = get-distributionGroupMember -identity $group.Id
    foreach($member in $group_members){
        if($member.name -eq $mail.name){
            write-host "Removing" $mail.name "from group" $group.Name"..."
            remove-distributiongroupmember $group.Name -Member $user_email -confirm:$false
            write-host "done..."
        }
    }
}
