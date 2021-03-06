﻿
function Get-BranchSettings
{
    param (
        [Parameter(Mandatory=$True, ValueFromPipelineByPropertyname=$true)]
        [PSObject]$SetupParameters,
        [Parameter(Mandatory=$False, ValueFromPipelineByPropertyname=$true)]
        [String]$SettingsFilePath = "Data\BranchSettings.Json"
    )
    $allBranchSettings = Get-Content -Path (Join-Path (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) $SettingsFilePath) | ConvertFrom-Json
    $branchSettings = ($allBranchSettings.Branches | Where-Object -Property branchId -EQ $SetupParameters.branchId)
    if ($branchSettings -eq $null) {
        $branchSettings = @{
            "branchId" = $SetupParameters.branchId; 
            "projectName" = $SetupParameters.projectName; 
            "databaseServer" = ""; 
            "databaseInstance" = ""; 
            "databaseName" = ""; 
            "instanceName" = ""; 
            "clientServicesPort" = "7046"; 
            "managementServicesPort" = "7045"}
        $allBranchSettings.Branches += $BranchSettings
        Set-Content -Path (Join-Path (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) $SettingsFilePath) -Value ($allBranchSettings | ConvertTo-Json)        
    }    
    Return $BranchSettings
}