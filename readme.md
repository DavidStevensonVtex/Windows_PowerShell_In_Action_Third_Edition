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

#### 1.3.4 Aliases and elastic syntax

The _dir_ command is an alias for _Get-ChildItem_.

```Get-Command dir```
<pre>CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           dir -> Get-ChildItem                                                </pre>

```Get-Command Get-ChildItem```
<pre>CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Get-ChildItem                                      7.0.0.0    Microsoft.PowerShell.Management</pre>

To see all the information, pipe the output of Get-Command into fl.

```Get-Command fl```
<pre>CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           fl -> Format-List                                       </pre>

```Get-Command gcm,gci,ii```
<pre>CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           gcm -> Get-Command
Alias           gci -> Get-ChildItem
Alias           ii -> Invoke-Item</pre>

Aliases in PowerShell are limited to aliasing the command name only. Unlike in other ystems such as Ksh, Bash and Zsh,
PowerShell aliases can't include parameters.

There is a second type of alias used in PowerShell. _parameter_. Unlike command aliases, which can be created by end users,
parameter aliases are created by the author of a cmdlet, script, or function.

A parameter alias is a shorter name for a parameter.

### 1.4 Parsing the PowerShell language

#### 1.4.1 How PowerShell parses

#### 1.4.2 Quoting

Putting single quotes around an entire sequence of characters causes them to be treated like a single string. 
This is how you deal with file paths that have spaces in them, for example.

```Set-Location 'C:\Program Files' ```

Quoting a single character can be done with the backquote / backtick character
<pre>Set-Location C:\Program` Files</pre>

__What is the difference between single and double quotes?

In double quotes, varaibles are expanded. If the double-quoted string contains 
a variable reference starting with a $, it will be replaced by a string representation
of the value stored in the value.

```
$files = "files"
Set-Location "C:\Program $files"
Write-Output "`$files is `n'$files'"
```
abc
[About Escape Characters](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_special_characters?view=powershell-7.3)

#### 1.4.3 Expression-mode and command-mode parsing

```
Write-Output -this -is -a parameter
-this
-is      
-a       
parameter
```

#### 1.4.4 Statement termination
In PowerShell, there are two statement terminator characters: the semicolon (;) and (sometimes) the newline.

The rule is that if the previous text is a syntactically complete statement a newline is considered to be a
statement termination. If it isn't complete, the newline is treated like any other whitespace.

A line can be extended with the backtick character.

```
Write-Output "Hello
>> there
>> how are
>> you?"
Hello
there
how are
you?
```

#### 1.4.5 Comment syntax in PowerShell

PowerShell comments begin with a number sign (#) and continue to the end of the line.
The # character must be at the beginning of a token for it to start a comment.

```
echo hi#there
>>
hi#there
```

```
echo hi #there
hi
```

__Multiline Comments__

A multiline comment begins with <# and ends with #>.

```
<#
This is a comment
   that spans 
   multiple lines
#>
```