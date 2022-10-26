function  CleanBranch() {
    $currentBranchStatus = (git status)
    if($currentBranchStatus[-1] -ne "nothing to commit, working tree clean") {
        if (Read-Host "Are you sure you want to abort unstage files(Yes/No)" -eq "Yes") {
            Write-Host "Execute git checkout ."
            (git checkout .)
        }else {
            ExitScript
        }
        
        
        if (Read-Host "Are you sure you want to abort untrack files(Yes/No)" -eq "Yes") {
            Write-Host "Execute git clean -fxd"
            (git clean -fxd)
        }else {
            ExitScript
        }

    }
}


function PushCode($remote, $remoteBranch) {
    if (Read-Host "Are you sure you want to push your changed code to remote repository(Yes/No)" -eq "Yes") {
        Write-Host "Push $remoteBranch code to remote repoistory"
        $null = (git add -A)
        $null = (git commit -m 'replace https://docs.microsoft.com/powershell to https://learn.microsoft.com/powershell')
        $null = (git push $remote $remoteBranch)
    } else {
        ExitScript
    }

}

function ExitScript() {
    Write-Host "Exit script"
    exit
}

$scriptPath = $PSScriptRoot
$repoPath = "C:\Users\v-diya\repository\azure-powershell\Main\azure-powershell"
Set-Location -Path $repoPath 
$moduleNameList = @('Databricks')
$newBranchName = 'databrick-docs'
$excludeFileList = @('Changelog.md')
try {

# Get current branch
$currentBranch = (git branch --show-current) 
Write-Host "Current branch $currentBranch"

# Clean curent branch
CleanBranch

# Swith branch to main branch
if ($currentBranch -ne 'main') {
    Write-Host "Switch to main branch"
    git checkout main
    CleanBranch
}

Write-Host "Pull main branch"
$null = (git pull)

$branchList = (git branch) | ForEach-Object -Process {$_.Split(' ')[-1]}
if ($branchList -contains $newBranchName) {
    Write-Host "$newBranchName branch exist yet."
    ExitScript
}

Write-Host "Checkout to $newBranchName"
$null = (git checkout -b $newBranchName)


foreach($moduleName in $moduleNameList) {
    $filePaths = (Get-ChildItem -Path (Join-Path $repoPath "src\$moduleName") -Recurse -File -Exclude $excludeFileList).FullName
    foreach($filePath in $filePaths) {
        (Get-Content -Path $filePath -Raw) -replace 'https://docs.microsoft.com/powershell', 'https://learn.microsoft.com/powershell' | Set-Content -Path $filePath -Force
    }     
}

$currentBranchStatus = (git status)
$currentBranchStatus > (Join-Path $scriptPath "$newBranchName-log.txt")

if($currentBranchStatus[-1] -eq "nothing to commit, working tree clean") {
    Write-Host "No file changed. No https://docs.microsoft.com/powershell url need replace."
    ExitScript
}

PushCode('origin', $newBranchName)

}
catch {
    Write-Host "An error occurred:"
    Write-Host $_
}
finally {
    Set-Location -Path $scriptPath
}