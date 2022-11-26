$rootPath = "/Users/aitest/Documents/LucasGitHub/azure-powershell/src"

class GitPRModule {
    <# Define the class. Try constructors, properties, or methods #>
    [string]$ModuleName
    [string]$ModuleFolder
    [string]$BranchName
    [string]$PRUrl
}

function  IsExistGitBranch {
    param (
        [string]
        $Branch
    )
    Write-Host "[Git] Check $Branch branch whether exist in local repo"
    $existBranchList = (git branch --list)
    if ($LASTEXITCODE -ne 0) {
        throw "`n$($existBranchList | Out-String)"
    }
    foreach ($existBranch in $existBranchList) {
        if ($existBranch.Split(' ')[-1] -eq $Branch) {
            return $true
        }
    }

    return $false
}

function  IsClearGitBranch {
    param (
        [string]
        $Branch
    )
    $status = (git status -s)

    if ($LASTEXITCODE -ne 0) {
        throw ($status | Out-String)
    }

    if ($null -eq $status) {
        return $true 
    }

    return $false
}
function GetGitCurrentBranch() {
    Write-Host "[Git] Get current branch via execute git branch --show-current"
    $branch = (git branch --show-current)
    if ($LASTEXITCODE -ne 0) {
        throw ($branch | Out-String)
    }
    return $branch
}

function CreateGitBranch() {
    param(
        [string]
        $Branch
    )

    if ((IsExistGitBranch -Branch $Branch)) {
        throw "[Git] $Branch branch exits yet"
    }

    Write-Host "Create branch via execute git branch $Branch"
    $result = (git branch $Branch)
    if ($LASTEXITCODE -ne 0) {
        throw ($result | Out-String)
    }
}

function SwitchGitBranch() {
    param(
        [string]
        $Branch
    )
    Write-Host "[Git] checkout to new $Branch branch"
    $result = (git checkout $Branch)
    if ($LASTEXITCODE -ne 0) {
        throw ($result | Out-String)
    }
}

function AddGitChanged() {
    Write-Host "[Git] git add -A"
    $result = (git add -A)
    if ($LASTEXITCODE -ne 0) {
        throw ($result | Out-String)
    }
}

function CommitGitChanged() {
    param(
        [string]
        $Message
    )
    Write-Host "[Git] git add -A"
    $result = (git commit -m $Message)
    if ($LASTEXITCODE -ne 0) {
        throw ($result | Out-String)
    }
}

function ReplaceFileContent {
    [string]
    $oldContent,

    [string]
    $newContent

    [string]
    $FilePath


    Get-Content -Path $FilePath -Raw
}

try {
    $gitPRModuleList = @()
    $excloudeFolders = @("lib","shared")
    $moduleFolders = (Get-ChildItem -Path $rootPath -Directory -Exclude $excloudeFolders)
    foreach($moduleFolder in $moduleFolders) {
        $gitPRModule = [GitPRModule]::new()
        $gitPRModule.ModuleName = $moduleFolder.Name
        $gitPRModule.ModuleFolder = $moduleFolder.FullName
        $gitPRModule.BranchName =  "$($moduleFolder.Name)\helpurl"
    }

}catch {
    Write-Error "An error ocurred"
    Write-Error ($_ | Out-String)
}
