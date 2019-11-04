# Powershell-Administration
Powershell scripts I've created for administering IT

[Remove a user from all Local AD Groups](https://github.com/zackoch/Powershell-Administration/blob/master/remove_user_from_all_localAD_groups.ps1)
Takes in email address, grabs all local groups the user is a member of and removes them from those groups. Be sure to change the name of the domain controller.

[Add a domain or email address to Office365 Exchange spam filter "whitelist"](https://github.com/zackoch/Powershell-Administration/blob/master/whitelist_o365_exchange.ps1)
Takes in an email address or domain - make sure that you modify the admin email, as well as the name of the filter policy to match your own.
