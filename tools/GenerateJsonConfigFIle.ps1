$modulePath = '/Users/aitest/Documents/LucasGitHub/azure-powershell/src'
Set-Location -Path $modulePath 
$notModuleFolders = @('lib','shared')
$jsonArray = New-Object object[] 30
$moduleArray = @()
$index = 0
foreach($moduleName in (Get-ChildItem -Path . -Directory -Exclude $notModuleFolders).Name) {
    $moduleArray += $moduleName
    if ($moduleArray.Length -eq 5) {
        $jsonArray[$index] = $moduleArray
        $index++
        $moduleArray = @()
    }

}
Set-Location $PSScriptRoot

$jsonArray | ConvertTo-Json | Set-Content ./a.test.json