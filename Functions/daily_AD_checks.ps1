# Place all DC's into a variable
$DCs = Get-ADDomainController -Filter

# Check DC's reboot times 

Get-CimInstance -ClassName win32_ooperatingsystem -ComputerName <#name#> -filter PSComputerName, LastBootupTime

#check all boot times

$DCs = Get-ADDomainController -Filter *
$Progress = 1
$RebootResults = 
  foreach ($DC in $DCs){
      Write-Progress -Activity "finding boot time for $(DC.name)" -Status "reading $Progress of $($DCs.count)" #-something
      $OS = Get-WMIobject win32_ooperatingsystem -ComputerName $DC

      [PSCUstomObject]@{
          Name = $DC.name
          OperatingSystem = $OS.caption
          BootTime = $OS.ConvertToDateTime($OS.LastBootupTime)
        }
    }
$RebootResults

#This check is much quicker using the following

Invoke-Command $DCs {Get-CimInstance -Class OperatingSystem | Select LastBootupTime} | Sort PSComputerName

# Check Sensitive Group Membership

Get-ADGroupMember "Domain Admins"
Get-ADGroupMember "Enterprise Admins"
Get-ADGroupMember "Schema Admins"

# Check AD Replication

repadmin.exe /showrepl * /csv > ..\..\somefile.csv
Import-CSV ..\..\somefile.csv | Out-GridView


# Check HDD Space

Get-PSDrive | where ($_.name -like "C")

# on multiple devices

Invoke-Command $DCs (Get-PSDrive | Where ($_.name -like "C"))

# Check for duplicate uidNumber Attributes

Get-ADUser -Filter "enables -eq "$True" and uidNumber -Like '*'" -Properties uidNumber -Search 


