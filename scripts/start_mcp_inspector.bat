@echo off
echo Starting MCP Inspector...

REM 切换到项目根目录
cd /d "%~dp0.."

REM 检查Node.js是否安装
node --version >nul 2>&1
if errorlevel 1 (
    echo Error: Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

REM 检查npx是否可用
npx --version >nul 2>&1
if errorlevel 1 (
    echo Error: npx is not available
    echo This usually means Node.js version is too old
    echo Please update Node.js to a newer version
    pause
    exit /b 1
)

echo Node.js version:
node --version
echo npx version:
npx --version

echo.
echo Starting Model Context Protocol Inspector...
echo This will open a web interface for MCP debugging
echo.

REM 启动MCP Inspector
npx @modelcontextprotocol/inspector

if errorlevel 1 (
    echo.
    echo Error: Failed to start MCP Inspector
    echo Possible reasons:
    echo - Network connection issues
    echo - Package installation failed
    echo - Port already in use
    echo.
    pause
    exit /b 1
)

pause