## Server SSL Enable

+ 使用浏览器访问Server
以windows为例:

1. 首先需要获取.cer文件。获取方法
![image](https://github.com/FL-LearningGroup/Network/blob/main/ExportCertFile.JPG)

2. 导入.cer到Trusted Root Certification Authorities.导入方法。
https://docs.fortinet.com/document/fortiauthenticator/5.5.0/cookbook/494798/manually-importing-the-client-certificate-windows-10
**summary**:

    a. Open Command Prompt and type mmc and hit Enter to open MMC.

    b. Go to File menu, click Add/Remove Snap In, and add the Certificates snap-in for Local Computer.

    c. Once added, right-click in the middle window and select All Tasks > Import.
