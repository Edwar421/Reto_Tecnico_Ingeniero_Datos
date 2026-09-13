@echo off
setlocal

set BASE_DIR=%~dp0..
set OUTPUT=%BASE_DIR%\output\clientes_output.csv
set LOG=%BASE_DIR%\logs\controlm.log

echo ====================================== >> "%LOG%"
echo JOB_03 - VALIDACION DE OUTPUT >> "%LOG%"
echo Fecha: %date% %time% >> "%LOG%"
echo ====================================== >> "%LOG%"

echo.
echo ======================================
echo JOB_03 - VALIDACION DE OUTPUT
echo ======================================
echo.

if not exist "%OUTPUT%" (
    echo ERROR: No existe clientes_output.csv >> "%LOG%"
    echo JOB_03 ERROR
    echo.
    echo ERROR: No se encontro el archivo de salida.
    exit /b 1
)

for %%A in ("%OUTPUT%") do set SIZE=%%~zA

if "%SIZE%"=="0" (
    echo ERROR: clientes_output.csv esta vacio >> "%LOG%"
    echo JOB_03 ERROR
    echo.
    echo ERROR: El archivo de salida esta vacio.
    exit /b 1
)

echo OK: Archivo de salida encontrado >> "%LOG%"
echo OK: Tamano: %SIZE% bytes >> "%LOG%"
echo JOB_03 OK >> "%LOG%"

echo Archivo encontrado: clientes_output.csv
echo Tamano: %SIZE% bytes
echo.
echo JOB_03 - VALIDACION EXITOSA

exit /b 0