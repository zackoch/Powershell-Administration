$user = Read-Host "Enter the users email address"
$globaladmin = "admin.email@example.com"
$credentials = Get-Credential -Credential $globaladmin
$daysBack = Read-Host "How many days back? (Note: Maximum of 93)"
$today = (get-date)
$restoreDate = $today.date.AddDays(-$daysback)

Connect-MsolService -Credential $credentials
 
$InitialDomain = Get-MsolDomain | Where-Object {$_.IsInitial -eq $true}
  
$SharePointAdminURL = "https://$($InitialDomain.Name.Split(".")[0])-admin.sharepoint.com"

$userUnderscore = $user -replace "[^a-zA-Z]", "_"

$userOneDriveSite = "https://$($InitialDomain.Name.Split(".")[0])-my.sharepoint.com/personal/$userUnderscore"

Write-Host "Connecting to SharePoint Online" -ForegroundColor Blue
Connect-SPOService -Url $SharePointAdminURL -Credential $credentials

Write-Host "Adding $globaladmin as admin on OneDrive for $user" -ForegroundColor Blue

Set-SPOUser -Site $userOneDriveSite -LoginName $globaladmin -IsSiteCollectionAdmin $true
  
Write-Host "Connecting to $user's OneDrive via SharePoint Online PNP module" -ForegroundColor Blue
  
Connect-PnPOnline -Url $userOneDriveSite -Credentials $credentials

Write-Host "Getting display name of $user" -ForegroundColor Blue

$userOwner = Get-PnPSiteCollectionAdmin | Where-Object {$_.loginname -match $user}

if ($userOwner -contains $null) {
    $userOwner = @{
        Title = "Unknown User"
    }
}

Get-PnPRecycleBinItem | ? {($_.DeletedDate -gt $restoreDate) -and ($_.DeletedByEmail -eq $user)} | Restore-PnPRecycleBinItem -Force -Verbose
