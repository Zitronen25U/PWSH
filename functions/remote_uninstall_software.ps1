<#
First, you need to capture the installed applications on the target device. An easy way to do this is to capture the reg keys that contains the software installation information


$Apps = @()
$Apps += Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" 3 
$Apps += Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" 
#>

<#
Next, filter for the documented uninstall string for the software you want. example is Excel viewer 2003

$Apps | where {$_.displayName -like "*Excel*"} | Select DisplayName, DisplayVersion, QuietUninstallStr 2 
#>

<#
Start-Process msiexec.exe -ArgumentList "/x {90840409-6000-11D3-8CFE-0150048383C9} /qn /l*V ExcelViewer

$ExcelViewerComputers = Get-Clipboard

Invoke-Command $ExcelViewerComputers {Start-Process msiexec.exe -ArgumentList "/x {90840409-6000-11D3-8CFE-015
#>
$Apps = @()
$Apps += Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
$Apps += Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
$Apps | where {$_.displayName -like "*Excel*"} | Select DisplayName, DisplayVersion, QuietUninstallString

#
