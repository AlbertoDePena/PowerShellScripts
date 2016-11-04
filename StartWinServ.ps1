<#
.SYNOPSIS
  Start windows service (local or remote).
.PARAMETER ServerName

.PARAMETER ServiceName

.PARAMETER Credentials
#>
Param
(
    [Parameter(Mandatory=$true)] 
    [String]
    $ServerName,

    [Parameter(Mandatory=$true)] 
    [String]
    $ServiceName,

    [Parameter(Mandatory=$true)]
    [Management.Automation.PSCredential]
    $Credentials
)

try
{
    Write-Output  ''
    Write-Output  "Starting $ServiceName (WinServ)..."
    Write-Output  ''

    $winServ = Get-WmiObject -Query `
		"select * from Win32_Service where Name = '$ServiceName'" `
		-ComputerName $ServerName -Credential $Credentials

    $name = $winServ.DisplayName

    if ($winServ.State -eq 'Running')
    {
        Write-Output "$name already running."
    }
    else 
    {
        Write-Output "Starting $name..."

        $winServ.InvokeMethod('StartService', $null) | Out-Null
    }

     $exitCode = 0
}
catch 
{
    Write-Error "*** $_"

    Write-Output 'Process aborted.'

    $exitCode = 1
}
finally
{
    Exit $exitCode
}