# Running Commands

## Security

- PowerShell doesn't apply any additional layers of permissions on anything it touches
- Not a way to bypass existing permissions 

## Execution Policy
- 1st security measure PowerShell include3s is an Execution Policy.
- Machine Wide
- Default on Windows is restricted
- Try to run it, getting er message

View current poilicy is
```PowerShell
Get-ExecutionPolicy
```
Change it by doing the following
```PowerShell
Set-ExecutionPolicy -unrestricted
```

## Not Scripting but running commands

PowerShell is a shell and a scripting language

Run commands until something is right, paste it in a txt and call it a script.

## The anatomy of a command

The full form syntax

1. Command
2. Parameter 1
3. Parameter 2
4. Parameter 3

EX
```PowerShell
Get-Command -Verb Get -Module PSReadLine,PowerShellGet -Syntax
```
### The commandlet naming convention

- A cmdlet is a native PowerShell command-line utility. These exist only inside PowerShell and are written in a .NET core language such as C#
- A function can be similar to a cmdlet but rather than being written in .Net, functions are written in PWSH
- An application is any kind of external executable including command line utilities such as ping

