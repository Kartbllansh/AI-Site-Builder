@echo off

echo ===== React/Vite Build Script =====
echo.

:: Check Node.js
echo [1/5] Checking Node.js...
node -v > nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js is not installed
    echo Download from https://nodejs.org/
    pause
    exit /b 1
)
echo OK: Node.js found

:: Check npm
echo [2/5] Checking npm...
for /f "delims=" %%i in ('npm -v 2^>^&1') do set npm_version=%%i
if defined npm_version (
    echo OK: npm found, version: %npm_version%
) else (
    echo ERROR: npm not found
    pause
    exit /b 1
)

:: Пропускаем создание конфига если он уже есть
echo [3/5] Skipping config check...

:: Устанавливаем зависимости через прямой вызов
echo [4/5] Installing dependencies...
cmd /c "npm.cmd install"
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)
echo OK: Dependencies installed

:: Собираем проект
echo [5/5] Building project...
cmd /c "npm.cmd run build"
if errorlevel 1 (
    echo ERROR: Build failed
    pause
    exit /b 1
)

if exist "dist" (
    echo SUCCESS: Build completed!
    echo Files in dist folder:
    dir dist /b
) else (
    echo ERROR: dist folder not created
)

pause