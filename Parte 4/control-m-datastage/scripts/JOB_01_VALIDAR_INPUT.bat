@echo off
setlocal

set BASE_DIR=%~dp0..
set INPUT=%BASE_DIR%\input\clientes_input.txt
set LOG=%BASE_DIR%\logs\controlm.log

echo ====================================== >> "%LOG%"
echo JOB_01 - VALIDACION DE INPUT >> "%LOG%"
echo Fecha: %date% %time% >> "%LOG%"
echo ====================================== >> "%LOG%"

if not exist "%INPUT%" (
    echo ERROR: No existe clientes_input.txt >> "%LOG%"
    echo JOB_01 ERROR
    exit /b 1
)

for %%A in ("%INPUT%") do set SIZE=%%~zA

if "%SIZE%"=="0" (
    echo ERROR: clientes_input.txt esta vacio >> "%LOG%"
    echo JOB_01 ERROR
    exit /b 1
)

echo OK: Archivo encontrado >> "%LOG%"
echo OK: Tamano del archivo: %SIZE% bytes >> "%LOG%"
echo JOB_01 OK >> "%LOG%"

echo.
echo JOB_01 - VALIDACION EXITOSA
echo Archivo: clientes_input.txt
echo Tamano: %SIZE% bytes

exit /b 0