<#
.SYNOPSIS
Count the number of files containing strings in specifiy folder.
#>
class FolderParallelSync {
    [int]$Id
    [string]$ModuleName
    [string]$FolderPath
}

try {
    $scriptPath = $PSScriptRoot
    $topFolderPath = "C:\Users\v-diya\repository\azure-powershell\Main\azure-powershell\src"
    Set-Location -Path $topFolderPath 
    $moduleParallelDataSet = @();
    $id = 0;
    foreach($moduleFolderPath in (Get-ChildItem -Path $topFolderPath -Directory).FullName) {
        $moduleParallel = [FolderParallelSync]::new()
        $moduleParallel.Id = $id++
        $moduleParallel.FolderPath = $moduleFolderPath
        $moduleParallel.ModuleName = $moduleFolderPath.Split('\')[-1]
        $moduleParallelDataSet += $moduleParallel
    }
    # Create a hashtable for process.
    # Keys should be ID's of the processes
    $origin = @{}
    $moduleSummaryOrigin = @{}
    foreach($dataSet in $moduleParallelDataSet) {
        $origin.($dataSet.Id) = @{}
        $moduleSummaryOrigin.($dataSet.ModuleName) = 0
    }
    # Create synced hashtable
    $sync = [System.Collections.Hashtable]::Synchronized($origin);
    $moduleSummarySync = [System.Collections.Hashtable]::Synchronized($moduleSummaryOrigin);
    

    $job = $moduleParallelDataSet | ForEach-Object -ThrottleLimit 3 -AsJob -Parallel {
        $syncCopy = $using:sync
        $moduleSummarySyncCopy = $using:moduleSummarySync
        # Set property id of the syncCopy address point process.
        $process = $syncCopy.$($PSItem.Id)
        # Pass value of the id of the dataset to property id of the process.
        $process.Id = $PSItem.Id
        $process.Activity = "Id $($PSItem.Id) $($PSItem.ModuleName) starting"
        $process.Status = "Processing"
        
        $filePathList = (Get-ChildItem -Path $PSItem.FolderPath -Recurse -File).FullName
        $filePathCount = $filePathList.Length
        for($fileNumber = 0;  $fileNumber -lt $filePathCount; $fileNumber++) {
            $process.Status = "Handling $($fileNumber + 1)/$filePathCount"
            $process.PercentComplete = (($fileNumber / $filePathCount) * 100)

            if(((Get-Content -Path $filePathList[$fileNumber]) | Out-String) -match 'https://docs.microsoft.com/powershell') {
                ($moduleSummarySyncCopy.$($PSItem.ModuleName))++
            }
        }
        $process.Completed = $true
    }
    while($job.State -eq 'Running')
    {
        $sync.Keys | Foreach-Object {
            # If key is not defined, ignore
            if(![string]::IsNullOrEmpty($sync.$_.keys))
            {
                # Create parameter hashtable to splat
                $param = $sync.$_
    
                # Execute Write-Progress
                Write-Progress @param
            }
        }
    
        # Wait to refresh to not overload gui
        Start-Sleep -Seconds 0.1
    }

    Write-Host -ForegroundColor Green "Summary result"
    $moduleSummaryOrigin | Sort-Object -Property name -Descending  

} catch {
    Write-Error "An error occurred"
    Write-Error ($_ | Out-String)
} finally {
    Set-Location $scriptPath
}