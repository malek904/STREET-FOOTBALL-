@echo off
setlocal
title STREET FOOTBALL - Update from GitHub

set "URL=https://raw.githubusercontent.com/malek904/STREET-FOOTBALL-/refs/heads/main/index.html"
set "TARGET=%~dp0index.html"
set "TEMP=%~dp0index_new.tmp"
set "BACKUP=%~dp0index_backup.html"

echo.
echo ==========================================
echo   STREET FOOTBALL - GitHub Update
echo ==========================================
echo.
echo Downloading the latest index.html...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; try { Invoke-WebRequest -Uri '%URL%?v=%RANDOM%%RANDOM%' -Headers @{'Cache-Control'='no-cache'} -OutFile '%TEMP%'; if ((Get-Item '%TEMP%').Length -lt 1000) { throw 'Downloaded file is too small.' } } catch { Write-Host 'UPDATE FAILED:' $_.Exception.Message; exit 1 }"

if errorlevel 1 (
    echo.
    echo [ERROR] Could not download the latest version from GitHub.
    echo Check your internet connection and try again.
    pause
    exit /b 1
)

if exist "%TARGET%" (
    copy /Y "%TARGET%" "%BACKUP%" >nul
)

move /Y "%TEMP%" "%TARGET%" >nul

if errorlevel 1 (
    echo.
    echo [ERROR] Could not replace index.html.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo   UPDATE COMPLETED SUCCESSFULLY
echo ==========================================
echo.
echo Your local index.html is now the latest
echo version from GitHub.
echo.
echo Backup of the previous version:
echo %BACKUP%
echo.
echo You can now use this index.html to create
echo your APK.
echo.
pause
endlocal
