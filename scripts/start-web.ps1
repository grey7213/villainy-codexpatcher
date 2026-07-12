# Codex Session Patcher Web UI 启动脚本 (PowerShell 版)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Codex Session Patcher Web UI" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 进入项目目录
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectDir = Split-Path -Parent $scriptDir
Set-Location $projectDir

# 查找 Python
Write-Host "查找 Python 解释器..." -ForegroundColor Yellow
$pythonCmd = $null

# 尝试查找可用的 Python（必须有 pip）
$candidates = @(
    "python",
    "python3",
    "D:\Anconda3\python.exe",
    "D:\Anaconda3\python.exe",
    "C:\ProgramData\Anaconda3\python.exe",
    "$env:USERPROFILE\Anaconda3\python.exe",
    "$env:USERPROFILE\miniconda3\python.exe"
)

foreach ($candidate in $candidates) {
    # 如果是路径，检查文件是否存在
    if ($candidate -like "*\*") {
        if (-not (Test-Path $candidate)) {
            continue
        }
        $testCmd = $candidate
    } else {
        # 如果是命令名，检查是否存在
        if (-not (Get-Command $candidate -ErrorAction SilentlyContinue)) {
            continue
        }
        $testCmd = $candidate
    }

    # 检查是否有 pip
    $hasPip = & $testCmd -m pip --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        $pythonCmd = $testCmd
        break
    } else {
        Write-Host "  ⚠️  跳过 $candidate (缺少 pip)" -ForegroundColor DarkYellow
    }
}

if (-not $pythonCmd) {
    Write-Host ""
    Write-Host "ERROR: 未找到带有 pip 的 Python 解释器" -ForegroundColor Red
    Write-Host ""
    Write-Host "解决方案:" -ForegroundColor Yellow
    Write-Host "  1. 安装标准 Python: https://www.python.org/downloads/" -ForegroundColor Cyan
    Write-Host "  2. 或者使用 Anaconda: https://www.anaconda.com/" -ForegroundColor Cyan
    Write-Host "  3. 确保勾选 'Add Python to PATH'" -ForegroundColor Cyan
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "使用 Python: $pythonCmd" -ForegroundColor Green
Write-Host ""

# 检查依赖
Write-Host "检查 Python 依赖..." -ForegroundColor Yellow
$checkUvicorn = & $pythonCmd -c "import uvicorn" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "安装 Python Web 依赖..." -ForegroundColor Yellow
    & $pythonCmd -m pip install -e ".[web]" -q
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: 依赖安装失败" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
} else {
    Write-Host "Python 依赖已就绪" -ForegroundColor Green
}

# 检查前端
Write-Host ""
Write-Host "检查前端构建..." -ForegroundColor Yellow
if (-not (Test-Path "web\frontend\dist")) {
    Write-Host "需要构建前端..." -ForegroundColor Yellow

    if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
        Write-Host "ERROR: 未安装 Node.js" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }

    Set-Location "web\frontend"
    npm install
    npm run build
    Set-Location $projectDir
} else {
    Write-Host "前端已就绪" -ForegroundColor Green
}

# 启动服务
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "启动 Web 服务..." -ForegroundColor Green
Write-Host ""
Write-Host "访问地址: http://127.0.0.1:8080" -ForegroundColor Cyan
Write-Host "按 Ctrl+C 停止服务" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

& $pythonCmd -m uvicorn web.backend.main:app --host 127.0.0.1 --port 8080
