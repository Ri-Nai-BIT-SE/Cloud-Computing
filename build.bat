@echo off
setlocal enabledelayedexpansion

echo Cleaning dist directory...
if exist dist (
    rmdir /s /q dist
)
mkdir dist

echo Building Cloud Computing project...
shiroa build --path-to-root /Cloud-Computing/
if !errorlevel! neq 0 (
    echo Error occurred during build.
    exit /b 1
)

echo Build completed successfully.
echo Build process completed successfully.
pause
