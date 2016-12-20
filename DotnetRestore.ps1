<#
.SYNOPSIS
  Restore packages.
.PARAMETER SourceDir
#>
Param(
	[String]
	$SourceDir = $(Throw "The source directory was not specified.")
)
try 
{
    Write-Output "Parameters:"
    Write-Output "--               Directory: $SourceDir"

    Get-ChildItem -Path $SourceDir | ?{ $_.PSIsContainer } | ForEach-Object { & dotnet restore $_.FullName }

    $exitCode = 0
}
catch 
{
    Write-Error "*** $_"

    Write-Output "Process aborted."

    $exitCode = 1
}
finally
{
    Exit $exitCode
}
