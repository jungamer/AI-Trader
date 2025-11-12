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

echo.
echo Press any key to exit...
pause >nul