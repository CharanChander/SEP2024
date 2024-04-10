$SharedFolderPath = "\\ad.go1-agilenet.internal\UserShares"

if (-not (Test-Path $SharedFolderPath)) {
    New-Item -Path $SharedFolderPath -ItemType Directory
}

$Users = Get-ADUser -Filter * -SearchBase "OU=Users,OU=Agilenet,DC=ad,DC=go1-agilenet,DC=internal"

foreach ($User in $Users) {
    $UserName = $User.SamAccountName
    $UserFolderPath = Join-Path -Path $SharedFolderPath -ChildPath $UserName
   
    if (-not (Test-Path $UserFolderPath)) {
        New-Item -Path $UserFolderPath -ItemType Directory
    }
   
    $ACL = Get-Acl $UserFolderPath
    $Permission = "Domain\$UserName","FullControl","ContainerInherit,ObjectInherit","None","Allow"
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $Permission
    $ACL.AddAccessRule($AccessRule)
    Set-Acl -Path $UserFolderPath -AclObject $ACL
}
