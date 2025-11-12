@echo off
chcp 65001 >nul

REM AI-Trader 主启动脚本 (Windows版本)
REM 用于启动完整的交易环境

echo.
echo 🚀 Launching AI Trader Environment...
echo.

REM 检查Python是否可用
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python is not installed or not in PATH
    echo Please install Python and add it to your PATH
    pause
    exit /b 1
)

echo 📊 Now getting and merging price data...
cd data
python merge_jsonl.py
if errorlevel 1 (
    echo ❌ Failed to merge JSONL data
    pause
    exit /b 1
)
cd ..

echo 🔧 Now starting MCP services...
cd agent_tools
start "MCP Services" python start_mcp_services.py
cd ..

REM 等待MCP服务启动
echo Waiting for MCP services to start...
timeout /t 5 /nobreak >nul

echo 🤖 Now starting the main trading agent...
python main.py configs\default_config.json
if errorlevel 1 (
    echo ❌ Trading agent stopped with error
    pause
    exit /b 1
)

echo ✅ AI-Trader stopped

echo 🔄 Starting web server...
cd docs
start "Web Server" python -m http.server 8888
cd ..

echo ✅ Web server started
echo.
echo 🎉 AI-Trader environment is ready!
echo - Trading agent: Completed
echo - MCP services: Running in background
echo - Web server: Running on http://localhost:8888
echo.
echo Press any key to exit...
pause >nul