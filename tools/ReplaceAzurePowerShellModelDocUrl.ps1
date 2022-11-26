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
    $existBranchList = ((git branch --list) 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw "$($existBranchList | Out-String)"
    }
    foreach ($existBranch in $existBranchList) {
        if ($existBranch.Split(' ')[-1] -eq $Branch) {
            return $true
        }
    }

    return $false
}

function  IscleanGitBranch {

    $status = ((git status -s) 2>&1)

    if ($LASTEXITCODE -ne 0) {
        throw ($status | Out-String)
    }

    if ($null -eq $status) {
        return $true 
    }

    return $false
}
function GetGitCurrentBranch {
    Write-Host '[Git] Get current branch via execute git branch --show-current'
    $branch = ((git branch --show-current) 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw ($branch | Out-String)
    }
    return $branch
}

function CreateGitBranch {
    param(
        [string]
        $Branch
    )
    Write-Host "Create branch via execute git branch $Branch"
    $result = ((git branch $Branch) 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw ($result | Out-String)
    }
}

function SwitchGitBranch {
    param(
        [string]
        $Branch
    )
    Write-Host "[Git] checkout to new $Branch branch"
    $result = ((git checkout $Branch) 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw ($result | Out-String)
    }
}

function AddGitChanged {
    Write-Host '[Git] git add -A'
    $result = ((git add -A) 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw ($result | Out-String)
    }
}

function CommitGitChanged {
    param(
        [string]
        $Message
    )
    Write-Host '[Git] git commit'
    $result = ((git commit -m $Message) 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw ($result | Out-String)
    }
}

function ReplaceFileContent {
    param (
        [string]
        $OldContent,

        [string]
        $NewContent,

        [string]
        $FilePath
    )
    Write-Host "Replace $OldContent to $NewContent in $FilePath"
    $fileContent = (Get-Content -Path $FilePath -Raw)
    if ($fileContent -match $OldContent) {
        $fileContent -replace $OldContent, $NewContent | Set-Content -Path $FilePath -NoNewline
    }
     
}

try {
    $env:GIT_REDIRECT_STDERR = '2>&1'
    $scriptPath = $PSScriptRoot
    $modulePath = '/Users/aitest/Documents/LucasGitHub/azure-powershell/src'

    Set-Location -Path $modulePath

    $gitPRModuleList = @()
    $notModuleFolders = @('lib','shared')
    # target folders under the module folder.
    # $targetFolders = @('help', 'examples', 'custom')
    $excludeFiles = @('ChangeLog.md')
    $moduleFolders = (Get-ChildItem -Path $rootPath -Directory -Exclude $notModuleFolders)
    foreach($moduleFolder in $moduleFolders) {
        $gitPRModule = [GitPRModule]::new()
        $gitPRModule.ModuleName = $moduleFolder.Name
        $gitPRModule.ModuleFolder = $moduleFolder.FullName
        $gitPRModule.BranchName =  "$($moduleFolder.Name)/helpurl"
        $gitPRModuleList += $gitPRModule
    }
    foreach($gitPRModule in $gitPRModuleList) {
        if ($gitPRModule.ModuleName -ne "Accounts") {
            break
        }
        if (!(IscleanGitBranch)) {
            throw "The $(GetGitCurrentBranch) current branch is not clean, please clean it."
        }
        if ((IsExistGitBranch -Branch $gitPRModule.BranchName)) {
            throw "The $($gitPRModule.BranchName) is exist yet"
        }

        (CreateGitBranch -Branch $gitPRModule.BranchName)

        (SwitchGitBranch -Branch $gitPRModule.BranchName)
        $moduleFileList = (Get-ChildItem -Path $gitPRModule.ModuleFolder -File -Recurse -Exclude $excludeFiles)
        foreach($moduleFile in $moduleFileList) {
            # "https://docs.microsoft.com/powershell","https://learn.microsoft.com/powershell"
            (ReplaceFileContent -OldContent 'https://docs.microsoft.com/powershell' -NewContent 'https://learn.microsoft.com/powershell' -FilePath $moduleFile.FullName)
        }

        (AddGitChanged)
        (CommitGitChanged -Message "[main - $($gitPRModule.ModuleName)] domain name of online doc is changed from docs.microsoft.com to learn.microsoft.com.")
        
    }


} catch {
    Write-Error "An error ocurred"
    Write-Error ($_ | Out-String)
} finally {
    Set-Location $scriptPath
}
