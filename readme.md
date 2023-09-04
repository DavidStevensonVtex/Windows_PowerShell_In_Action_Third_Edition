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

### 1.2 PowerShell Example code

```Get-ChildItem -Path .\somefile.txt```

<pre>
Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            9/4/2023 11:46 AM             44 somefile.txt
</pre>

#### 1.2.1 Navigation and basic operations

```Get-Help dir```

```Get-Help Get-ChildItem -Online```

#### 1.2.2 Basic expressions and variables

```
(2+2)*3/7 > .\foo.txt
Get-Content .\foo.txt
```

Result: 1.71428571428571

```
$n = (2+2) * 3
$n
```

Result: 12

