$ADsession = New-PSSession -ComputerName dc.yourdomaincontroller.com
Import-Module -PSSession $ADsession ActiveDirectory

$user_email = read-host "Enter the address of user to remove from all Local AD groups: " 
$user_object = Get-ADUser -LDAPFilter "(userPrincipalName=$($user_email))"
$groups = Get-ADPrincipalGroupMembership -Identity $user_object.SamAccountName | Where-Object -property name -NE -value "Domain Users" | select name

foreach ($group in $groups.name){
        Write-Host "Removing $($user_object.Name) from" $group"..."
        Remove-ADGroupMember -Identity $group -Members $user_object.SamAccountName -Confirm:$false
        Write-Host "Done..."
    }
