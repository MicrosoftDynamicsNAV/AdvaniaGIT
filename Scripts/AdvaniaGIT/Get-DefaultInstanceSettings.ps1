﻿function Get-DefaultInstanceSettings
{
    param (
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyname=$true)]
        [PSObject]$SetupParameters,
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyname=$true)]
        [PSObject]$BranchSettings
    )
    $DefaultInstance = Get-NAVServerInstance | Where-Object -Property Version -Match $($SetupParameters.navVersion.Substring(0,2)) | Where-Object -Property Default -EQ True
    $instanceSettings = Get-NAVServerConfiguration2 -ServerInstance $($DefaultInstance.ServerInstance)
    Return $instanceSettings
}