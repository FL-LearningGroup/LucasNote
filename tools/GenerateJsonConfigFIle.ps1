$modulePath = '/Users/aitest/Documents/LucasGitHub/azure-powershell/src'
Set-Location -Path $modulePath 
$notModuleFolders = @('lib','shared')
$jsonArray = @()
$moduleArray = @()
foreach($moduleName in (Get-ChildItem -Path . -Directory -Exclude $notModuleFolders).Name) {
    $moduleArray += $moduleName
    if ($moduleArray.Length -eq 5) {
        $jsonArray +=  $moduleArray
        $moduleArray = @()
    }

}

Set-Location $PSScriptRoot