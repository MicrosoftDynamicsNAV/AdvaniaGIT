﻿function Restore-NAVBackup
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyname=$true)]
        [String]$BackupFilePath,
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyname=$true)]
        [String]$DatabaseServer,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyname=$true)]
        [String]$DatabaseInstance,
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyname=$true)]
        [String]$DatabaseName
    )
    $DataFilesDestinationPath = Join-Path $DatabasePath ($DatabaseName + '_data.mdf')
    $LogFilesDestinationPath = Join-Path $DatabasePath ($DatabaseName + '_log.ldf')
    $ServiceAccount = "NT AUTHORITY\NETWORK SERVICE"

    $params = @{ 
        FilePath = $BackupFilePath 
        DatabaseServer = $DatabaseServer 
        DatabaseName = $DatabaseName 
        ServiceAccount = $ServiceAccount 
        DataFilesDestinationPath = $DataFilesDestinationPath 
        LogFilesDestinationPath = $LogFilesDestinationPath 
        Timeout = 360 }
    if ($DatabaseInstance -ne "") { $params.DatabaseInstance = $DatabaseInstance }
    New-NAVDatabase @params -Force | Out-Null
}
