# Stop Codex Session Patcher Web Service
$port = 8080
$process = Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess

if ($process) {
    Stop-Process -Id $process -Force
    Write-Host "Service stopped (PID: $process)" -ForegroundColor Green
} else {
    Write-Host "No service running on port $port" -ForegroundColor Yellow
}

Write-Host ""
Read-Host "Press Enter to exit"
