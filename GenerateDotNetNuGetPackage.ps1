<#
.SYNOPSIS
  Generate DotNet NuGet package.
.PARAMETER ProjectJson

.PARAMETER PackageOutputDir

.PARAMETER ArtifactsOutputDir

.PARAMETER Version
#>
Param(
    [Parameter(Mandatory=$true)] 
    [String]
	$ProjectJson,

    [Parameter(Mandatory=$true)] 
    [String]
	$PackageOutputDir,

    [Parameter(Mandatory=$true)] 
    [String]
	$ArtifactsOutputDir,

    [Parameter(Mandatory=$true)] 
    [String]
	$Version
)
try
{
    Write-Output 'Parameters:'
    Write-Output "--               project.json: $ProjectJson"
    Write-Output "--   Package Output Directory: $PackageOutputDir"
    Write-Output "-- Artifacts Output Directory: $ArtifactsOutputDir"
    Write-Output "--                    Version: $Version"
    Write-Output ''

    & dotnet pack "$ProjectJson" --output "$PackageOutputDir" --build-base-path "$ArtifactsOutputDir" --version-suffix "rc-$Version" -c Release

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