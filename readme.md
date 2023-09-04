# Windows PowerShell In Action, Third Edition

## Chapter 1: Welcome to PowerShell

Hello World

```'Hello world.'```

```
Get-ChildItem -Path $env:windir\*.log | Select-String -List error | Format-Table Path, LineNumber -AutoSize 
```

<pre>
Path                      LineNumber
----                      ----------
C:\WINDOWS\DtcInstall.log          1
C:\WINDOWS\iis_gather.log        354
Select-String: The file C:\WINDOWS\iis.log cannot be read: Access to the path 'C:\WINDOWS\iis.log' is denied.
C:\WINDOWS\setupact.log            9
</pre>