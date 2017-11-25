@ECHO OFF
:start
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '.\main.ps1'"
goto start