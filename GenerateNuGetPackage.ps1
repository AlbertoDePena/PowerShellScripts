<#
.SYNOPSIS
  Generate NuGet package.
.PARAMETER NugetExePath

.PARAMETER NuspecPath

.PARAMETER PackageOutputDir
#>
Param(
    [Parameter(Mandatory=$true)] 
    [String]
	$NugetExePath,

    [Parameter(Mandatory=$true)] 
	[String]
	$NuspecPath,

    [Parameter(Mandatory=$true)] 
    [String]
	$PackageOutputDir
)
try
{
    Write-Output 'Parameters:'
    Write-Output "--            NuGet.exe: $NugetExePath"
    Write-Output "--               Nuspec: $NuspecPath"
    Write-Output "--     Output Directory: $PackageOutputDir"
    Write-Output ''

    & "$NugetExePath" pack "$NuspecPath" -OutputDirectory "$PackageOutputDir"

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