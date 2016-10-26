
<#
	.SYNOPSIS
		Finds Current DCN Controller
	
	.DESCRIPTION
		Queries the DCN config and retrieves the current controller.
	
	.EXAMPLE
		PS C:\> Get-DCNController -DatabaseParameters $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-DCNController
{
	[CmdletBinding()]
	param ()
	
	$DCNConfigPath = (Get-ItemProperty HKLM:\SOFTWARE\DCN -Name DCNConfigPath).DCNConfigPath
	Write-Output (Get-Content $DCNConfigPath\Members.cfg|ConvertFrom-Json).controller
}

function Get-DCNMembers
{
	[CmdletBinding()]
	param ()
	
	$DCNConfigPath = (Get-ItemProperty HKLM:\SOFTWARE\DCN -Name DCNConfigPath).DCNConfigPath
	Write-Output (Get-Content $DCNConfigPath\Members.cfg | ConvertFrom-Json).Members
}
<#
	.SYNOPSIS
		Adds a new DCN member to the pool
	
	.DESCRIPTION
		Adds a new member to the DCN pool, which enables the machine to start performing tasks.  Once added, new machines will start performing tasks during the next run cycle.
	
	.PARAMETER computer
		Name of the machine to be added to the DCN members array.
	
	.NOTES
		Additional information about the function.
#>
function New-DCNMember
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
		[Alias('server', 'workstation')]
		[string]$computer
	)
	
BEGIN 
{
	#BeginBlock
}
PROCESS
{
	$DCNConfigPath = (Get-ItemProperty HKLM:\SOFTWARE\DCN -Name DCNConfigPath).DCNConfigPath
	$DCNConfig = Get-Content $DCNConfigPath\Members.cfg | ConvertFrom-Json
	[array]$DCNConfig.members += $computer
	$DCNConfig | ConvertTo-Json | Out-File "$DCNConfigPath\Members.cfg" -Force
	
}
END
{
	#EndBlock
}
	
}
function Get-DCNMember
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

<#
	.SYNOPSIS
		Creates a new DCNController and updates config
	
	.DESCRIPTION
		Creates a new DCNController, effectively taking over control capabilities from all other DCN members, and using the current set of tasks as the source of record.
	
	.PARAMETER computer
		Name of the computer that will become the new DCN Controller.  If this parameter is left blank, assume current machine.
	
	.NOTES
		Additional information about the function.
#>
function New-DCNController
{
	[CmdletBinding(PositionalBinding = $true)]
	param
	(
		[Parameter(Mandatory = $false,
				   ValueFromPipeline = $true,
				   ValueFromPipelineByPropertyName = $true,
				   ValueFromRemainingArguments = $true,
				   Position = 0)]
		[string]$computer = (resolve-dnsname 127.0.0.1).namehost
	)
	
	BEGIN
	{
		#BeginBlock
	}
	PROCESS
	{
		if ($computer = (resolve-dnsname 127.0.0.1).namehost)
		{
			$DCNConfigFile = (Get-ItemProperty -Path HKLM:\SOFTWARE\DCN -Name DCNConfigPath).DCNConfigPath
			$config = Get-Content $DCNConfigFile\config.cfg | ConvertFrom-Json
			$members = Get-Content $config.membersfile
		}
	}
	END
	{
		#EndBlock
	}
}
function Add-DCNTask
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
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
<#
	.SYNOPSIS
		Removes a DCN Member server
	
	.DESCRIPTION
		A detailed description of the Remove-DCNMember function.
	
	.PARAMETER computer
		A description of the computer parameter.
	
	.NOTES
		Additional information about the function.
#>
function Remove-DCNMember
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 0)]
		[string]$computer
	)
	
	$DCNConfigPath = (Get-ItemProperty HKLM:\SOFTWARE\DCN -Name DCNConfigPath).DCNConfigPath
	$DCNConfig = Get-Content $DCNConfigPath\Members.cfg | ConvertFrom-Json
	[array]$DCNConfig.members = $DCNConfig.members -ne $computer
	$DCNConfig | ConvertTo-Json | Out-File "$DCNConfigPath\Members.cfg" -Force
	
	#TODO:  Remove cache, remove scheduled tasks, etc....
}	
function Compare-DCNCache
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
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
<#
	.SYNOPSIS
		Installs new instance of DCN
	
	.DESCRIPTION
		This function is used to install a brand new instance of DCN, setting up a new controller, establishing the initial DCN cache, etc...
	
	.NOTES
		Additional information about the function.
#>
function Install-DCN
{
	[CmdletBinding()]
	param ()
	
	$DCNPrompt = Read-Host -Prompt "Please enter install path DCN shoud use.  Press enter to accept <C:\DCN>" 
	try
	{
		if ($DCNPrompt)
		{
			$global:DCNPath = $DCNPrompt
		}
		else
		{
			$global:DCNPath = "C:\DCN"
		}
		New-Item -ItemType dir -Path $DCNPath -Force | Out-Null
		New-Item -ItemType dir -Path $DCNPath\Config -Force | Out-Null
		New-Item -ItemType dir -Path $DCNPath\Cache -Force | Out-Null
		New-Item -ItemType dir -Path $DCNPath\Logs -Force | Out-Null
		New-Item -Path HKLM:\Software -Name DCN –Force | Out-Null
		New-ItemProperty -Path HKLM:\SOFTWARE\DCN -Name DCNPath -Value $DCNPath | Out-Null
		New-ItemProperty -Path HKLM:\SOFTWARE\DCN -Name DCNConfigPath -Value $DCNPath\Config | Out-Null
		New-ItemProperty -Path HKLM:\SOFTWARE\DCN -Name DCNCachePath -Value $DCNPath\Cache | Out-Null
		New-ItemProperty -Path HKLM:\SOFTWARE\DCN -Name DCNLogsPath -Value $DCNPath\Logs | Out-Null
		$global:installlog = "$DCNPath\Logs\install.log"
		write-log -log $installlog -level INFO -text 'Installation of DCN Started'
	}
	catch
	{
		Write-host "Error during installation. Error was $_"
	}
	
	$config = @{
		ConfigPath = "$DCNPath\Config"
		CachePath = "$DCNPath\Cache"
		LogsPath = "$DCNPath\Logs"
		InstallLog = "$DCNPath\Logs\install.log"
		PrimaryLog = "$DCNPath\Logs\DCN.log"
		TaskList = "$DCNPath\Config\Tasks.cfg"
		MembersFile = "$DCNPath\Config\Members.cfg"
	}
	$hostname = (resolve-dnsname 127.0.0.1).namehost
	$members = @{
		Controller = "$hostname"
		Members = "$hostname"
	}	
try
	{
		$config | ConvertTo-Json | Out-File "$DCNPath\Config\config.cfg" -Force
		write-log -log $installlog -level INFO -text "Config file created at $DCNPath\Config\config.cfg"
		$members | ConvertTo-Json | Out-File "$DCNPath\Config\Members.cfg" -Force
		write-log -log $installlog -level INFO -text "Members file created at $DCNPath\Config\members.cfg"
	}
	catch
	{
		write-log -log $installlog -level ERROR -text "Config file creation failed.  Error is $_"
	}
}
function Uninstall-DCN
{
	[CmdletBinding()]
	param ()
	
	if ((Read-Host "Do you wish to uninstall DCN entirely - Y/N?") -eq 'y')
	{
		$DCNPath = (Get-ItemProperty -Path HKLM:\SOFTWARE\DCN -Name DCNPath).DCNPath
		Remove-Item $DCNPath -Force -Recurse
		Remove-Item HKLM:\SOFTWARE\DCN -Recurse -Force
	}
}
function Repair-DCNMember
{
	[CmdletBinding()]
	param ()
	
	#TODO: Place script here
}

