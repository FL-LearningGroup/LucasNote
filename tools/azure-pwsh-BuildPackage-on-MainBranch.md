Hybrid Module
This doc is for module which is part generated and part handcrafted.

Code Structure
.
+-- {module} // handcrafted part
|      +-- help // All the help files including auto generated ones will be moved to here
|      +-- Az.{module}.psd1 // Need to update psd1 to include both handcrafted psm1 and generated psm1 as nested modules  
|      +...
+-- {module}.Autorest // auto gen part
|      +-- A̵z̵.̵{̵m̵o̵d̵u̵l̵e̵}̵.̵p̵s̵d̵1̵ // Currently, this file is removed because of a pipeline limitation. Will need to add it back because test of auto-gen requires it.
|      +...
+-- {module}.sln
+-- {module}.Test
Major changes
{module}.Autorest/Az.{module}.csproj
<Import Project="$(MSBuildThisFileDirectory)..\..\Az.autorest.hybrid.props" /> // need to import Az.autorest.hybrid.props
{module}.sln
Project("{9A19103F-16F7-4668-BE54-9A1E7A4F7556}") = "Az.{module}", "{module}.Autorest\Az.{module}.csproj", "{9C271BA4-C9F6-4736-995F-3D606FBCFDCC}" // add the generated project
EndProject
{module}/Az.{module}.psd1
#̵ ̵R̵o̵o̵t̵M̵o̵d̵u̵l̵e̵ ̵=̵ ̵'̵'̵  // need to remove this line
RequiredAssemblies = 'Microsoft.Azure.Management.{module}.dll', '{module}.Autorest\bin\Az.{module}.private.dll' // need to load Az.{module}.private.dll
...
FormatsToProcess = '{module}.format.ps1xml', '{module}.Autorest\Az.{module}.format.ps1xml' // need to load auto gen ps1xml
...
NestedModules = 'Az.{module}.psm1', '{module}.Autorest\Az.{module}.psm1' // load both modules as nested modules
...
FunctionsToExport = 'Get-xxx', 'New-xxx', 'Remove-xxx', 'Update-xxx' // Add functions from auto gen sub module

{module}/help/Az.{module}.md
Need to add auto gen cmdlets manually

Changes in tools folder
CleanupBuild.ps1
        foreach($cmdAssembly in $ModuleMetadata.NestedModules)
        {
+            # if the nested module is script module, we need to keep the dll behind the script module
+            if ($cmdAssembly.EndsWith(".psm1")) {
+                if (!$cmdAssembly.Contains("/") -and !$cmdAssembly.Contains("\")) {
+                    $acceptedDlls += "Microsoft.Azure.PowerShell.Cmdlets." + $cmdAssembly.Split(".")[-2] + ".dll"
+                }
+                continue
+            }
Tools.Common/Loaders/CmdletLoader.cs
GetModuleMetadata

            ModuleMetadata = new ModuleMetadata();

+        /// If assemble is not dll, return directly, in the future, except for dll, we should also support psm1
+            if (!assemblyPath.EndsWith("dll")) {
+                ModuleMetadata.Cmdlets = results;
+                return ModuleMetadata;
+            }
UpdateModules.psm1
function New-ModulePsm1

-                $importedModules += "Import-Module (Join-Path -Path `$PSScriptRoot -ChildPath " + $dll + ")`r`n"
+                if ($dll.EndsWith("dll")) {
+                    $importedModules += "Import-Module (Join-Path -Path `$PSScriptRoot -ChildPath " + $dll + ")`r`n"
+                } elseif ($dll -eq ($manifestDir.Name + ".psm1")) {
+                    $importedModules += "Import-Module (Join-Path -Path `$PSScriptRoot -ChildPath Microsoft.Azure.PowerShell.Cmdlets." + $manifestDir.Name.Split(".")[-1] + ".dll" + ")`r`n"
+                }
function Get-Cmdlets

-        $Assembly = [Reflection.Assembly]::LoadFrom($dllPath)
-        $dllCmdlets = $Assembly.GetTypes() | Where-Object {$_.CustomAttributes.AttributeType.Name -contains "CmdletAttribute"}
-        $cmdlets += $dllCmdlets
+        if ($dllPath.EndsWith("dll")) {
+            $Assembly = [Reflection.Assembly]::LoadFrom($dllPath)
+            $dllCmdlets = $Assembly.GetTypes() | Where-Object {$_.CustomAttributes.AttributeType.Name -contains "CmdletAttribute"}
+            $cmdlets += $dllCmdlets
+        }