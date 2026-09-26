@echo off
REM Double-click this to start the live auto-push watcher.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0watch-and-push.ps1"
pause
