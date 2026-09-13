@echo off
setlocal

set BASE_DIR=%~dp0..
set INPUT=%BASE_DIR%\input\clientes_input.txt
set PROCESSED=%BASE_DIR%\processed
set LOG=%BASE_DIR%\logs\controlm.log

echo ====================================== >> "%LOG%"
echo JOB_04 - ARCHIVAR INPUT >> "%LOG%"
echo Fecha: %date% %time% >> "%LOG%"
echo ====================================== >> "%LOG%"

echo.
echo ======================================
echo JOB_04 - ARCHIVAR INPUT
echo ======================================
echo.

if not exist "%INPUT%" (
    echo ERROR: No existe el archivo de entrada >> "%LOG%"
    echo JOB_04 ERROR
    exit /b 1
)

if not exist "%PROCESSED%" (
    mkdir "%PROCESSED%"
)

copy /Y "%INPUT%" "%PROCESSED%\clientes_input_%date:~-4%%date:~3,2%%date:~0,2%.txt" >nul

if errorlevel 1 (
    echo ERROR: No se pudo archivar el archivo >> "%LOG%"
    echo JOB_04 ERROR
    exit /b 1
)

echo OK: Archivo archivado >> "%LOG%"
echo JOB_04 OK >> "%LOG%"

echo Archivo archivado correctamente.
echo.
echo JOB_04 - OK

exit /b 0