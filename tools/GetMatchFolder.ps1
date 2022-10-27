$repoPath = "C:\Users\v-diya\repository\azure-powershell\Main\azure-powershell\src"
Set-Location -Path $repoPath 
$moduleFolderPathList = (Get-ChildItem -Path . -Directory).FullName
foreach($moduleFolderPath in $moduleFolderPathList) {
    $changeLogPath = Join-Path $moduleFolderPath "Changelog.md"
    if(Test-Path $changeLogPath) {
        continue
    }
    $moduleFolderPath.Split('\')[-1]
}