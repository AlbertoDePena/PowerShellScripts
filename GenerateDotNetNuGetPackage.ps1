<#
.SYNOPSIS
  Generate DotNet NuGet package.
.PARAMETER ProjectJson

.PARAMETER PackageOutputDir

.PARAMETER ArtifactsOutputDir
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
	$ArtifactsOutputDir
)
try
{
    Write-Output 'Parameters:'
    Write-Output "--               project.json: $ProjectJson"
    Write-Output "--   Package Output Directory: $PackageOutputDir"
    Write-Output "-- Artifacts Output Directory: $ArtifactsOutputDir"
    Write-Output ''

    $now = [System.DateTime]::UtcNow
    $date = New-Object System.DateTime(1970, 1, 1)
    $version = ($now - $date).TotalMilliseconds
   
    & dotnet pack "$ProjectJson" --output "$PackageOutputDir" --build-base-path "$ArtifactsOutputDir" --version-suffix "ci-($version)" -c Release

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