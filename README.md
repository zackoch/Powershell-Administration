# Powershell-Administration
Powershell scripts I've created for administering IT - some of these are specific to my use, so please read the code and determine if it will work for you.

[Remove a user from all Local AD Groups](https://github.com/zackoch/Powershell-Administration/blob/master/remove_user_from_all_localAD_groups.ps1)
Takes in email address, grabs all local groups the user is a member of and removes them from those groups. Be sure to change the name of the domain controller.

[Add a domain or email address to Office365 Exchange spam filter "whitelist"](https://github.com/zackoch/Powershell-Administration/blob/master/whitelist_o365_exchange.ps1)
Takes in an email address or domain - make sure that you modify the admin email, as well as the name of the filter policy to match your own. I use this all the time when a user says they are not getting email from xyz, or for domains or emails that I see in the o365 quarantine that are valid emails that should be delivered.

[Remove user from Global Address List](https://github.com/zackoch/Powershell-Administration/blob/master/localAD_hide_from_global_address_lists.ps1)
Takes in an email address, and sets a localAD attribute to hide the user from the GAL. It needs to sync to o365 if you're in a hybrid enviornment in order for it to take effect. Be sure to change the domain controller to your own.

[Disable localAD user account](https://github.com/zackoch/Powershell-Administration/blob/master/disable_localad_account.ps1)
Takes in an email address, disables the user account in AD. Make sure you change the domain controller to your own.

[Strip localAD user account](https://github.com/zackoch/Powershell-Administration/blob/master/strip_user_localad_account.ps1)
Takes in an email address, clears the ad attributes for Department, Description, DisplayName, extensionAttribute1, mail, Manager, physicalDeliveryOfficeName, telephoneNumber, Title, Mobile, and Company. Be sure to change the domain controller name to your own.

[Remove O365 user from all groups](https://github.com/zackoch/Powershell-Administration/blob/master/remove_o365_user_from_all_groups.ps1)
Takes in an email address, iterates through all the groups and group members and then removes the user from each group where the member exists. Be sure to change the admin email.

[Force O365 user password change (and email it to admin)](https://github.com/zackoch/Powershell-Administration/blob/master/force_change_o365_user_password.ps1)
Takes in an email address, changes the users password to a randomly generated one. Should be used right before you remove user tokens or run the [Kill all AzureAD sessions](https://github.com) script. Note: Since this sends an email to admins with the actual password, this should really only be used if you plan on removing the account. It could be considered a security risk to store 'valid' passwords in mailboxes. The only reason the password gets changed in my case is to ensure the user is locked out of all resources. The users account would be invalidated after the offboarding is complete. Be sure to change the email_from, email_to, smtp_server, and globaladmin variables.
