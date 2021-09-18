<#
-------Design------
+ Search two depth of the table of contents.
+ First leve: folder
+ Second leve: folder or file
+ README.md of the folder incode it's description.
+ Generate table of content insert into README.md under root path.
--------------------

-------Thinks-------
+ For code can be extended
The search depth can be scale.
-------Steps-------
+ Get 
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$false,
    HelpMessage="The Depth parameter determines the number of subdirectory levels that are included in the recursion and displays the contents.")]
    [int]
    $Depth = 1
    
)

$rootPath = $PSScriptRoot | Split-Path
$outFilePath = Join-Path $rootPath 'README.md'

Write-Host "test root path: " + $rootPath
Write-Host "test outfile path: " + $outFilePath
try {
    # Get black list of the table of contents.
    $contentsBlackList = (Get-Content -Path (Join-Path $PSScriptRoot 'TableOfContentsConfiguration.json' -ErrorAction Stop) | ConvertFrom-Json).blcakList

    $contents = Get-ChildItem -Path $rootPath -Depth $Depth -ErrorAction Stop | Sort-Object FullName

    # Remove unnecessary item
    foreach($black  in $contentsBlackList) {
        $contents = $contents | Where-Object {$_.Name -ne $black}
    }
    # Remove README.md of the root.
    $contents = $contents | Where-Object {$_.FullName -ne $outFilePath}

    # Add parent property for recurse generate the table of contents.
    $contents | Add-Member -NotePropertyName UplevelPath -NotePropertyValue $null
    for($index=0; $index -lt $contents.Count; $index++) {
        $contents[$index].UplevelPath = $contents[$index].FullName | Split-Path
    }
    $contents | Select-Object -Property FullName, UplevelPath, Parent

    $contentsHashTable = @{}

    # 
    $contentObject = New-Object -TypeName psobject
    $contentObject | Add-Member -NotePropertyName Title -NotePropertyValue 'None'
    $contentObject | Add-Member -NotePropertyName Descript -NotePropertyValue 'None'
    $contentObject | Add-Member -NotePropertyName NextContent -NotePropertyValue 'None'

    foreach($content in $contents) {
       if ($content.UplevelPath -eq $rootPath) {
            $contentsHashTable
       }
    }
}
catch {
    throw
}
