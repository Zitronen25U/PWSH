function Write-TpLog {
  <#
  .SYNOPSIS
      Creates and/or appends log file entries.
  .DESCRIPTION
      Creates and/or appends log file entries in format compatible with cmtrace.
  .EXAMPLE
      PS> Write-TpLog -Path 'C:\Code\Logs\Example.log' -Message 'Error entry' -Type Error
      Writes Error log entry to the Example.log file.
  .EXAMPLE
      PS> Write-TpLog -Path 'C:\Code\Logs\Example.log'
      Writes a time stamp message to the Example.log file.
  .EXAMPLE
      PS> Write-TpLog -Path 'C:\Code\Logs\Example.log' -Message 'Information entry'
      Writes Information log entry to the Example.log file.
  #>
  [CmdletBinding(SupportsShouldProcess,
                 ConfirmImpact='Medium')]
  Param(
      [Parameter(Position=0,
                 ValueFromPipeline=$true,
                 ValueFromPipelineByPropertyName=$true,
                 ValueFromRemainingArguments=$false)]
      [String]$Path,

      [ValidateNotNullorEmpty()]
      [String]$Message = 'No message, time stamp only.',

      [ValidateSet("Info", "Warning", "Error")]
      [ValidateNotNullorEmpty()]
      [String]$Type = "Info"
  )
  begin {
      switch ($Type) {
          "Info" { [int]$Type = 1 }
          "Warning" { [int]$Type = 2 }
          "Error" { [int]$Type = 3 }
      }
      # Check for logPath variable if Path is not provided
      if (-not($Path) -and ($logPath)) {
          $Path = $logPath
      }
      elseif (-not($Path) -and -not($logPath)) {
          Write-Error -Message 'No log path or logPath variable not specified'
      }

      if (-not(Test-Path $Path)) {
          ## Create the log file
          New-Item -Path $Path -Type File -Force | Out-Null
      }
  }
  process {
      if ($pscmdlet.ShouldProcess($Path, "Write $Message to ")) {
          Try {
              # Create a log entry
              $TimeGenerated = "$(Get-Date -Format HH:mm:ss).$((Get-Date).Millisecond)+000"
              $Date = Get-Date -Format MM-dd-yyyy
              try {
                  $Component = "$($MyInvocation.ScriptName | Split-Path -Leaf -ErrorAction Stop):$($MyInvocation.ScriptLineNumber)"
              } catch {
                  $Component = "Interactive command execution"
              }
              $Context = "$([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)"
              $Thread = "$([Threading.Thread]::CurrentThread.ManagedThreadId)"
              $Line = '<![LOG[{0}]LOG]!><time="{1}" date="{2}" component="{3}" context="{4}" type="{5}" thread="{6}" file="">'
              $LineFormat = $Message, $TimeGenerated, $Date, $Component, $Context, $Type, $Thread
              $WriteLine = $Line -f $LineFormat

              # Write the line to the log file
              Add-Content -Value $WriteLine -Path $Path -ErrorAction Stop -ErrorVariable WriteTpLogError
          } Catch {
              Write-Warning -Message "Error writing log: $WriteTpLogError"
              Write-Error $_.Exception.Message
          }
      }
  }
  end {
  }
}
