# UPDATE LOG FILE
$DateFormat = "yyyy-MM-dd"
$Today = Get-Date -Format $DateFormat
$LogFolder = "C:\Code\<projectName>\Logs\"
$TodayLog = $LogFolder+$Today+"_Logs.log"

# For appending log file entries
function Write-Log ($log) {
    filter timestamp {"$(Get-Date -Format G) - $PSItem"}
    $log | timestamp | out-file $TodayLog -append
}

# call this function to add log entries. 

<# Example

Write-TodayLogFile("instert log stuff and variables here") 

will print a log file with the above DTstamp and then write pass after that

#>
