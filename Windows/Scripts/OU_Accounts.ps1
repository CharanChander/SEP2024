New-ADOrganizationalUnit -Name "Agilenet" -Path "DC=ad,DC=go1-agilenet,DC=internal"

New-ADOrganizationalUnit -Name "Users" -Path "OU=Agilenet,DC=ad,DC=go1-agilenet,DC=internal"
New-ADOrganizationalUnit -Name "Employers" -Path "OU=Users,OU=Agilenet,DC=ad,DC=go1-agilenet,DC=internal"
New-ADOrganizationalUnit -Name "Employees" -Path "OU=Users,OU=Agilenet,DC=ad,DC=go1-agilenet,DC=internal"
New-ADOrganizationalUnit -Name "Computers" -Path "OU=Agilenet,DC=ad,DC=go1-agilenet,DC=internal"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=Agilenet,DC=ad,DC=go1-agilenet,DC=internal"

New-ADGroup -Name "Admins" -GroupScope Global -Path "OU=Groups,OU=Agilenet,DC=ad,DC=go1-agilenet,DC=internal"
New-ADGroup -Name "Guests" -GroupScope Global -Path "OU=Groups,OU=Agilenet,DC=ad,DC=go1-agilenet,DC=internal"

