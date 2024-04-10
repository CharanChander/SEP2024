New-ADOrganizationalUnit -Name "Agilenet" -Path "DC=ad,DC=go1-agilenet,DC=internal"

New-ADOrganizationalUnit -Name "Employers" -Path "OU=Users,OU=Agilenet, DC=ad,DC=go1-agilenet,DC=internal"
New-ADOrganizationalUnit -Name "Employees" -Path "OU=Users,OU=Agilenet, DC=ad,DC=go1-agilenet,DC=internal"
New-ADOrganizationalUnit -Name "Computers" -Path "OU=Agilenet, DC=ad,DC=go1-agilenet,DC=internal"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=Agilenet, DC=ad,DC=go1-agilenet,DC=internal"

New-ADGroup -Name "Admins" -GroupScope Global -Path "OU=Groups,OU=Agilenet, DC=ad,DC=go1-agilenet,DC=internal"
New-ADGroup -Name "Guests" -GroupScope Global -Path "OU=Groups,OU=Agilenet, DC=ad,DC=go1-agilenet,DC=internal"


# Define the CSV file location and import the data
$Csvfile = "C:\Users\Adiministrators\Documents\Sharedfolder_Server_SEP_CLI\ImportADUsers.csv"
$Users = Import-Csv $Csvfile

# The password for the new user
$Password = "Root123"

# Loop through each user
foreach ($User in $Users) {
    try {
        # Define the parameters using a hashtable
        $NewUserParams = @{
            Name                  = "$($User.'First name') $($User.'Last name')"
            GivenName             = $User.'First name'
            Surname               = $User.'Last name'
            DisplayName           = $User.'Display name'
            SamAccountName        = $User.'User logon name'
            Path                  = $User.'OU'
            AccountPassword       = (ConvertTo-SecureString "$Password" -AsPlainText -Force)
            Enabled               = if ($User.'Account status' -eq "Enabled") { $true } else { $false }
            ChangePasswordAtLogon = $true # Set the "User must change password at next logon"
        }

        # Check to see if the user already exists in AD
        if (Get-ADUser -Filter "SamAccountName -eq '$($User.'User logon name')'") {

            # Give a warning if user exists
            Write-Host "A user with username $($User.'User logon name') already exists in Active Directory." -ForegroundColor Yellow
        }
        else {
            # User does not exist then proceed to create the new user account
            # Account will be created in the OU provided by the $User.OU variable read from the CSV file
            New-ADUser @NewUserParams
            Write-Host "The user $($User.'User logon name') is created successfully." -ForegroundColor Green
        }
    }
    catch {
        # Handle any errors that occur during account creation
        Write-Host "Failed to create user $($User.'User logon name') - $($_.Exception.Message)" -ForegroundColor Red
    }
}

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
