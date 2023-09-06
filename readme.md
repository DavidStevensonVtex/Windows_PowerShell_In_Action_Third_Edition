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