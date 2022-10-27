function  CleanBranch() {
    $currentBranchStatus = (git status)
    if($currentBranchStatus[-1] -ne "nothing to commit, working tree clean") {
        if ((Read-Host "Need to abort unstage files(Yes/No)") -eq "Yes") {
            Write-Host "Execute git checkout ."
            (git checkout .)
        }else {
            ExitScript
        }
        
        
        if ((Read-Host "Need to abort untrack files(Yes/No)") -eq "Yes") {
            Write-Host "Execute git clean -fxd"
            (git clean -fxd)
        }else {
            ExitScript
        }

    }
}


function PushCode {
    param (
        [string[]]
        $ModuleNameList,
        
        [string]
        $RemoteRepo,

        [string]
        $RemoteBranch
    )
    Write-Host "Push $RemoteBranch code to remote repoistory"
    $null = (git add -A)
    $null = (git commit -m "[$($ModuleNameList -join '|')]update docs help url by auto script")
    $null = (git push $RemoteRepo $RemoteBranch)
}

# param: BranchName
# Return: True that branch exo, false,
function  IsBranchExist {
    param (
        $BranchName
    )
    $branchList = (git branch) | ForEach-Object -Process {$_.Split(' ')[-1]}
    if ($branchList -contains $BranchName) {
        Write-Host "$BranchName branch exist yet."
        if ((Read-Host "Are you sure you want to delete $BranchName branch(Yes/No)") -eq 'Yes') {
            $null = (git branch -D $BranchName)
            return $false
        } else {
            return $true
        }
        
    } else {
        return $false
    }
}

function ExitScript() {
    Write-Host "Exit script"
    exit
}

$scriptPath = $PSScriptRoot
$repoPath = "C:\Users\v-diya\repository\azure-powershell\Main\azure-powershell"
Set-Location -Path $repoPath 
$remoteRepo = 'origin'
$moduleNameList = @('Compute')
$branchName = 'Compute-auto-docs'
$excludeFileList = @('Changelog.md')

try {

    # Get current branch
    $currentBranch = (git branch --show-current) 
    Write-Host "Current branch $currentBranch"
    
    if ($currentBranch -ne 'main') {
        CleanBranch
        Write-Host "Switch to main branch"
        git checkout main
    }
    # Clean main branch
    CleanBranch

    Write-Host "Pull main branch"
    $null = (git pull)

    if ((IsBranchExist -BranchName $branchName)) {
        if ((Read-Host "Need enter new branch name(Yes/No)") -eq "Yes") {
            $branchName = (Read-Host "please enter new branch name, the branch name cannot include '\' or '/")
        }
        
    }
    Write-Host "Create new and Checkout to $branchName"
    $null = (git checkout -b $branchName)


    foreach($moduleName in $moduleNameList) {
        $modulePath = Join-Path $repoPath "src\$moduleName"
        if(Test-Path -Path $modulePath) {
            $filePaths = (Get-ChildItem -Path (Join-Path $repoPath "src\$moduleName") -Recurse -File -Exclude $excludeFileList).FullName
            foreach($filePath in $filePaths) {
                $fileContent = Get-Content -Path $filePath -Raw
                # file content may be empty
                if (($null -ne $fileContent ) -and ($fileContent.Contains('https://docs.microsoft.com/powershell'))) {
                    $fileContent -replace 'https://docs.microsoft.com/powershell', 'https://learn.microsoft.com/powershell' | Set-Content -Path $filePath -Force
                }
            }
        }else {
            throw " $modulePath no exits"
        }     
    }

    $currentBranchStatus = (git status)
    $currentBranchStatus > (Join-Path $scriptPath "$branchName.txt")

    if($currentBranchStatus[-1] -eq "nothing to commit, working tree clean") {
        Write-Host "No file changed. No https://docs.microsoft.com/powershell url need replace."
        ExitScript
    }

    PushCode -ModuleNameList $moduleNameList -RemoteRepo $remoteRepo -RemoteBranch $branchName

}
catch {
    Write-Error "An error occurred:"
    Write-Error ($_ | Out-String)
    CleanBranch
    (git checkout main)
    Write-Host "Delete branch $branchName"
    (git branch -D $branchName)

}
finally {
    Set-Location -Path $scriptPath
}