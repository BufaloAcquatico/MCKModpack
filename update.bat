@echo off
REM ==============================================================================
REM  update.bat — Pull the latest version of the Minecraft modpack from GitHub
REM
REM  Usage:  Double-click or run from Command Prompt:  update.bat
REM
REM  Requires: Git for Windows (https://git-scm.com/download/win)
REM ==============================================================================

setlocal enabledelayedexpansion

REM ---------- colors ----------
REM Windows 10+ supports ANSI escape codes
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"
set "RED=!ESC![31m"
set "GREEN=!ESC![32m"
set "YELLOW=!ESC![33m"
set "BLUE=!ESC![34m"
set "CYAN=!ESC![36m"
set "NC=!ESC![0m"

REM ---------- detect script directory ----------
set "SCRIPT_DIR=%~dp0"

REM ---------- check git is installed ----------
echo.
echo !CYAN!=== Checking prerequisites ===!NC!
git --version >nul 2>&1
if errorlevel 1 (
    echo !RED![ERR]  Git is not installed or not found in PATH.!NC!
    echo.
    echo To install Git:
    echo   - Windows: https://git-scm.com/download/win
    echo   - After installing, restart your terminal and run this script again.
    echo.
    pause
    exit /b 1
)

for /f "tokens=*" %%v in ('git --version') do set "GIT_VERSION=%%v"
echo !GREEN![OK]   Git found: !GIT_VERSION!!NC!

REM ---------- verify we are in a git repository ----------
cd /d "%SCRIPT_DIR%"
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo !RED![ERR]  This directory is not a Git repository.!NC!
    echo.
    echo Make sure you cloned the modpack with:
    echo   git clone https://github.com/BufaloAcquatico/MCKModpack.git
    echo.
    echo Or run this script from inside the modpack directory.
    echo.
    pause
    exit /b 1
)

echo !GREEN![OK]   Git repository detected.!NC!

REM ---------- check remote ----------
echo.
echo !CYAN!=== Checking remote ===!NC!
for /f "tokens=*" %%u in ('git remote get-url origin 2^>nul') do set "REMOTE_URL=%%u"
if not defined REMOTE_URL (
    echo !RED![ERR]  No 'origin' remote configured.!NC!
    echo Add it with:  git remote add origin https://github.com/BufaloAcquatico/MCKModpack.git
    echo.
    pause
    exit /b 1
)
echo !BLUE![INFO] Remote: !REMOTE_URL!!NC!

REM ---------- check for uncommitted changes ----------
echo.
echo !CYAN!=== Checking local changes ===!NC!
git diff --quiet 2>nul
set "DIFF_CHECK1=!errorlevel!"
git diff --cached --quiet 2>nul
set "DIFF_CHECK2=!errorlevel!"
if not "!DIFF_CHECK1!"=="0" if not "!DIFF_CHECK2!"=="0" (
    echo !YELLOW![WARN] You have uncommitted local changes.!NC!
    echo These changes may be overwritten by the update.
    echo.
    echo Options:
    echo   - Commit them first:  git add -A ^&^& git commit -m "my changes"
    echo   - Stash them:         git stash
    echo   - Discard them:       git checkout -- .
    echo.
    set /p "ANSWER=Continue pulling anyway? (y/N) "
    if /i not "!ANSWER!"=="y" (
        echo !BLUE![INFO] Update cancelled. No changes were made.!NC!
        pause
        exit /b 0
    )
)

REM ---------- fetch ----------
echo.
echo !CYAN!=== Fetching from GitHub ===!NC!
git fetch origin main --quiet 2>&1
if errorlevel 1 (
    echo !RED![ERR]  Failed to fetch from GitHub.!NC!
    echo.
    echo Possible causes:
    echo   - No internet connection
    echo   - Authentication required (private repository)
    echo   - Remote URL is incorrect
    echo.
    echo Authentication setup:
    echo !REMOTE_URL! | findstr /b /i "git@" >nul
    if !errorlevel! equ 0 (
        echo   SSH remote detected. Ensure your SSH key is added to ssh-agent:
        echo     ssh-add %%USERPROFILE%%\.ssh\id_ed25519
        echo   And that the public key is added to GitHub.
    ) else (
        echo   HTTPS remote detected. Store credentials permanently:
        echo     git config --global credential.helper store
        echo   Then run this script again to enter your credentials once.
    )
    echo.
    pause
    exit /b 1
)
echo !GREEN![OK]   Fetched latest data.!NC!

REM ---------- compare ----------
for /f "tokens=*" %%h in ('git rev-parse HEAD') do set "LOCAL_HASH=%%h"
for /f "tokens=*" %%h in ('git rev-parse origin/main') do set "REMOTE_HASH=%%h"

if "!LOCAL_HASH!"=="!REMOTE_HASH!" (
    echo !GREEN![OK]   Already up to date! No new version available.!NC!
    echo.
    echo Your modpack is at commit: !LOCAL_HASH:~0,8!
    echo.
    pause
    exit /b 0
)

REM ---------- pull ----------
echo.
echo !CYAN!=== Pulling updates ===!NC!
echo !BLUE![INFO] Local:  !LOCAL_HASH:~0,8!!NC!
echo !BLUE![INFO] Remote: !REMOTE_HASH:~0,8!!NC!
echo.

git pull origin main
if errorlevel 1 (
    echo.
    echo !RED![ERR]  Pull failed - there may be merge conflicts.!NC!
    echo.
    echo Resolve conflicts manually:
    echo   1. Open conflicted files and fix markers ( ^<^<^<^<^<^<^< ^======= ^>^>^>^>^>^>^> )
    echo   2. git add ^<resolved-files^>
    echo   3. git commit
    echo   4. Run this script again
    echo.
    pause
    exit /b 1
)

for /f "tokens=*" %%h in ('git rev-parse --short HEAD') do set "NEW_HASH=%%h"
echo.
echo !GREEN![OK]   Modpack updated successfully! !NC!
echo.
echo Updated to commit: !NEW_HASH!
echo You can now launch the modpack from your Minecraft launcher.
echo.
pause
exit /b 0