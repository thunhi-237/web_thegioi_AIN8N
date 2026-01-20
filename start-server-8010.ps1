# Script khởi động server trên port 8010
$projectPath = "D:\05. Github_Moi\06_Web_ALT\ALT_anhlaptrinhvn\web_thegioi_AIN8N"
Set-Location $projectPath

Write-Host "Đang khởi động server trên port 8010..." -ForegroundColor Green
Write-Host "Thư mục: $projectPath" -ForegroundColor Yellow
Write-Host "URL: http://localhost:8010/device-emulator.html" -ForegroundColor Cyan

# Kiểm tra port 8010 có đang được sử dụng không
$portInUse = Get-NetTCPConnection -LocalPort 8010 -ErrorAction SilentlyContinue
if ($portInUse) {
    Write-Host "Port 8010 đang được sử dụng. Đang dừng process..." -ForegroundColor Yellow
    $processId = (Get-NetTCPConnection -LocalPort 8010 -ErrorAction SilentlyContinue).OwningProcess
    if ($processId) {
        Stop-Process -Id $processId -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
    }
}

# Khởi động server
python -m http.server 8010
