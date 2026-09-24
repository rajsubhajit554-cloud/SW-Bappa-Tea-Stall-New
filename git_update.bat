@echo off
setlocal enabledelayedexpansion
title Git Update - SW Bappa Tea Stall

cd /d "%~dp0"

echo ======================================================
echo           SW BAPPA TEA STALL - GIT AUTO UPDATE
echo ======================================================
echo.

:: Check if git is installed
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed or not found in PATH!
    echo Please install Git and try again.
    pause
    exit /b 1
)

:: Show current branch & status
echo [1/4] Checking repository status...
git status -s
echo.

:: Ask for commit message
set "commit_msg="
set /p "commit_msg=Enter commit message (Press Enter for default message): "

if "%commit_msg%"=="" (
    for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
    set "commit_msg=Update website - !datetime:~0,4!-!datetime:~4,2!-!datetime:~6,2! !datetime:~8,2!:!datetime:~10,2!"
)

echo.
echo [2/4] Adding all changed files (git add .)...
git add .

echo.
echo [3/4] Committing changes (Message: "%commit_msg%")...
git commit -m "%commit_msg%"
if %errorlevel% neq 0 (
    echo.
    echo [INFO] No new changes to commit or commit skipped.
)

echo.
echo [4/4] Pushing changes to GitHub (origin main)...
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ======================================================
    echo [SUCCESS] Git repository updated successfully!
    echo GitHub Repo: https://github.com/rajsubhajit554-cloud/SW-Bappa-Tea-Stall-New.git
    echo ======================================================
) else (
    echo.
    echo ======================================================
    echo [ERROR] Failed to push to GitHub!
    echo Please check your internet connection or GitHub authentication.
    echo ======================================================
)

echo.
pause
