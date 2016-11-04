<#
.SYNOPSIS
  Generate NuGet package.
.PARAMETER NugetExe

.PARAMETER Nuspec

.PARAMETER OutputDir
#>
Param(
    [Parameter(Mandatory=$true)] 
    [String]
	$NugetExe,

    [Parameter(Mandatory=$true)] 
	[String]
	$Nuspec,

    [Parameter(Mandatory=$true)] 
    [String]
	$OutputDir
)
try
{
    Write-Output 'Parameters:'
    Write-Output "--            NuGet.exe: $NugetExe"
    Write-Output "--               Nuspec: $Nuspec"
    Write-Output "--     Output Directory: $OutputDir"
    Write-Output ''

    & "$NugetExe" pack "$Nuspec" -OutputDirectory "$OutputDir"

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