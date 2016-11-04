<#
.SYNOPSIS
 Grant directory permission.

.DESCRIPTION
 Grant full control to the provided service account for provided app directory.

.PARAMETER Directory

.PARAMETER UserName
#>
Param
(
    [Parameter(Mandatory=$true)] 
    [String]
    $Directory,

    [Parameter(Mandatory=$true)] 
    [String]
    $UserName
)
try
{
    Write-Output 'Parameters:'
    Write-Output ''
    Write-Output "        Directory: $Directory"
    Write-Output "             User: $UserName"
    Write-Output ''
    Write-Output 'Granting directory permission...'
    Write-Output ''

    $inherit = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit"

    $propagation = [System.Security.AccessControl.PropagationFlags]"None"

    $acl = Get-Acl $Directory

    $user = New-Object System.Security.Principal.NTAccount($UserName)

    $accessrule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, "FullControl", $inherit, $propagation, "Allow")

    $acl.AddAccessRule($accessrule)

    Set-Acl -aclobject $acl $Directory

    Write-Output 'Directory permission granted.'
    Write-Output ''

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
