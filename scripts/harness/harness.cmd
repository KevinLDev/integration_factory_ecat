@echo off
setlocal
powershell.exe -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%~dp0Invoke-Harness.ps1" %*
exit /b %ERRORLEVEL%
