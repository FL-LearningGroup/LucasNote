class GitPRModule {
    <# Define the class. Try constructors, properties, or methods #>
    [string]$ModuleName
    [string]$ModuleFolder
    [string]$BranchName
    [string]$Status
    [string]$PRUrl
    [string]$Comments
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
    Write-Host "[Git] checkout to $Branch branch"
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

function DeleteGitBranch {
    param (
        [string]
        $BaseBranch,

        [string]
        $Branch
    )
    if (GetGitCurrentBranch -eq $BaseBranch) {
        throw "Cannot $BaseBranch branch, becase it's base branch"
    }
    Write-Host "[Git] git branch -D $Branch"
    $result = ((git branch -D $Branch) 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw ($result | Out-String)
    }
}

function CleanGitBranch() {
    param(
        [string]
        $Message
    )
    Write-Host '[Git] git checkout . & git clean -xdf'
    $result = ((git checkout . ) 2>&1)
    $result = ((git clean -xdf ) 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw ($result | Out-String)
    }
}

function  PushGitBranch {
    param (
        [string]
        $Remote,

        [string]
        $Branch
    )

    Write-Host "[Git] git push $Remote $Branch"
    $result = ((git push $Remote $Branch) 2>&1)
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
    $prBody = "
<!-- DO NOT DELETE THIS TEMPLATE -->
## Description

<!-- Please add a brief description of the changes made in this PR. If you have an ongoing or finished cmdlet design, please paste the link below. -->

## Checklist

- [x] Check this box to confirm: **I have read the [_Submitting Changes_](../blob/main/CONTRIBUTING.md#submitting-changes) section of [`CONTRIBUTING.md`](../blob/main/CONTRIBUTING.md) and reviewed the following information:**

* **SHOULD** select appropriate branch. Cmdlets from Autorest.PowerShell should go to [`generation`](https://github.com/Azure/azure-powershell/tree/generation) branch. 
* **SHOULD** make the title of PR clear and informative, and in the present imperative tense. 
* **SHOULD** update `ChangeLog.md` file(s) appropriately
    * For any service, the `ChangeLog.md` file can be found at `src/{{SERVICE}}/{{SERVICE}}/ChangeLog.md`
    * A snippet outlining the change(s) made in the PR should be written under the `## Upcoming Release` header in the past tense. Add changelog in description section if PR goes into [`generation`](https://github.com/Azure/azure-powershell/tree/generation) branch.
    * Should **not** change `ChangeLog.md` if no new release is required, such as fixing test case only.
* **SHOULD** have approved design review for the changes in [this repository](https://github.com/Azure/azure-powershell-cmdlet-review-pr) ([_Microsoft internal only_](../blob/main/CONTRIBUTING.md#onboarding)) with following situations
    * Create new module from scratch
    * Create new resource types which are not easy to conform to [Azure PowerShell Design Guidelines](../blob/main/documentation/development-docs/design-guidelines)
    * Create new resource type which name doesn't use module name as prefix
    * Have design question before implementation
* **SHOULD** regenerate markdown help files if there is cmdlet API change. [Instruction](../blob/main/documentation/development-docs/help-generation.md#updating-all-markdown-files-in-a-module)
* **SHOULD** have proper test coverage for changes in pull request.
* **SHOULD NOT** introduce [breaking changes](../blob/main/documentation/breaking-changes/breaking-changes-definition.md) in Az minor release except preview version.
* **SHOULD NOT** adjust version of module manually in pull request"

    $scriptPath = $PSScriptRoot
    $modulePath = '/Users/aitest/Documents/LucasGitHub/azure-powershell/src'
    $azurePowerShellRepoUrl = 'https://github.com/Azure/azure-powershell'
    
    $whiteModules = (Get-Content -Path (Join-Path $PSScriptRoot 'ReplaceAzurePowerShellModelDocUrl.config.json') | ConvertFrom-Json).whiteModules
    $gitPRModuleList = @()
    $notModuleFolders = @('lib','shared')
    # target folders under the module folder.
    # $targetFolders = @('help', 'examples', 'custom')
    $excludeFiles = @('ChangeLog.md')

    Set-Location -Path $modulePath
    $moduleFolders = (Get-ChildItem -Path . -Directory -Exclude $notModuleFolders) | Where-Object {$whiteModules -contains $_.Name }
    
    foreach($moduleFolder in $moduleFolders) {
        $gitPRModule = [GitPRModule]::new()
        $gitPRModule.ModuleName = $moduleFolder.Name
        $gitPRModule.ModuleFolder = $moduleFolder.FullName
        $gitPRModule.BranchName =  "$($moduleFolder.Name)/helpurl"
        $gitPRModule.Status = 'Failed'
        $gitPRModuleList += $gitPRModule
    }
    foreach($gitPRModule in $gitPRModuleList) {
        try {
            if (!(IscleanGitBranch)) {
                throw "The $(GetGitCurrentBranch) current branch is not clean, please clean it."
            }
            if ((IsExistGitBranch -Branch $gitPRModule.BranchName)) {
                throw "The $($gitPRModule.BranchName) is exist yet"
            }

            (CreateGitBranch -Branch $gitPRModule.BranchName)
        } catch {
            $gitPRModule.Status = 'Failed'
            $gitPRModule.comments = ($_ | Out-String)
            continue
        }
        try {
            (SwitchGitBranch -Branch $gitPRModule.BranchName)
            $moduleFileList = (Get-ChildItem -Path $gitPRModule.ModuleFolder -File -Recurse -Exclude $excludeFiles)
            foreach($moduleFile in $moduleFileList) {
                # "https://docs.microsoft.com/powershell","https://learn.microsoft.com/powershell"
                (ReplaceFileContent -OldContent 'https://docs.microsoft.com/powershell' -NewContent 'https://learn.microsoft.com/powershell' -FilePath $moduleFile.FullName)
            }

            (AddGitChanged)
            $message = "[main - $($gitPRModule.ModuleName)] domain name of online doc is changed from docs.microsoft.com to learn.microsoft.com."
            (CommitGitChanged -Message $message)
            (PushGitBranch -Remote 'origin' -Branch $gitPRModule.BranchName)
            $pr = New-GitHubPullRequest -Uri $azurePowerShellRepoUrl -Head $gitPRModule.BranchName -Base 'main' -Title $message -Body $prBody
            $gitPRModule.PRUrl = $pr.url
            $gitPRModule.Status = 'Success'
            SwitchGitBranch -Branch 'main'

            $gitPRModule | Format-Table
        } catch {
            $gitPRModule.Status = 'Failed'
            $gitPRModule.comments = ($_ | Out-String)
            CleanGitBranch
            SwitchGitBranch -Branch 'main'
            DeleteGitBranch -BaseBranch 'main' -Branch $gitPRModule.BranchName
        }
    }


} catch {
    Write-Error "An error ocurred"
    Write-Error ($_ | Out-String)
} finally {
    try {
        (SwitchGitBranch -Branch "main")
    } catch {
        Write-Error "An error ocurred"
        Write-Error ($_ | Out-String)
    }
    Set-Location $scriptPath
    $resultFilePath = "az-domain-replaced-$((Get-Date).ToString('yyyyMMddHHmmss')).csv"
    Write-Host "The output result to the $resultFilePath"
    $gitPRModuleList | Export-Csv -Path  $resultFilePath -NoClobber
}
