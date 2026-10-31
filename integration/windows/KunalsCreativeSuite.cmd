@echo off
setlocal
cd /d "%~dp0"
:menu
cls
echo ============================================
echo        Kunal's Creative Suite
echo ============================================
echo.
echo 1. Image Editor (PhotoCraft-based)
echo 2. Vector Editor (VectorCraft-based)
echo 3. Exit
echo.
choice /c 123 /n /m "Select an editor [1/2/3]: "
if errorlevel 3 exit /b 0
if errorlevel 2 (
  if not exist "VectorEditor.exe" (
    echo VectorEditor.exe was not found in this folder.
    pause
    goto menu
  )
  start "" "%~dp0VectorEditor.exe"
  exit /b 0
)
if errorlevel 1 (
  if not exist "KunalsImageEditor.exe" (
    echo KunalsImageEditor.exe was not found in this folder.
    pause
    goto menu
  )
  start "" "%~dp0KunalsImageEditor.exe"
  exit /b 0
)
goto menu
