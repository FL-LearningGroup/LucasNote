# help link

https://www.cnblogs.com/aurora-ql/p/14347519.html

# 通过注册表进行配置

将以下代码保存为[vscode].reg文件然后运行。

**注意vs code本地安装路径**

```reg
Windows Registry Editor Version 5.00


[HKEY_CLASSES_ROOT\*\shell\VSCode]
@="open with vscode"
"Icon"="C:\\Users\\v-diya\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe"

[HKEY_CLASSES_ROOT\*\shell\VSCode\command]
@="\"C:\\Users\\v-diya\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe\" \"%1\""

Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\shell\VSCode]
@="open with vscode"
"Icon"="C:\\Users\\v-diya\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe"

[HKEY_CLASSES_ROOT\Directory\shell\VSCode\command]
@="\"C:\\Users\\v-diya\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe\" \"%V\""

Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\Background\shell\VSCode]
@="open with vscode"
"Icon"="C:\\Users\\v-diya\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe"

[HKEY_CLASSES_ROOT\Directory\Background\shell\VSCode\command]
@="\"C:\\Users\\v-diya\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe\" \"%V\""
```