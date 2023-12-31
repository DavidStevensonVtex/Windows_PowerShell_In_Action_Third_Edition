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

### 1.5 How the pipeline works

Each command in the pipeline receives an object from the previous command,
performs some operation on it, and then passes it along to the next command
in the pipeline.

#### 1.5.1 Pipelines and streaming behavior

In stream processing, objects are output from the pipeline as soon as they become available.

In a pipelined shell, the first result is returned as soon as it's available and subsequent
results return as they become available.

```
Get-Process | Where { $_.handles -gt 500 } | Sort handles | Format-Table
```

In owerShell, streaming is accomplished by splitting cmdlets into three clauses:
BeginProcessing, ProcessRecord, and EndProcessing.

#### 1.5.2 Parameters and parameter binding

_Parameter binding_ is the process in which values are bound to the parameters on a command.

These values can come from either the command line or the pipeline.

Example of parameter bound from the command line:
 ```Write-Output 123```

 Example of parameter bound from the pipeline
 ```123 | Write-Output```

 ```
 Trace-Command -Name ParameterBinding -Option All -Expression { 123 | Write-Output } -PSHost
 ```

<pre style='color: yellow'>
DEBUG: 2023-09-05 16:09:16.0342 ParameterBinding Information: 0 : BIND NAMED cmd line args [Write-Output]
DEBUG: 2023-09-05 16:09:16.0360 ParameterBinding Information: 0 : BIND POSITIONAL cmd line args [Write-Output]
DEBUG: 2023-09-05 16:09:16.0365 ParameterBinding Information: 0 : MANDATORY PARAMETER CHECK on cmdlet [Write-Output]
DEBUG: 2023-09-05 16:09:16.0369 ParameterBinding Information: 0 : CALLING BeginProcessing
DEBUG: 2023-09-05 16:09:16.0372 ParameterBinding Information: 0 : BIND PIPELINE object to parameters: [Write-Output]
DEBUG: 2023-09-05 16:09:16.0376 ParameterBinding Information: 0 :     PIPELINE object TYPE = [System.Int32]
DEBUG: 2023-09-05 16:09:16.0380 ParameterBinding Information: 0 :     RESTORING pipeline parameter's original values
DEBUG: 2023-09-05 16:09:16.0384 ParameterBinding Information: 0 :     Parameter [InputObject] PIPELINE INPUT ValueFromPipeline NO COERCION
DEBUG: 2023-09-05 16:09:16.0391 ParameterBinding Information: 0 :     BIND arg [123] to parameter [InputObject]
DEBUG: 2023-09-05 16:09:16.0394 ParameterBinding Information: 0 :         BIND arg [123] to param [InputObject] SUCCESSFUL
DEBUG: 2023-09-05 16:09:16.0398 ParameterBinding Information: 0 : MANDATORY PARAMETER CHECK on cmdlet [Write-Output]
DEBUG: 2023-09-05 16:09:16.0402 ParameterBinding Information: 0 : CALLING ProcessRecord
DEBUG: 2023-09-05 16:09:16.0405 ParameterBinding Information: 0 : CALLING EndProcessing
<span style='color: lightgreen; font-weight: bold;'>123</span>
 </pre>

### 1.6 Formatting and output

Use Format-Table and Format-List to give general guidance on the shape of the display, but no specific details.

```Get-ChildItem $PSHOME/*format* | Format-Table name```

<pre style='color: lightgreen ; font-weight: bold ;'>
Name
----
System.Formats.Asn1.dll
System.Formats.Tar.dll
System.Net.NetworkInformation.dll
System.Runtime.InteropServices.RuntimeInformation.dll
System.Runtime.Serialization.Formatters.dll
</pre>

#### 1.6.1 Formatting cmdlets

```Get-Command Format-* | Format-Table name```

<pre>
Name
----
Format-Volume
Format-Custom
Format-Hex
Format-List
Format-SecureBootUEFI
Format-Table
Format-Wide
</pre>

```Get-Item c:\ | Format-Table```
<pre>
    Directory: 

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d--hs            9/5/2023  3:27 PM
</pre>

You can achieve a better display with the -AutoSize parameter for Format-Table, but
this prevents streaming, as PowerShell has to process all rows before displaying any.

Typically, the default layout is good, and you don't need -Autosize.

```Get-ChildItem c:\ | Format-Table -AutoSize```

The Format-List command displays the elements of the objects as a list, one after the other.
If there's more than one object to display, they'll appear as a series of lists.

```Get-Item c:\ | Format-List```

<pre>
    Directory:

Name           : C:\
CreationTime   : 7/16/2016 2:04:24 AM
LastWriteTime  : 9/5/2023 3:27:56 PM
LastAccessTime : 9/5/2023 4:23:24 PM
Mode           : d--hs
LinkType       : 
Target         : 
</pre>

The Format-Wide cmdlet is used when you want to display a single object property in a concise way.

```Get-Process -Name s* | Format-Wide -Column 8 id```

The final formatter is Format-Custom, which displays objects while preserving the basic structure of the object.

```Get-Item c:\ | Format-Custom -Depth 1```
<pre>
class DirectoryInfo
{
  PSPath = Microsoft.PowerShell.Core\FileSystem::C:\
  PSParentPath =
  PSChildName = C:\
  PSDrive =
    class PSDriveInfo
    {
</pre>


#### 1.6.2 Outputter cmdlets

Output is automatically sent to Out-Default cmdlet.

The following 3 lines do exactly the same thing.

```
dir | Out-Default
dir | Format-Table
dir | Format-Table | Out-Default
```

__Out-Null__ is used to discard output.

Piping to Out-Null is the equivalent of redirecting to $null, 
but invokes the pipeline and can be up to 40 times slower than
redirecting to $null.

__Out-File__

This command sends output to a file rather than the screen.
Flags allow files to be appended instead of overwritten,
forcing writing to read-only files, and choosing output
[encodings](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file?view=powershell-7.3).

* ascii
* bigendianunicode: Encodes in UTF-16 format using the big-endian byte order.
* bigendianutf32: Encodes in UTF-32 format using the big-endian byte order.
* oem: Uses the default encoding for MS-DOS and console programs.
* unicode: Encodes in UTF-16 format using the little-endian byte order.
* utf7: Encodes in UTF-7 format.
* utf8: Encodes in UTF-8 format.
* utf8BOM: Encodes in UTF-8 format with Byte Order Mark (BOM)
* utf8NoBOM: Encodes in UTF-8 format without Byte Order Mark (BOM)
* utf32: Encodes in UTF-32 format.

Note: Tab completion can be used to cycle through the valid encodings.

__Out-Printer cmdlet__

__Out-Host cmdlet__

This cmdlet sends the output back to the host.
Hosts include the console and the Integrated Scripting Environment (ISE).

__Out-String cmdlet__

This cmdlet formats its input and sends it as a string to the next cmdlet in the pipeline.
String, not strings.

If you do want the output as a series of strings, use the -Stream switch parameter.

__Out-GridView cmdlet__

```Get-Process *ss | Out-Gridview```

## Chapter 2: Working with types

### 2.1 Type management in the wild, wild West

PowerShell is _dynamically typed_, meaning that the user provides little type iformation up front.

#### 2.1.1 Types and classes

* A _type_ is a description of an object.
* A _class_ is a PowerShell v5 keyword used to define a new type.
* A _property_ is an individual piece of data used to describe an object.
* A _method_ is a behavior of a class.
* A _member_ is a general term that includes both properties and methods.
* An _event_ is a special kind of method invoked by an occurrence and not invoked directly.

#### 2.1.2 PowerShell: A type-promiscuous language

By _type-promiscuous_, we mean that PowerShell will expend a tremendous amount of effort, much more
than a typical dynamic language, tyring to turn what you have into what you need with as little work
on your part as possible.

PowerShell is careful about making sure its transformations are reasonable and no information is
unexpectedly lost.

The .NET _Get-Type()_ method, or _Get-Member_, can be used to discover the type, properties and/or methods of an expression or object.

```
(2 + 3.0 + '4').GetType().FullName
```
Result: System.Double

_Discovering the type of an expression_

```(2 + 3.0 + '4') | Get-Member```

#### 2.1.3 Type system and type adaptation

There are three phases of member resolution: synthetic, native, and fallback.

__Synthetic Members__

PowerShell has an object wrapper, called PSObject, that allows the underlying object to be extended.

But it's also possible to build an object without any "native" properties.

__Native Members__

There are multiple native types, .NET being the primary, but also WMI and COM, where the type defines its members.
These members can be discovered by using the Get-Member cmdlet.

```Get-Date | Get-Member```

<pre>
   TypeName: System.DateTime

Name                 MemberType     Definition
----                 ----------     ----------
Add                  Method         datetime Add(timespan value)
AddDays              Method         datetime AddDays(double value)
AddHours             Method         datetime AddHours(double value)
...
DisplayHint          NoteProperty   DisplayHintType DisplayHint=DateTime
Date                 Property       datetime Date {get;}
Day                  Property       int Day {get;}
DayOfWeek            Property       System.DayOfWeek DayOfWeek {get;}
...
DateTime             ScriptProperty System.Object DateTime {get=if ((& { Set-StrictMode -Version 1; $this.DisplayHint }) -ieq  "Date")…
</pre>

__Fallback Members__

Fallback methods are defined by the PowerShell runtime itself.

Fallback members are used to solve interoperation problems with PowerShell workflow (v3), and as part of Desired State Configuration (v4).

#### 2.1.4 Finding the available types

The PowerShell runtime loads and uses many .NET (native) types.

Within the host process, the .NET runtime creats an Application Domain, or AppDomain. 
PowerShell is an application that runs inside an AppDomain.

```[System.AppDomain]::CurrentDomain.GetAssemblies()```

<pre>
GAC    Version        Location
---    -------        --------
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Private.CoreLib.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\pwsh.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Runtime.dll        
False  v4.0.30319     C:\Program Files\PowerShell\7\Microsoft.PowerShell.ConsoleHost.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Management.Automation.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Threading.Thread.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Diagnostics.Process.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Runtime.InteropServices.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Collections.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Threading.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Xml.ReaderWriter.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Private.Xml.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Text.RegularExpressions.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Text.Encoding.Extensions.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Collections.Concurrent.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Runtime.Numerics.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Security.Cryptography.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Net.Primitives.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Memory.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Linq.Expressions.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\Microsoft.Win32.Registry.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Private.Uri.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\Microsoft.Management.Infrastructure.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Net.NetworkInformation.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.DirectoryServices.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.ComponentModel.Primitives.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Security.AccessControl.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Net.Mail.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Management.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Collections.Specialized.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\Newtonsoft.Json.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.ComponentModel.TypeConverter.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\Microsoft.PowerShell.CoreCLR.Eventing.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.ObjectModel.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\Microsoft.Win32.Primitives.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Runtime.Serialization.Formatters.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Diagnostics.TraceSource.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Linq.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Runtime.Serialization.Primitives.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Data.Common.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.ComponentModel.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Reflection.Emit.Lightweight.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Reflection.Emit.ILGeneration.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Reflection.Primitives.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Console.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Security.Principal.Windows.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Security.Claims.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\Microsoft.ApplicationInsights.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\netstandard.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Diagnostics.DiagnosticSource.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Diagnostics.Tracing.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.IO.MemoryMappedFiles.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Private.Xml.Linq.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.IO.Pipes.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Threading.Tasks.Parallel.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.IO.FileSystem.AccessControl.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Xml.XDocument.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Threading.Overlapped.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.IO.FileSystem.DriveInfo.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Text.Encoding.CodePages.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\getfilesiginforedistwrapper.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Security.Permissions.dll
False
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Runtime.Loader.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Threading.ThreadPool.dll
False  v4.0.30319     C:\program files\powershell\7\Modules\PSReadLine\Microsoft.PowerShell.PSReadLine2.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\mscorlib.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\Microsoft.PowerShell.Commands.Management.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\Microsoft.PowerShell.Commands.Utility.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\Microsoft.PowerShell.MarkdownRender.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Net.Http.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Net.Security.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Core.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.dll
False  v4.0.30319     C:\program files\powershell\7\Modules\PSReadLine\net6plus\Microsoft.PowerShell.PSReadLine.Polyfiller.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Runtime.InteropServices.RuntimeInformation.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Net.Quic.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Net.Sockets.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Net.NameResolution.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Collections.NonGeneric.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Diagnostics.StackTrace.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\System.IO.Compression.dll
False  v4.0.30319     C:\Program Files\PowerShell\7\Microsoft.CSharp.dll
</pre>

```[System.AppDomain]::CurrentDomain.GetAssemblies().GetTypes()```

Too long.

```
[System.AppDomain]::CurrentDomain.GetAssemblies().GetTypes().Count
19246
```

```
function Find-Type {
    param ( [regex]$Pattern )

    [System.AppDomain]::CurrentDomain.GetAssemblies().GetTypes() | Select-String $Pattern
}
```

```Find-Type "DateTime"```

```[PowerShell].Assembly```

<pre>
GAC    Version        Location
---    -------        --------
False  v4.0.30319     C:\Program Files\PowerShell\7\System.Management.Automation.dll
</pre>

```[PowerShell].Assembly.Location```
C:\Program Files\PowerShell\7\System.Management.Automation.dll

PowerShell comes pretty much with "batteries included" with respect to the set of types you can use.

### 2.2 Basic types and literals

Literals include strings, numbers, arrays, dictionaries and hashtables.

#### 2.2.1 String literals

There are four kinds of string literals in PowerShell: single-quoted strings, double quoted strings, 
single-quoted here-strings, and double quoted here-strings.

```
$str1 = 'Single Quoted'
$str2 = "Double Quoted"

$strh1 = @'
Single
Quoted
'@

$strh2 = @"
Double
Quoted
"@

$strh2
```
Output:
```
Double
Quoted
```

In PowerShell, a string is a sequence of 16-bit Unicode characters and 
is directly implemented using the .NET System.String type.

__Single and Double Quoted Strings__

Literal strings can contain any character, including newlines, with the exception of an unquoted closing quote character.

Double-quoted strings (sometimes called _expandable strings_) support variable substitution.

```
$foo = "FOO" 
"This is a string in double quotes: $foo"
'This is a string in single quotes: $foo'
```
Output:
<pre>
This is a string in double quotes: FOO
'This is a string in single quotes: $foo'
</pre>

Expandable strings can also include arbitrary expressions by using the _subexpression_ notation.

```"Expanding three statements in a string $(1; 2; 3)"```
Output: Expanding three statements in a string 1 2 3

__Here-String Literals__

A here-string is used to embed large chunks of text inline in a script.

```
$a = @"
One is "1"
Two is '2'
Three is $(2+1)
The date is "$(Get-Date)"
"@
$a
```
<pre>
One is "1"
Two is '2'
Three is 3
The date is "09/06/2023 19:41:22"
</pre>

Here-strings start with @<quote>newline> and end with <newline><quote>@.

Here-strings come in single and double-quoted vesions like regular strings, with
the significant difference being that variables and subexpressions aren't expanded
in the single-quoted variant.

#### 2.2.2 Numbers and numeric literals

Example numeric literals
<pre>
1
0x1FE4
10000000000
1.1
1e3
[float] 1.3   # defaults to double without the cast
1d            # decimal suffix - d
1.123d
</pre>

__Multiplier Suffixes__

<pre>
kb or KB
mb or MB
gb or GB
tb or TB
pb or PB
</pre>

__Hexadecimal Literals__

<pre>
0x10
0xDeadBeef
</pre>

### 2.3 Collections: dictionaries and hashtables

The _hashtable_ data type lets you map a set of keys to a set of values.

A _dictionary_ is the general term for a data structure that maps keys to values.

#### 2.3.1 Creating and inspecting hashtables

```
$user = @{ FirstName = 'John' ; LastName = 'Smith' ; 
    PhoneNumber = '555-1212' }
$user
```

<pre>
Name                           Value
----                           -----
LastName                       Smith
FirstName                      John
PhoneNumber                    555-1212
</pre>

```
$user.firstname
$user["firstname"]
$user["firstname", "lastname"]
$user[$user.keys]
```

<pre>
$user.firstname
John

$user["firstname"]
John

$user["firstname", "lastname"]
John
Smith

$user[$user.keys]
Smith
John
555-1212
</pre>

#### 2.3.2 Ordered hashtables

Alphabetically ordered keys

```
$usero = [ordered] @{ FirstName = 'John' ; LastName = 'Smith' ; PhoneNumber = '555-1212' } 
$usero
```

<pre>
Name                           Value   
----                           -----   
FirstName                      John    
LastName                       Smith   
PhoneNumber                    555-1212
</pre>

```
$oh = [ordered] @{ }
$oh[5] = 'five' 
OperationStopped: Specified argument was out of the range of valid values. (Parameter 'index')
```

```
$oh = [ordered] @{ }
$oh[ [object] 5] = 'five'
$oh[ [object] 5]
five
$oh[0]   # Uses element index to retrieve value
five
```

#### 2.3.3 Modifying and manipulating hashtables

```
$user = @{ }
$user.date = Get-Date
$user['city'] = 'Seattle'
$user
```

<pre>
Name                           Value
----                           -----
city                           Seattle
date                           9/7/2023 2:00:16 PM
</pre>

To remove an element from the hashtable:

```
$user.remove("city")
$user
```

<pre>
Name                           Value
----                           -----
date                           9/7/2023 2:00:16 PM
</pre>

```
$newHashTable = @{}     # Create an empty hashtable
$newHashTable
$newHashTable.one = 1
$newHashTable.two = 2
$newHashTable
```
<pre>
Name                           Value
----                           -----
one                            1
two                            2
</pre>

#### 2.3.4 Hashtables as reference types

Hashtables are reference types

```
$foo = @{
    a = 1
    b = 2
    c = 3
}
$foo.a        # 1
$bar = $foo
$bar.a        # 1
```

```
$foo.a = "Hi there"
$foo.a   # Hi there
$bar.a   # Hi there
```

The change made to $foo has been reflected in $bar.

If you want to make a copy of the hashtable instead of copying the reference,
you can use the Clone() method on the object.

```
$foo = @{ a = 1; b = 2; c = 3 }
$bar = $foo.Clone()
$foo.a = "Hi there"
$bar.a    # 1
```

### 2.4 Collections: arrays and sequences

_There's no array literal notation in PowerShell._

#### 2.4.1 Collecting pipeline output as an array

The most common operation resulting in an array in PowerShell is collecting the output from a pipeline.

```
$a = 1, 2, 3
$a.GetType().FullName  # System.Object[]
```

#### 2.4.2 Array indexing

Getting and setting elements of the rray (array indexing) is done with brackets.

The length of an array can be retrieved with the _Length_ property.

Changes are made to an array by assigning new values to indexes in the array.

```
$a = 1, 2, 3
$a[0] = 3.1415
$a[2] = 'Hi there'
$a
```

<pre>
3.1415
2
Hi there
</pre>

#### 2.4.3 Polymorphism in arrays

Arrays are polymorphic by default. By polymorphic we mean you can store any time of object in an array.

```
$a = 1, 2, 3
$a += 22, 33
$a.GetType().FullName
$a.length       # 5
$a[4]           # 33
```

```
[int[]] $a = 1, 2, 3
$a.GetType().FullName   # System.Int32[]
$a += "Hello"      # MetadataError: Cannot convert value "Hello" to type "System.Int32". Error: "The input string 'Hello' was not in a correct format."
$a += 22, 33
$a                 # 1, 2, 3, 22, 33
```

#### 2.4.4 Arrays as reference types

```
$a = 1, 2, 3
"$a"   # 1 2 3
```

```
[object[]] $a = 1, 2, 3
$a.GetType().FullName
$b = $a
"`$a = $a, `$b = $b"     # $a = 1 2 3, $b = 1 2 3
$a[0] = 'Changed'
"`$a = $a, `$b = $b"     # $a = 1 2 3, $b = 1 2 3
```

As with hashtables, array assignment is done by reference.

```
$b += 4
"`$a = $a, `$b = $b"     # $a = Changed 2 3, $b = Changed 2 3 4  
```

Because of the way array concatenation works, $b contains a copy of the contents of
the array instead of a reference. If you change $a now, it won't affect $b.
Conversely, changing $b will have no effec on $a.

#### 2.4.5 Singleton arrays and empty arrays

(, 1).Length   # 1

This code creates an array containing a single element, 1.

Empty arrays are created through a special form of subexpression notation that uses the 
@ symbol isntead of the $ sign to start the expression.

@().Length      # 0

The other solution to creating an array with one element is:

@(1)          # 1
@(1).Length   # 1

Use this notation when you don't know whether the command you're calling is going to return an array.

(1, 2, 3).Length   # 3

( , (1, 2, 3) ).Length   # 1

( @( 1, 2, 3)).Length    # 3

### 2.5 Type literals

$i = [int] '123' ;
$i = [System.Int32] '123'

$i = [int[]] '123' 
$i.GetType().FullName  # $i.GetType().FullName
$i                     123

#### 2.5.1 Type name aliases

The number of type aliases has grown to 93 in PowerShell v5.1.

$tna = [psobject].Assembly.GetType('System.Management.Automation.TypeAccelerators')::Get 
$tna.GetEnumerator() | Sort-Object Key

<pre>
Key                          Value
---                          -----
adsi                         System.DirectoryServices.DirectoryEntry
adsisearcher                 System.DirectoryServices.DirectorySearcher
Alias                        System.Management.Automation.AliasAttribute
AllowEmptyCollection         System.Management.Automation.AllowEmptyCollectionAttribute
AllowEmptyString             System.Management.Automation.AllowEmptyStringAttribute
AllowNull                    System.Management.Automation.AllowNullAttribute
ArgumentCompleter            System.Management.Automation.ArgumentCompleterAttribute
ArgumentCompletions          System.Management.Automation.ArgumentCompletionsAttribute
array                        System.Array
bigint                       System.Numerics.BigInteger
bool                         System.Boolean
byte                         System.Byte
char                         System.Char
cimclass                     Microsoft.Management.Infrastructure.CimClass
cimconverter                 Microsoft.Management.Infrastructure.CimConverter
ciminstance                  Microsoft.Management.Infrastructure.CimInstance
CimSession                   Microsoft.Management.Infrastructure.CimSession
cimtype                      Microsoft.Management.Infrastructure.CimType
CmdletBinding                System.Management.Automation.CmdletBindingAttribute
cultureinfo                  System.Globalization.CultureInfo
datetime                     System.DateTime
decimal                      System.Decimal
double                       System.Double
DscLocalConfigurationManager System.Management.Automation.DscLocalConfigurationManagerAttribute
DscProperty                  System.Management.Automation.DscPropertyAttribute
DscResource                  System.Management.Automation.DscResourceAttribute
ExperimentAction             System.Management.Automation.ExperimentAction
Experimental                 System.Management.Automation.ExperimentalAttribute
ExperimentalFeature          System.Management.Automation.ExperimentalFeature
float                        System.Single
guid                         System.Guid
hashtable                    System.Collections.Hashtable
initialsessionstate          System.Management.Automation.Runspaces.InitialSessionState
int                          System.Int32
int16                        System.Int16
int32                        System.Int32
int64                        System.Int64
ipaddress                    System.Net.IPAddress
IPEndpoint                   System.Net.IPEndPoint
long                         System.Int64
mailaddress                  System.Net.Mail.MailAddress
NullString                   System.Management.Automation.Language.NullString
ObjectSecurity               System.Security.AccessControl.ObjectSecurity
ordered                      System.Collections.Specialized.OrderedDictionary
OutputType                   System.Management.Automation.OutputTypeAttribute
Parameter                    System.Management.Automation.ParameterAttribute
PhysicalAddress              System.Net.NetworkInformation.PhysicalAddress
powershell                   System.Management.Automation.PowerShell
psaliasproperty              System.Management.Automation.PSAliasProperty
pscredential                 System.Management.Automation.PSCredential
pscustomobject               System.Management.Automation.PSObject
PSDefaultValue               System.Management.Automation.PSDefaultValueAttribute
pslistmodifier               System.Management.Automation.PSListModifier
psmoduleinfo                 System.Management.Automation.PSModuleInfo
psnoteproperty               System.Management.Automation.PSNoteProperty
psobject                     System.Management.Automation.PSObject
psprimitivedictionary        System.Management.Automation.PSPrimitiveDictionary
pspropertyexpression         Microsoft.PowerShell.Commands.PSPropertyExpression
psscriptmethod               System.Management.Automation.PSScriptMethod
psscriptproperty             System.Management.Automation.PSScriptProperty
PSTypeNameAttribute          System.Management.Automation.PSTypeNameAttribute
psvariable                   System.Management.Automation.PSVariable
psvariableproperty           System.Management.Automation.PSVariableProperty
ref                          System.Management.Automation.PSReference
regex                        System.Text.RegularExpressions.Regex
runspace                     System.Management.Automation.Runspaces.Runspace
runspacefactory              System.Management.Automation.Runspaces.RunspaceFactory
sbyte                        System.SByte
scriptblock                  System.Management.Automation.ScriptBlock
securestring                 System.Security.SecureString
semver                       System.Management.Automation.SemanticVersion
short                        System.Int16
single                       System.Single
string                       System.String
SupportsWildcards            System.Management.Automation.SupportsWildcardsAttribute
switch                       System.Management.Automation.SwitchParameter
timespan                     System.TimeSpan
type                         System.Type
uint                         System.UInt32
uint16                       System.UInt16
uint32                       System.UInt32
uint64                       System.UInt64
ulong                        System.UInt64
uri                          System.Uri
ushort                       System.UInt16
ValidateCount                System.Management.Automation.ValidateCountAttribute
ValidateDrive                System.Management.Automation.ValidateDriveAttribute
ValidateLength               System.Management.Automation.ValidateLengthAttribute
ValidateNotNull              System.Management.Automation.ValidateNotNullAttribute
ValidateNotNullOrEmpty       System.Management.Automation.ValidateNotNullOrEmptyAttribute
ValidatePattern              System.Management.Automation.ValidatePatternAttribute
ValidateRange                System.Management.Automation.ValidateRangeAttribute
ValidateScript               System.Management.Automation.ValidateScriptAttribute
ValidateSet                  System.Management.Automation.ValidateSetAttribute
ValidateTrustedData          System.Management.Automation.ValidateTrustedDataAttribute
ValidateUserDrive            System.Management.Automation.ValidateUserDriveAttribute
version                      System.Version
void                         System.Void
WildcardPattern              System.Management.Automation.WildcardPattern
wmi                          System.Management.ManagementObject
wmiclass                     System.Management.ManagementClass
wmisearcher                  System.Management.ManagementObjectSearcher
X500DistinguishedName        System.Security.Cryptography.X509Certificates.X500DistinguishedName
X509Certificate              System.Security.Cryptography.X509Certificates.X509Certificate
xml                          System.Xml.XmlDocument
</pre>

#### 2.5.2 Generic type literals

There's a special kind of type in .NET called a _generic type_, which lets you say something
like "a list of strings" instead of "a list".

[System.Collections.Generic.List[int]] | Format-Table -AutoSize

<pre>
IsPublic IsSerial Name   BaseType
-------- -------- ----   --------
True     True     List`1 System.Object
</pre>

$l = New-Object System.Collections.Generic.List[int] 
$l.add(1)
$l.add(2)
$l  # 1 2

[system.collections.generic.dictionary[string,int]] | Format-Table -AutoSize

<pre>
IsPublic IsSerial Name         BaseType     
-------- -------- ----         --------     
True     True     Dictionary`2 System.Object
</pre>

#### 2.5.3 Accessing static members with type literals

[string] | Get-Member -Static

<pre>
   TypeName: System.String

Name               MemberType Definition
----               ---------- ----------
Compare            Method     static int Compare(string strA, string strB), static int Compare(string strA, string strB, bool ignoreCase), static int Compare(string strA, stri… 
CompareOrdinal     Method     static int CompareOrdinal(string strA, string strB), static int CompareOrdinal(string strA, int indexA, string strB, int indexB, int length)       
Concat             Method     static string Concat(System.Object arg0), static string Concat(System.Object arg0, System.Object arg1), static string Concat(System.Object arg0, … 
Copy               Method     static string Copy(string str)
Create             Method     static string Create[TState](int length, TState state, System.Buffers.SpanAction[char,TState] action), static string Create(System.IFormatProvide… 
Equals             Method     static bool Equals(string a, string b), static bool Equals(string a, string b, System.StringComparison comparisonType), static bool Equals(System… 
Format             Method     static string Format(string format, System.Object arg0), static string Format(string format, System.Object arg0, System.Object arg1), static stri… 
GetHashCode        Method     static int GetHashCode(System.ReadOnlySpan[char] value), static int GetHashCode(System.ReadOnlySpan[char] value, System.StringComparison comparis… 
Intern             Method     static string Intern(string str)
IsInterned         Method     static string IsInterned(string str)
IsNullOrEmpty      Method     static bool IsNullOrEmpty(string value)
IsNullOrWhiteSpace Method     static bool IsNullOrWhiteSpace(string value)
Join               Method     static string Join(char separator, Params string[] value), static string Join(string separator, Params string[] value), static string Join(char s… 
new                Method     string new(char[] value), string new(char[] value, int startIndex, int length), string new(System.Char*, System.Private.CoreLib, Version=7.0.0.0,… 
ReferenceEquals    Method     static bool ReferenceEquals(System.Object objA, System.Object objB)
Empty              Property   static string Empty {get;}
</pre>

$s = 'one', 'two', 'three'
[string]::Join(' + ', $s)   # one + two + three

The class, [System.Math], is a pure static class, meaning you can't create an instance of it--
you can only use the static methods it provides.

### 2.6 Type conversions

Automatic type conversion is the "secret sauce" that allows a strongly typed language 
like PowerShell to behave like a typeless command-line shell.

#### 2.6.1 How type conversion works

Type conversions are used any time an attempt is made to use an objecxt of one type in
a context that requires another type (such as adding a string to a number).

[int] '0x25'      # 37

[int] [char] 'a'  # 97

"$([int[]] [char[]] 'Hello world')"
<pre>72 101 108 108 111 32 119 111 114 108 100</pre>

"0x{0:x}" -f [int] [char] 'a'   # 0x61

Round-trip:
[string] [char] [int] ("0x{0:x}" -f [int] [char] 'a')  # a

#### 2.6.2 PowerShell's type-conversion algorithm

__PowerShell Language Standard Conversions__

The standard built-in conversions performed by the engine itself.
They're always processed first and can't be overriden.

__.NET-Based Custom Converters__

#### 2.6.3 Special type conversions in parameter binding

__ScriptBlock Parameters__

PowerShell has something called a _scriptblock_ which is a fragment of code that you
can pass around as an object itself.

## Chapter 3: Operators and expressions

Note: Operators are normally classed as unary if they take a single operand
and binary if they take two. The operators in this chapter are all binary.

__Arithmetic Operators__ + - * / %

__Assignment Operators__ = += -= *= /= %=

__Comparison Operators__ 

-eq -ne -gt -ge -lt -le

-ieq -ine -igt -ige -ilt -ile

-ceq -cne -cgt -cge -clt -cle

__Containment Operators__ 

-contains -notcontains -in -notin

-icontains -inotcontains -iin -inotin

-ccontains -cnotcontains -cin -cnotin

__Pattern-matching and text-manipulation operators__

-like -notlike -match -notmatch -replace -split

-ilike -inotlike -imatch -inotmatch -ireplace -isplit

-clike -cnotlike -cmatch -cnotmatch -creplace -csplit

__Logical and bitwise operators__

-and -or -not -xor -shl

-band -nor -bnot -bxor -shr

One of the characteristics that makes PowerShell operators so powerful is they're _polymorphic_.
This means that they work on more than one type of object.

[Get-Help operator](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

### 3.1 Arithmetic operators

__Arithmetic Operators__ + - * / %

#### 3.1.1 Addition operator

numbers: addition

strings: concatenation

arrays: joins (array concatenation)

hashtables: creates new hashtable with combined elements.

```
$a = [int[]] (1, 2, 3, 4)
$a[0] = 10
$a[0] = '0xabc' 
"$a"        # 2748 2 3 4
$a[0] = 'hello'
InvalidArgument: Cannot convert value "hello" to type "System.Int32". Error: "The input string 'hello' was not in a correct format."
```

```
$a = [int[]] (1, 2, 3, 4)
"$a"                        # 1 2 3 4
$a = $a + 'hello'
"$a"                        # 1 2 3 4 hello
$a[0] = 'hello'
"$a"                        # hello 2 3 4 hello
```

```
$a.GetType().FullName
System.Object[]
```

```
$a = @{ FirstName = 'David'; LastName = 'Stevenson' } ;
$b = @{ Street = '123 Main Street'; State = 'NY' }
$c = $a + $b
$a
$b
$c
```

<pre>
$a

Name                           Value
----                           -----
FirstName                      David
LastName                       Stevenson

$b

Name                           Value
----                           -----
State                          NY
Street                         123 Main Street

$c

Name                           Value
----                           -----
Street                         123 Main Street
LastName                       Stevenson
FirstName                      David
State                          NY
</pre>

#### 3.1.2 Multiplication operator

PowerShell defines multiplication for numbers, strings and arrays.

'abc' * 3   # abcabcabc

'abc' * 0   # (empty string)

```
$a = 1, 2, 3
$a.Length       # 3
$a = $a * 2
$a.Length       # 6
"$a"            # 1 2 3 1 2 3
```

#### 3.1.3 Subtraction, division, and the modulus operator

Subtraction, division, and the modulus (%) operators are _only defined for numbers by PowerShell_.

'123' / '4'   # 30.75

### 3.2 Assignment operators

__Assignment Operators__ = += -= *= /= %=

Multiple assignments are allowed.
```
$a, $b, $c = 1, 2, 3, 4
"`$a = $a,  `$b = $b,   `$c = $c"       # $a = 1,  $b = 2,   $c = 3 4
```

#### 3.2.1 Multiple assignments

```
$temp = $a
$a = $b
$b = $temp
```

Swap values using multiple assignments
```
$a, $b = $b, $a
```

#### 3.2.2 Multiple assignements with type qualifiers

```
$data = Get-Content -Path data.txt | foreach {
    $e = @{}
    $e.level, [int] $e.lower, [int] $e.upper = -split $_
    $e
}
$data[0]
```
<pre>
Name                           Value
----                           -----
level                          quiet
lower                          0
upper                          25
</pre>

#### 3.2.3 Assign operations as value expressions

The last thing you need to know about assignment operators is they're expressions.

$a = $b = $c = 3

What exactly happened?

$a = ($b = ($c = 3))

```
$a = ( $b = ( $c = 3 ) + 1) + 1
"`$a = $a, `$b = $b, `$c = $c"      # $a = 5, $b = 4, $c = 3
```

### 3.3 Comparison operators

```
-eq -ne -gt -ge -lt -le
-ieq -ine -igt -ige -ilt -ile
-ceq -cne -cgt -cge -clt -cle
```

PowerShell has a izable number of comparison operators, in large part because 
there are case-sensitive and case-insensitive versions of all of the operators.

The "c" variant is case-sensitive, and the "i" variant is case-insensitive.

The unqualified operators are case-insensitive.

#### 3.3.1 Scalar comparisons

__Basic Comparison Rules__

The behavior of the comparison operators are significantly affected by the type of the _left_ operand.

__Type Conversions and Comparisons__

When comparisons are done in a numeric context, the widening rules are applied.

[int] "123" -lt "123.4"     # True

[int] "123" -lt "123.4"     # True

[double] "123" -lt "123.4"  # True

#### 3.3.2 Comparisons and case sensitivity

Case sensitivity only applies to strings.

'abc' -eq 'ABC'   # True

'abc' -ieq 'ABC'  # True

'abc' -ceq 'ABC'  # False

The default case -eq is case-insensitive.

How things that aren't strings or numbers are compared.

1. If the object implements the .NET IComparable interface, then that will be used.
1. If not, and the object on the _left_ side has an Equals() method that can take an object of the right operand, this is used.
1. If there's no direct mechanism for comparing the two, an attempt will be made to convert the right operand into an 
instance of the type of the left operand, and then PowerShell will try to compare the resulting objects.

Get-Process | where { $_.starttime -ge [DateTime]::today }

#### 3.3.3 Using comiparison operators with collections

__Basic Comparison Operations Involving Collections__

If the _left_ operand is an array or collection, the comparison operation will return 
the elements of that collection that match the right operand. This works with strings as well.

```
1, '2', 3, 2, '1' -eq '2'
2
2
```

Examples with leading zeros:

```
1, '02', 3, 02, '1' -eq '2'
2
```

```
1, '02', 3, 02, '1' -eq 2
2
```

__Containment Operators__

All of the comparison operators we've discussed so far return the matching elements
from the collection.

Although this is extremely useful, there are times when you want to find out whether
or not an element is  there.

```
-contains -notcontains -in -notin
-icontains -inotcontains -iin -inotin
-ccontains -cnotcontains -cin -cnotin
```

These operators return $true if the set contains the elements you're looking for instead
of returning the matching elements.

```
1, 2, 3 -contains 2     # True
1, 2, 3 -notcontains 2  # False
2 -in 1, 2, 3           # True
2 -notin 1, 2, 3        # False

1, '02', 3, 02, '1' -contains '02'    # True
1, '02', 3, 02, '1' -notcontains '02' # False
```

```$false, $true -eq $false```
-eq searches the list for $false, finds it, and then returns the matching value

```$false, $true -contains $false # True```

@($false, $true -eq $false).count  # 1

The @( ... ) sequence forces the result to be an array and then counts the result.

It may seem odd to have both a -contains operator and an -in operator. 
They both appear to do the same thing but from the opposite directions.

```
1, 2, 3 -contains 2  # True
2 -in 1, 2, 3        # True
```

```
$names = 'pwsh', 'powershell_ise'
Get-Process | where Name -in $names
```
<pre>
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     77    32.46      79.68       4.27   11356   3 pwsh
     88    43.77     106.41       7.52   24372   3 pwsh
</pre>

Get-Alias where
<pre>
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           where -> Where-Object
</pre>

### 3.4 Pattern matching and text manipulation

Pattern matching operators work on strings, allowing searching, extraction, editing and creating new strings.

Text manipulation operators allow breaing strings apart and adding individual pieces back together.

#### 3.4.1 Wildcard patterns and the -like operator

_Wildcard pattern_

Get-ChildItem -Path *.txt

Wildcard patterns allow you to specify character ranges.

Get-ChildItem -Path [fm]*.txt   # Text files that start with the letter 'f' or 'm'.

* \* matches zero or more characters anywhere in the string
* \? matches any single character
* \[\<char\>-\<char\>] matches a sequential range of characters
* \[\<char\>\<char\>...] matches any one character from a set of characters

Although wildcard patterns are simple, there matching capabilities are limited.

#### 3.4.2 Regular expressions

* \.\* is matches zero or more characters
* \. matches any single character
* The PowerShell operators -match, -replace, and -split work with regular expressions.

#### 3.4.3 The -match operator

```
-match -cmatch -imatch
-notmatch -cnotmatch -inotmatch
-replace -creplace -ireplace
```

<pre>
'Hello' -match '[jkl]'       # True
'Hello' -notmatch '[jkl]'    # False
'Hello' -replace 'ello','i'  # Hi
'abcde' -replace 'bcd'       # ae
</pre>

The -match operator is similar to the -like operator in that it matches a pattern and returns a result.
Along wit that result, though, it sets the $matches variable.

```
'abcdef' -match '(a)(((b)(c))de)f'
$matches
```

<pre>
Name                           Value
----                           -----
5                              c
4                              b
3                              bc
2                              bcde
1                              a
0                              abcdef
</pre>

__Matching Using Named Captures__

```
'abcdef' -match '(?<o1>a)(?<o2>((?<e3>b)(?<e4>c))de)f'  # True
$matches
```

<pre>
Name                           Value
----                           -----
o2                             bcde
o1                             a
e3                             b
e4                             c
1                              bc
0                              abcdef
</pre>

__Parsing Command Output Using Regular Expressions__

```(net config workstation)[1]```
<pre>Full Computer name                   DSTEVENSONWIN10</pre>

```
$p = '^Full Computer.*  (?<computer>[^.]+)(\.(?<domain>[%.]+))?'
(net config workstation)[1] -match $p
$matches
$matches.computer      # DSTEVENSONWIN10
```

<pre>
Name                           Value
----                           -----
computer                       DSTEVENSONWIN10
0                              Full Computer name                   DSTEVENSONWIN10
</pre>

#### 3.4.4. The -replace operator

```'1,2,3,4' -replace '\s*,\s*','+'```
<pre>1+2+3+4</pre>

$(Get-Content old.txt) -replace 'is (red|blue)','was $1' > new.txt

'My bike is yellow' -replace 'is (red|blue)','was $1'
<pre>My bike is yellow</pre>

```
$a = "really"
'The car is red' -replace 'is (red|blue)',"was $a `$1"
```
<pre>The car was really red</pre>

'The quick brown fox' -replace 'quick'
<pre>The  brown fox</pre>

#### 3.4.5 The -join operator

PowerShell has two operators for working with collections and strings; -split and -join.

```
$in = 1, 2, 3
$out = -join $in
$out
$out = $in -join ', '
$out
```
<pre>
123
1, 2, 3
</pre>

```
$ca = [char[]] 'abcd' 
"$ca"
[array]::Reverse($ca)
"$ca"
```
<pre>
a b c d
d c b a
</pre>

```
$ra = -join $ca
$ra   # dcba
```

-join 1,2,3 
<pre>
1
2
3
</pre>

Surprise! Instead of joining the array members into a single string, it returned the same array.
This is because unary operators have higher precedence than binary operators and, in PowerShell,
the comma is a binary operator. -join 1,2,3 is equivalent to (-join 1), 2, 3

To use the unary -join operator:

-join (1,2,3) # 123

```
$numbers = 1, 2, 3
$exp = $numbers -join '+'
$exp   # 1+2+3
```

```
1..10 -join '*'   # 1*2*3*4*5*6*7*8*9*10
$fact = Invoke-Expression (1..10 -join '*')
$fact   # 3628800
```

```
@'
line1
line2
line3
'@ > out.txt
$text = Get-Content -Path out.txt
$text
```
The Get-Content returns the contents of a file as an array of strings - in fact it's an [object] array.
<pre>
line1
line2
line3
</pre>

```
$single = $text -join "`r`n"
$single
```
<pre>
line1
line2
line3
</pre>

```
$single2 = Get-Content -Path out.txt -Raw
$single2
$single2.GetType().FullName
```
<pre>
line1
line2
line3

System.String
</pre>

#### 3.4.6 The -split operator

The -split operator performs the opposite operation to -join: it splits strings into a collection 
of smaller strings.

'a:b:c:d:e' -split ':'
<pre>a
b
c
d
e</pre>

The -split operator allows you to limit the number of elements to return. Do so by specifying
an intenger after the match pattern.

'a:b:c:d:e' -split ':',3
<pre>
a
b
c:d:e
</pre>

'a*b*c' -split '*'
<pre>OperationStopped: Invalid pattern '*' at offset 1. Quantifier '*' following nothing.W</pre>

'a*b*c' -split '\*'
<pre>a
b
c</pre>

'a*b*c' -split '*',0,'SimpleMatch'
<pre>a
b
c</pre>

In some cases, it's much simpler to use 'SimpleMatch' rather than escaping all the special regular expression characters.

__-split Operator Options__

Multiple options can be specified with commas between them, like RegexMAtch,IgnoreCase,MultiLine.

<pre>
IgnoreCase
CultureInvariant
IgnorePatternWhitespace
Multiline
SingleLine
ExplicitCapture
</pre>

__Using ScriptBlocks with the -split operator__

PowerShell allows you to pass a scriptblock to the operator. The scriptblock will be used as a
_predicate function_ that determines whether there's a match.

This string contains a list of colors that you want to split into pairs, two colors per pair:

```
$colors = "Black,Brown,Red,Orange,Yellow,Green,Blue,Violet,Gray,White"
$count=@(0)
$colors -split { $_ -eq ',' -and ++$count[0] % 2 -eq 0 }
```
<pre>
Black,Brown
Red,Orange
Yellow,Green
Blue,Violet
Gray,White
</pre>

### 3.5 Logical and bitwise operators

PowerShell has logical operators -and, -or, -xor and -not for combining simpler comparisons
into more complex expressions.

<pre>
-and  -or  -not  -xor  -shl
-band -nor -bnot -bxor -shr
</pre>

The operators beginning with the letter b are binary operators.

These PowerShell logical operators are short-circuit operators --
they only do as much work as they need to.

64 bit integers are supported in PowerShell v2 and later.

### 3.6 Where() and ForEach() methods

The Where() and ForEach() methods work in a similar manner to the Where-Object 
and ForEach-Object cmdlets.

#### 3.6.1 Where() method

The Where() method provides a way to filter collections using a condensed syntax.
In all cases, using the Where() method is faster (up to ten times faster) than using
Where-Object, but consumes more memory.

The following is a standard use of the Where-Object cmdlet:

```Get-Process | where Handles -gt 1000```

The Where() method can be used to achieve the same result.

(Get-Process).where{ $_.Handles -gt 1000 }

(Get-Process).where{ $psitem.Handles -gt 1000 }

Qualifiers can be applied to display the first or last member of the collection:

(Get-Process).where( { $_.Handles -gt 1000 }, 'First')

(Get-Process).where( { $_.Handles -gt 1000 }, 'Last')

This can be extended tothe first or last _n_ members:

(Get-Process).where( { $_.Handles -gt 1000 }, 'First', 3)

(Get-Process).where( { $_.Handles -gt 1000 }, 'Last', 3)

There's an option to split the results (first member contains the processes that match the filter,
and the second member those that don't).

```
$proc = (Get-Process).where( {$_.Handles -gt 1000 }, 'Split')
$proc[0]
$proc[1]
```

(Get-Process | sort Handles).where( { $_.Handles -gt 1000 }, 'Until' )

(Get-Process | sort Handles).where( { $_.Handles -gt 1000 }, 'SkipUntil' )


#### 3.6.2 ForEach() method

```
$data = 1,2,3,4,5

($data).ForEach( { $_ * 2 } )
$data.ForEach( { $_ * 2 })
```

When the data is already an array, you don't need to wrap it in ().
<pre>
2
4
6
8
10
</pre>

```
$data | Get-Member                      # TypeName: System.Int32
$data.ForEach( [double]) | Get-Member   # TypeName: System.Double
```
Values for a particular property can be displayed as follows:

```
(Get-Process).foreach('Name')
```

If the objects within the collection have methods, they can be invoked

```
(Get-Process -Name notepad).foreach('Name')
(Get-Process -Name notepad).foreach('Kill')
```

