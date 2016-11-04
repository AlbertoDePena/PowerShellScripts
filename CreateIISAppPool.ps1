<#
.SYNOPSIS
 Create IIS app pool.

.PARAMETER AppPoolName

.PARAMETER Directory

.PARAMETER IdentityType

.PARAMETER UserName

.PARAMETER Password

.PARAMETER RuntimeVersion
#>
Param
(
    [Parameter(Mandatory=$true)] 
    [String]
    $AppPoolName,

    [Parameter(Mandatory=$true)] 
    [String]
    $Directory,

    [Int]
    $IdentityType,

    [String]
    $UserName,

    [String]
    $Password,

    [String]
    $RuntimeVersion = ''
)

try
{
    Write-Output 'Parameters:'
    Write-Output ''
    Write-Output "    App Pool Name: $AppPoolName"
    Write-Output "        Directory: $Directory"
    Write-Output "    Identity Type: $IdentityType"
    Write-Output "             User: $UserName"

    if (($IdentityType -lt 0) -or ($IdentityType -gt 3))
    {
        Throw 'Invalid identity type'
    }
   
    import-module WebAdministration 

    if (!(Test-Path $Directory))
    {
        New-Item -Path $Directory -ItemType Directory 
    }

    New-WebAppPool -Name $AppPoolName 
    
    if ($IdentityType -eq 3)
    {
        Set-ItemProperty IIS:\AppPools\$AppPoolName -name processModel -value @{userName="$UserName";password="$Password";identitytype=$IdentityType}
    }
    else
    {
        Set-ItemProperty IIS:\AppPools\$AppPoolName -name processModel -value @{identitytype=$IdentityType}
    }
    
	Set-ItemProperty IIS:\AppPools\$AppPoolName managedRuntimeVersion "$RuntimeVersion"
   
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
