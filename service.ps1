﻿	#Find Current Controller
	<#
	if (get-dcncontroller | test-connection -quiet -Count 1)
	{
		#Check Connection to Current Controller
		# If no connection to current controller, check connection to other members.
		#if connection to other members, check for controller again, then elevate if not different.
		#if no connection to other members, assume network outage.
	}
	#>
	#If current controller, delegate tasks after checking connection to each member
$output = "Test123"
$output | Out-File c:\Temp\output.txt -Append
Write-Output $true
