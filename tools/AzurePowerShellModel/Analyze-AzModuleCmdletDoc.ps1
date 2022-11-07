try {
$docFilePath = "C:\Users\v-diya\repository\azure-powershell\ImportExport\azure-powershell\src\ImportExport\docs\Update-AzImportExport.md"
# Get file content to string
$fileContent = Get-Content -Path $docFilePath | Out-String -NoNewline
$syntax = $fileContent.Substring($fileContent.IndexOf('## SYNTAX'), $fileContent.IndexOf('## DESCRIPTION') - $fileContent.IndexOf('## SYNTAX'))
$examples  = $fileContent.Substring($fileContent.IndexOf('## SYNTAX'), $fileContent.IndexOf('## DESCRIPTION') - $fileContent.IndexOf('## SYNTAX'))
} catch {
    Write-Error ($_ | Out-String)
}