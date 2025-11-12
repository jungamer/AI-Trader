@echo off
chcp 65001 >nul

REM AI-Trader 主启动脚本 (Windows版本)
REM 用于启动完整的交易环境

echo.
echo 🚀 Launching AI Trader Environment...
echo.

echo 🔧 Now starting MCP services...
cd agent_tools
start "MCP Services" python start_mcp_services.py
cd ..

REM 等待MCP服务启动
echo Waiting for MCP services to start...
timeout /t 5 /nobreak >nul

echo 🤖 Now starting the main trading agent...
python main.py configs/astock_config.json  # 运行A股配置
if errorlevel 1 (
    echo ❌ Trading agent stopped with error
    pause
    exit /b 1
)

echo ✅ AI-Trader stopped

echo.
echo Press any key to exit...
pause >nul