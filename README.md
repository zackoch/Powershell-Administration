# Powershell-Administration
Powershell scripts I've created for administering various IT functions - some of these are specific to my use, so please read the code and determine if it will work for you.

Note - for some of these scripts to work you need to have the [office365 modules](https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-all-office-365-services-in-a-single-windows-powershell-window) installed.

Not everything will be related to local AD or Azure AD - I'll put whatever scripts I write in here that I find I'm using often. They could be random snippets, deployment stuff, etc. If I find it gets too big, I'll split everything into folders.

[Remove a user from all Local AD Groups](https://github.com/zackoch/Powershell-Administration/blob/master/remove_user_from_all_localAD_groups.ps1)
Takes in email address, grabs all local groups the user is a member of and removes them from those groups. Be sure to change the name of the domain controller.

[Add a domain or email address to Office365 Exchange spam filter "whitelist"](https://github.com/zackoch/Powershell-Administration/blob/master/whitelist_o365_exchange.ps1)
Takes in an email address or domain - make sure that you modify the admin email, as well as the name of the filter policy to match your own. I use this all the time when a user says they are not getting email from xyz, or for domains or emails that I see in the o365 quarantine that are valid emails that should be delivered.

[Remove user from Global Address List](https://github.com/zackoch/Powershell-Administration/blob/master/localAD_hide_from_global_address_lists.ps1)
Takes in an email address, and sets a localAD attribute to hide the user from the GAL. It needs to sync to o365 if you're in a hybrid enviornment in order for it to take effect. Be sure to change the domain controller to your own.

[Disable localAD user account](https://github.com/zackoch/Powershell-Administration/blob/master/disable_localad_account.ps1)
Takes in an email address, disables the user account in AD. Make sure you change the domain controller to your own.

[Strip localAD user account](https://github.com/zackoch/Powershell-Administration/blob/master/strip_user_localad_account.ps1)
Takes in an email address, clears the ad attributes for Department, Description, DisplayName, extensionAttribute1, mail, Manager, physicalDeliveryOfficeName, telephoneNumber, Title, Mobile, Company, Home Phone, City, Zip, and Street Address. Be sure to change the domain controller name to your own.

[Remove O365 user from all groups](https://github.com/zackoch/Powershell-Administration/blob/master/remove_o365_user_from_all_groups.ps1)
Takes in an email address, iterates through all the groups and group members and then removes the user from each group where the member exists. Be sure to change the admin email.

[Block O365 user from AzureAD sign-in](https://github.com/zackoch/Powershell-Administration/blob/master/block_azureAD_user_from_signin.ps1)
Takes in an email address, blocks the user from signing into any AzureAD authenticated resources. You could change the $false to $true to un-block a user if you wish. Be sure to change the admin email to your own.

[Force O365 user password change (and email it to admin)](https://github.com/zackoch/Powershell-Administration/blob/master/force_change_o365_user_password.ps1)
Takes in an email address, changes the users password to a randomly generated one. Should be used right before you remove user tokens or run the [Kill all AzureAD sessions](https://github.com/zackoch/Powershell-Administration/blob/master/kill_all_azureAD_sessions.ps1) script. Note: Since this sends an email to admins with the actual password, this should really only be used if you plan on removing the account. It could be considered a security risk to store 'valid' passwords in mailboxes. The only reason the password gets changed in my case is to ensure the user is locked out of all resources. The users account would be invalidated after the offboarding is complete. Be sure to change the email_from, email_to, smtp_server, and globaladmin variables.

[Kill all AzureAD user sessions](https://github.com/zackoch/Powershell-Administration/blob/master/kill_all_azureAD_sessions.ps1)
Takes in an email address, and kills any active sessions which utilize Azure AD. This is used to terminate outstanding sessions for offboarding. It's also used in conjunction with a password change to ensure the user can't log in to anything further. Be sure to change the globaladmin variable. 

[Recover deleted OneDrive files (up to 93 days)](https://github.com/zackoch/Powershell-Administration/blob/master/recover_deleted_onedrive_files.ps1)
Takes in an email address and the number of historical days back to recover data from. The maximum date you can recover files from will be 93 days prior to the current date. This script is useful for those users who attempt to delete everything from their OneDrives prior to leaving the org. Be sure to chang ethe admin email. Note: This can potentially take a very long time to run. I've had several times where this took 4+ hours.

[Move users OneDrive files to another OneDrive](https://github.com/zackoch/Powershell-Administration/blob/master/move_onedrive_files_to_another_onedrive_account.ps1)
Takes in an email address, and moves all of their OneDrive files to another OneDrive account. For me personally, this is useful when a user leave the org - instead of tying up another license for OneDrve, I simply move all of their files into a OneDrive account that contains all previous employees data. Be sure to change the globaladmin email, and destinaton user. This script could also be used to just move contents between OneDrive accounts, although you'll notice I have a custom naming scheme that you may want to modify. Note: It should also be made aware that this literally downloads all of the contents to your local machine in chunks and streams them over to the other OneDrive account. There are limitations here - this module can only do files up to 250MB. Larger files will need to be manually transfered.

[Change O365 Mailbox Permissions](https://github.com/zackoch/Powershell-Administration/blob/master/change_o365_mailbox_permissions.ps1)
Takes in an email address for the user, an email address for who you want to give the users mailbox access to, and allows you to choose the permission to apply to the mailbox. Be sure to change the admin email address.

[Forward and Un-Forward O365 Email](https://github.com/zackoch/Powershell-Administration/blob/master/forward_o365_user_email.ps1)
Choose to add a new forward, or remove an existing (just sets to $null), takes in users email, and forwarding email if necessary. Note: you can change the boolean value on the DeliverToMailboxAndForward to $false if you don't want the email to get stored in the users inbox before it is forwarded to the forward address. Be sure to change the admin email. 

[Disable ActiveSync for O365 User](https://github.com/zackoch/Powershell-Administration/blob/master/disable_activesync_o365_user.ps1)
Takes in the users email, disables active sync. Note: You can change the -ActiveSyncEnabled $false boolean value to $true if you want to re-enable ActiveSync. Be sure to change the admin email address.

[Convert O365 Mailbox to Shared](https://github.com/zackoch/Powershell-Administration/blob/master/convert_o365_mailbox_to_shared.ps1)
Takes in the users email address, converts the mailbox to a shared mailbox. Be sure to change the admin email address.

[Spam Filter - Export & Import Permitted Domains](https://github.com/zackoch/Powershell-Administration/blob/master/spam_filter_export_import_allowed_domains.ps1)
Upon exporting (choosing 'e'), it creates two CSV's - one is an export 'backup', the other is your import file you may modify and import by re-running the script and choosing 'i'

[List, Restore, Recycle, or Delete user from Recycle Bin](https://github.com/zackoch/Powershell-Administration/blob/master/restore_or_delete_msol_user.ps1)
In practice you really shouldn't remove users from the recycle bin unless for some reason you know for certain you won't need to restore the user within 30 days. This script is just a wrapper for basic management tasks as it relates to managing deleted users. You'll need to connect to O365 powershell outside the script as this won't handle it for you.
