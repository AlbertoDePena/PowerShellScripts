<#
.SYNOPSIS
  Increment project.json version.
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

    Get-ChildItem -Path $SourceDir | ?{ $_.PSIsContainer } | ForEach-Object { 
        
        $jsonFile = $_.FullName + "\project.json"

        Write-Output "Updating version for $jsonFile..."

        $json = Get-Content -Raw -Path $jsonFile | ConvertFrom-Json

        $version = $json.version.Split(".")

        $major = $version[0]
        $minor = $version[1]
        $build = $version[2]
        $revision = $version[3]

        $json.version = [String]::Format("{0}.{1}.{2}.{3}", $major, $minor, $build, ([Convert]::ToInt32($revision) + 1))

        $json | ConvertTo-Json -depth 99 | Out-File $jsonFile
    }

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