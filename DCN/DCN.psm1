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
	try
	{
		New-Item -ItemType dir -Path "$env:SystemDrive\program files\PowerShellDCN"  -ErrorAction SilentlyContinue| Out-Null
	}
	catch
	{
		Write-Verbose "Unable to create PowerShellDCN directory."
	}
	
	Copy-Item -Path c:\Users\Draith\Documents\GitHub\DCN\service.ps1 -Destination "$env:SystemDrive\program files\PowerShellDCN\service.ps1" -force
	try
	{
		$jobname = "PowerShellDCN"
		$script = "$env:SystemDrive\program files\PowerShellDCN\service.ps1"
		$repeat = (New-TimeSpan -Minutes 1)
		$scriptblock = [scriptblock]::Create($script)
		$trigger = New-JobTrigger -Once -At (Get-Date).Date -RepeatIndefinitely -RepetitionInterval $repeat
		$options = New-ScheduledJobOption -RunElevated -ContinueIfGoingOnBattery -StartIfOnBattery
		Register-ScheduledJob -Name $jobname -ScriptBlock $scriptblock -Trigger $trigger -ScheduledJobOption $options 
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
					Get-DCNTasksToRun