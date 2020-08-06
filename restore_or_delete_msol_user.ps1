using namespace System.Management.Automation.Host


function List-RecycleBin {
    get-msoluser -all -ReturnDeletedUsers
}

function Recycle-User {
    $username = read-host -prompt "Enter Username"
    write-host "Recycling user" $username
    Remove-MsolUser -UserPrincipalName $username
}

function Perm-Delete {
    $username = read-host -prompt "Enter Username"
    $no = [ChoiceDescription]::new('&No', 'No, do not delete user')
    $yes = [ChoiceDescription]::new('&Yes', 'Yes, delete user forever')
    $options = [ChoiceDescription[]]($no, $yes)

    $result = $host.ui.PromptForChoice("WARNING!", "Confirmation to delete user $username", $options, 0)

    switch ($result) {
    0 { 
        write-host 'Aborted!'
      }
    1 { 
        write-host 'Deleting ' $username
        remove-msoluser -userprincipalname $username -removefromrecyclebin -force
      }
    }

}

function Restore-User {
    $username = read-host -prompt "Enter Username"
    write-host "Restoring user" $username
    Restore-MsolUser -UserPrincipalName $username
}

function Main-Menu {

    $list = [ChoiceDescription]::new('&List', 'List Recycled Users')
    $restore = [ChoiceDescription]::new('&Restore', 'Restore a User From Recycle Bin')
    $recycle = [ChoiceDescription]::new('&Recycle', 'Recycle (Recoverable)')
    $delete_permanently = [ChoiceDescription]::new('&Delete', 'Delete Permanately')

    

    $options = [ChoiceDescription[]]($list, $restore, $recycle, $delete_permanently)

    $result = $host.ui.PromptForChoice("Choose an option", "What would you like to do?", $options, 0)

    switch ($result) {
        0 { List-RecycleBin }
        1 { Restore-User }
        2 { Recycle-user }
        3 { Perm-Delete }
    }

}


Main-Menu