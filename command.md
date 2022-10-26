# Powershell
```powershell
# Listing all of the assemblies loaded in a PowerShell session
PS C:\Users\v-diya> [System.AppDomain]::CurrentDomain.GetAssemblies() | Where-Object Location | Sort-Object -Property FullName | Select-Object -Property FullName, Location, GlobalAssemblyCache, IsFullyTrusted | Out-GridView
```
