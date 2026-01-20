# Script chạy server HTTP trên port 8010
$projectPath = "D:\05. Github_Moi\06_Web_ALT\ALT_anhlaptrinhvn\web_thegioi_AIN8N"

# Chuyển đến thư mục dự án
Set-Location $projectPath

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Khởi động HTTP Server" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Thư mục: $projectPath" -ForegroundColor Yellow
Write-Host "Port: 8010" -ForegroundColor Yellow
Write-Host "URL: http://localhost:8010/device-emulator.html" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Kiểm tra file tồn tại
if (Test-Path "device-emulator.html") {
    Write-Host "✓ File device-emulator.html tồn tại" -ForegroundColor Green
} else {
    Write-Host "✗ File device-emulator.html KHÔNG tồn tại!" -ForegroundColor Red
    exit 1
}

# Dừng server cũ nếu có
$existingConnections = Get-NetTCPConnection -LocalPort 8010 -ErrorAction SilentlyContinue
if ($existingConnections) {
    Write-Host "Đang dừng server cũ..." -ForegroundColor Yellow
    $existingConnections | ForEach-Object {
        Stop-Process -Id $_.OwningProcess -Force -ErrorAction SilentlyContinue
    }
    Start-Sleep -Seconds 1
}

# Khởi động server
Write-Host "Đang khởi động server..." -ForegroundColor Green
python -m http.server 8010
