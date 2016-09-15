<#
   .SYNOPSIS
        Finds Current DCN Controller
   .DESCRIPTION
        Queries the DCN database and retrieves the current controller.
   .PARAMETER DatabaseParameters
        The Database parameters of the DCN database. Should include the server name, the database name, and if integrated security should be used.
   .EXAMPLE
        PS C:\> Get-DCNController -DatabaseParameters $value1
   .NOTES
         Additional information about the function.
#>
function Get-DCNController
{
	Write-Output 'localhost'
}

<#
   .SYNOPSIS
    	Creates a new DCN Database instance for new installs.
   .DESCRIPTION
        This function will create a new DCN database instance that is essentially blank.  Requires that the user running the function have database create rights on the SQL server (parameter)
   .PARAMETER SqlServer
        The FQDN of the SQL server that will host the new DCN instance.  SQL Availability Groups are supported.
   .PARAMETER SqlInstance
        If using a non-default instance, specify the instance name here.  Otherwise leave blank to use default.
   .EXAMPLE
        PS C:\> New-DCNDatabase -SqlServer 'Value1' -SqlInstance 'Value2'
   .NOTES
    	Additional information about the function.
#>
function New-DCNDatabase
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 0)]
		[ValidateNotNullOrEmpty()]
		[string]$SqlServer,
		[Parameter(Position = 1)]
		[string]$SqlInstance
	)
	
	#TODO: Place script here
}

<#
   .SYNOPSIS
        Test connection to the specified DCN database
   .DESCRIPTION
        Will test connection to the specified DCN database.  Returns a true/false.  Requires that the user running the function have query access to the database.
   .PARAMETER Server
        A description of the Server parameter.
   .PARAMETER Database
        A description of the Database parameter.
   .PARAMETER Integrated
        A description of the Integrated parameter.
   .EXAMPLE
        PS C:\> Test-DBConnection -Server 'Value1' -Database 'Value2'
   .NOTES
    	Additional information about the function.
#>
function Test-DBConnection
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 0)]
		[string]$Server,
		[Parameter(Mandatory = $true,
				   Position = 1)]
		[string]$Database,
		[Parameter(Mandatory = $true,
				   Position = 2)]
		[bin]$Integrated
	)
	
	#TODO: Place script here
}

function Get-DCNMembers
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function New-DCNMember
{
	[CmdletBinding()]
	param ()
	
	#Install Service
	#Install Cache from Controller
}

function Get-DCNMember
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function New-DCNController
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function Add-DCNTask
{
	[CmdletBinding()]
	param ()
	
	#Add to SQL Table
	#Add files to cache, if appropriate
}

function Get-DCNTask
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function Enable-DCNTask
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function Disable-DCNTask
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function Invoke-DCNTask
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function Remove-DCNTask
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function Remove-DCNMember
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function Compare-DCNCache
{
	[CmdletBinding()]
	param ()
	
	#Get-DNCController
	#Compare Cache to Controller
}

function Update-DCNCache
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function Get-DCNCache
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function Install-DCN
{
	[CmdletBinding()]
	param ()
	
	$msg = "Enter the username and password that will run the PowerShell Distributed Computing Network (DCN)";
	$credential = $Host.UI.PromptForCredential("Task username and password", $msg, "$env:userdomain\$env:username", $env:userdomain)
	$timer = Read-Host -Prompt "Enter the interval (in minutes) DCN will check for tasks to run"
	$log = "$env:SystemDrive\PowerShellDCN\Service.log"
	try
	{
		New-Item -ItemType dir -Path "$env:SystemDrive\PowerShellDCN"  -ErrorAction SilentlyContinue | Out-Null
	}
	catch
	{
		Write-Verbose "Unable to create PowerShellDCN directory."
	}
	
	Copy-Item -Path c:\Users\Draith\Documents\GitHub\DCN\service.ps1 -Destination "$env:SystemDrive\PowerShellDCN\service.ps1" -force
	try
	{
		$jobname = "PowerShellDCN"
		$script = "$env:SystemDrive\PowerShellDCN\service.ps1"
		$repeat = (New-TimeSpan -Minutes $timer)
		$trigger = New-JobTrigger -Once -At (Get-Date).Date -RepeatIndefinitely -RepetitionInterval $repeat 
		$options = New-ScheduledJobOption -RunElevated -ContinueIfGoingOnBattery -StartIfOnBattery
		Register-ScheduledJob -Name $jobname -FilePath $script -Trigger $trigger -ScheduledJobOption $options -Credential $credential|out-null
	}
	catch
	{
		
	}
	#New-DCNDatabase
	#Install Service
	#Setup Reg Keys/file config?
	#New-DCNController
}

function Uninstall-DCN
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function Repair-DCNMember
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

function Get-DCNTasksToRun
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}
<#
	.SYNOPSIS
		Simple log writing function.
	
	.DESCRIPTION
		This function will write to log file, recording the date/time, log level (INFO, ERROR, WARN) and message supplied.  It will also roll the logs at a set size, renaming the exist log to an archive name and starting anew.
	
	.PARAMETER logpath
		Path of the log to write to.  Full path is expected i.e. c:\logs\error.log
	
	.PARAMETER level
		The 2nd part of the message, this should be one of the following values - INFO, WARN, ERROR, NORMAL.  
	
	.PARAMETER message
		The actual message that makes up the bulk of the log.  This is what you want recorded to the log file.
	
	.EXAMPLE
				PS C:\> Write-Log -logpath 'Value1' -level 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Write-Log
{
	[CmdletBinding(PositionalBinding = $true)]
	param
	(
		[Parameter(Mandatory = $true,
				   ValueFromPipeline = $true,
				   ValueFromPipelineByPropertyName = $true,
				   ValueFromRemainingArguments = $true,
				   Position = 0)]
		[ValidateNotNullOrEmpty()]
		[Alias('path', 'filepath', 'file')]
		[string]$logpath,
		[Parameter(Mandatory = $true,
				   ValueFromPipeline = $true,
				   ValueFromPipelineByPropertyName = $true,
				   ValueFromRemainingArguments = $true,
				   Position = 1)]
		[ValidateSet('INFO', 'WARN', 'ERROR', 'NORMAL')]
		[string]$level,
		[Parameter(Mandatory = $true,
				   ValueFromPipeline = $true,
				   ValueFromPipelineByPropertyName = $true,
				   ValueFromRemainingArguments = $true,
				   Position = 2)]
		[ValidateNotNullOrEmpty()]
		[Alias('text')]
		[string]$message
	)
	
	Begin
	{
		$date = Get-Date
	}
	Process
	{
		if (Test-Path $logpath)
		{
			if ((Get-Item $logpath).length -gt 5mb)
			{
				Copy-Item -Path $logpath -Destination $logpath + '.' + $date
			}
		}
		$lineoutput = $date.ToString() + '---' + $level + '---' + $message
		try
		{
			$lineoutput | Out-File -FilePath $logpath -Append -Force
		}
		catch
		{
			Write-Verbose "Unable to log to $logpath"
			
		}
		
	}
	End
	{
		
	}
}


Export-ModuleMember -Function Get-DCNController,
					New-DCNDatabase,
					Test-DBConnection,
					Get-DCNMembers,
					New-DCNMember,
					Get-DCNMember,
					New-DCNController,
					Add-DCNTask,
					Get-DCNTask,
					Enable-DCNTask,
					Disable-DCNTask,
					Invoke-DCNTask,
					Remove-DCNTask,
					Remove-DCNMember,
					Compare-DCNCache,
					Update-DCNCache,
					Get-DCNCache,
					Install-DCN,
					Uninstall-DCN,
					Repair-DCNMember,
					write-log,
					Get-DCNTasksToRun