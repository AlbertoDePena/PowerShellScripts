<#
.SYNOPSIS
 Create IIS web site.

.PARAMETER AppPoolName

.PARAMETER AppName

.PARAMETER AppHostName

.PARAMETER Directory

.PARAMETER Port
#>
Param
(
    [Parameter(Mandatory=$true)] 
    [String]
    $AppPoolName,

    [Parameter(Mandatory=$true)] 
    [String]
    $AppName,

    [String]
    $AppHostName,

    [Parameter(Mandatory=$true)] 
    [String]
    $Directory,

    [Int]
    $Port
)

try
{
    Write-Output 'Parameters:'
    Write-Output ''
    Write-Output "    App Pool Name: $AppPoolName"
    Write-Output "        Directory: $Directory"
    Write-Output "         App Name: $AppName"
    Write-Output "    App Host Name: $AppHostName"
    Write-Output "             Port: $Port"

    import-module WebAdministration 

    if (!(Test-Path $Directory))
    {
         New-Item -Path $Directory -ItemType Directory 
    }

    if (!($AppHostName))
    {
        $AppHostName = 'localhost'
    }

    if (!($Port))
    {
        $Port = 80
    }

    New-Website -Name $AppName -Port $Port -HostHeader $AppHostName -IPAddress * -PhysicalPath $Directory -ApplicationPool $AppPoolName 
 
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
