function Write-Log
{
   <#
    .SYNOPSIS
        Simple function to write to a log file
    .DESCRIPTION
        This function will write to a log file, pre-pending the date/time, level of detail, and supplied information
    .PARAMETER text
        This is the main text to log
    .PARAMETER Level
        INFO,WARN,ERROR,DEBUG
    .PARAMETER Log
        Name of the log file to send the data to.
    .EXAMPLE
        write-log -text "This is the main problem." -level ERROR -log c:\test.log
    .FUNCTIONALITY
        PowerShell Language
    .NOTES
        Created by Donnie Taylor.
        Version 1.0     Date 4/5/2016
    #>

    Param (   
        [Parameter(Mandatory=$true,position=0)]
        [ValidateNotNull()]
        [string]$text,
        [Parameter(Mandatory=$true,position=1)]
        [ValidateSet("INFO","WARN","ERROR","DEBUG")]
        $level,
        [Parameter(Mandatory=$true,position=2)]
        $log
        )
    Write-Verbose "Log:  $log"
    $date = (get-date).ToString()
    if (Test-Path $log) 
    { 
        if ((Get-Item $log).length -gt 5mb)
        {
			$filenamedate = get-date -Format 'MM-dd-yy hh.mm.ss'
			$archivelog = ($log + '.' + $filenamedate + '.archive').Replace('/', '-')
            copy-item $log -Destination $archivelog
            Remove-Item $log -force
            Write-Verbose "Rolled the log."
        } 
    }
    $line = $date + '---'+ $level + '---' + $text
    $line |out-file -FilePath $log -Append
}