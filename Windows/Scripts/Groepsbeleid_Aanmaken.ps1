# Maak een nieuw groepsbeleidsobject (GPO)
New-GPO -Name "NoLocalLogonPolicy"

# Stel het beleid in om lokale aanmeldingen te voorkomen
Set-GPRegistryValue -Name "NoLocalLogonPolicy" -Key "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" -ValueName "LocalAccountTokenFilterPolicy" -Type DWORD -Value 1

# Link het groepsbeleid aan de juiste OU
$OUPath = "OU=Employees,OU=Users,OU=Agilenet, DC=ad,DC=go1-agilenet,DC=internal"
$GPOName = "NoLocalLogonPolicy"
New-GPLink -Name $GPOName -Target $OUPath
