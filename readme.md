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

#### 1.2.3 Processing data

__Sorting Objects__

```Get-ChildItem```

<pre>

    Directory: D:\drs\Powershell\Windows_PowerShell_In_Action\ch01_WelcomeToPowerShell

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            9/4/2023 11:26 AM            133 001_Get_RSS_Channel.ps1
-a---            9/4/2023 11:37 AM            283 002_WinForms_Example.ps1
-a---            9/4/2023 12:02 PM             18 foo.txt
-a---            9/4/2023 11:46 AM             44 somefile.txt
</pre>

```Get-ChildItem | sort -Descending```

<pre>

    Directory: D:\drs\Powershell\Windows_PowerShell_In_Action\ch01_WelcomeToPowerShell

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            9/4/2023 11:46 AM             44 somefile.txt
-a---            9/4/2023 12:02 PM             18 foo.txt
-a---            9/4/2023 11:37 AM            283 002_WinForms_Example.ps1
-a---            9/4/2023 11:26 AM            133 001_Get_RSS_Channel.ps1
</pre>

```Get-ChildItem | sort -Property length```

<pre>
    Directory: D:\drs\Powershell\Windows_PowerShell_In_Action\ch01_WelcomeToPowerShell

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            9/4/2023 12:02 PM             18 foo.txt
-a---            9/4/2023 11:46 AM             44 somefile.txt
-a---            9/4/2023 11:26 AM            133 001_Get_RSS_Channel.ps1
-a---            9/4/2023 11:37 AM            283 002_WinForms_Example.ps1
</pre>

__Selecting Properties from an Object__

```
$a = Get-ChildItem | sort -Property length -Descending | Select-Object -First 1
$a
```

<pre>
    Directory: D:\drs\Powershell\Windows_PowerShell_In_Action\ch01_WelcomeToPowerShell

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            9/4/2023 11:37 AM            283 002_WinForms_Example.ps1
</pre>

```
$a = Get-ChildItem | sort -Property length -Descending | Select-Object -First 1 -Property Directory
$a
```

<pre>
Directory
---------
D:\drs\Powershell\Windows_PowerShell_In_Action\ch01_WelcomeToPowerShell
</pre>

__Processing with the ForEach-Object CmdLet__

```
$total = 0
Get-ChildItem | ForEach-Object { $total += $_.length }
$total
```
Result: 478

__Processing Other Kinds of Data__

```Get-ChildItem | sort -Descending length | select -First 3```

<pre>
    Directory: D:\drs\Powershell\Windows_PowerShell_In_Action\ch01_WelcomeToPowerShell

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            9/4/2023 11:37 AM            283 002_WinForms_Example.ps1
-a---            9/4/2023 11:26 AM            133 001_Get_RSS_Channel.ps1
-a---            9/4/2023 11:46 AM             44 somefile.txt
</pre>

```Get-Process | sort -Descending ws | select -First 3```

<pre>
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      0 2,214.45   2,102.65       0.00   34092   0 vmmem
      0     2.76     420.94       0.00    3300   0 Memory Compression       
     67   300.09     383.40     258.34   35580   2 chrome
</pre>

#### 1.2.4 Flow-Control statements

```
$i = 0
while ( $i++ -lt 10) { if ($i % 2) { "$i is odd" } }
```

<pre>
1 is odd
3 is odd
5 is odd
7 is odd
9 is odd
</pre>

The range operator generates a sequence of numbers.

```1..10 | foreach { if ($_ % 2) { "$_ is odd" }}```

<pre>
1 is odd
3 is odd
5 is odd
7 is odd
9 is odd
</pre>

#### 1.2.5 Scripts and functions

```
param($name = 'bub')
"Hello $name, how are you?"
```

```.\hello```
<pre>Hello bub, how are you?</pre>

```.\hello Dave```
<pre>Hello Dave, how are you?</pre>

```
function hello { 
    param($name = "bub")
    "Hello $name, how are you"
}

hello
hello Dave
```

<pre>Hello bub, how are you
Hello Dave, how are you</pre>

#### 1.2.6 Remote administration

The core of PowerShell remoting is Invoke-Command (aliased to _icm_). This command allows you to invoke a block of PowerShell script on the current computer. on a remote computer, or on a thousand remote computers.

Invoke-Command -ScriptBlock { _powershell commands_ } -ComputerName _remote-computer-name_

When you want to connect to a machine to interact with it on a one-to-one basis, you use the __Enter-PSSession__ command.

Enter-PSSession -ComputerName _remote-computer-name_

### 1.3 Core Concepts

Based on the Korn shell. PowerShell syntax is aligned with C#.  
PowerShell code can be migrated to C# when necessary for performance improvements.

#### 1.3.1 Command concepts and terminology

#### 1.3.2 Commands and cmdlets

Commands are the fundamental part of any shell language.

```command -parameter -parameter2 argument1 argument2```

PowerShell parameters correspond to the keywords, and arguments correspond to the values.

A parameter starts with a dash followed b the name of the parameter. An argument is the value
that will be associated with the parameter.

Positional parameters 

Quotes keep a value from being treated as a parameter.

Switch parameters are parameters that don't require a value. A good example is the _-Recurse_ parameter
for the Get-ChildItem command

```Get-ChildItem -Recurse -Filter c*d.exec C:\Windows```


#### 1.3.3 Command categories

* Cmdlets (names of the form Verb-Noun)
* Functions (named piece of PowerShell script)
* Scripts (lives in a text file with .ps1 file extension)
* Native applications
    * The PowerShell interpreter, PowerShell.exe, is a native command.
* Desired State Configuration

Run a child PowerShell process example:

powershell { Get-Process *ss } | Format-Table name, handles

This is useful if you want isolation so that the child process can't impact the parent process environment.

