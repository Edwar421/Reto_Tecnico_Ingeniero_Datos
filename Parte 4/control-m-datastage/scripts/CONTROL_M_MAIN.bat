@echo off
setlocal

set BASE_DIR=%~dp0..
set LOG=%BASE_DIR%\logs\controlm.log
set MAX_ATTEMPTS=3
set RETRY_WAIT=5

echo.
echo ==============================================
echo       CONTROL-M - SIMULACION DE ORQUESTACION
echo ==============================================
echo.

echo ====================================== >> "%LOG%"
echo CONTROL-M - INICIO DE EJECUCION >> "%LOG%"
echo Fecha: %date% %time% >> "%LOG%"
echo ====================================== >> "%LOG%"

echo [1/4] Ejecutando JOB_01...
call :RUN_JOB "%~dp0JOB_01_VALIDAR_INPUT.bat" "JOB_01_VALIDAR_INPUT"

if errorlevel 1 (
    echo.
    echo ALERTA: JOB_01 fallo despues de los reintentos.
    echo CONTROL-M: flujo detenido.
    echo.
    exit /b 1
)

echo.
echo [1/4] JOB_01 OK
echo.

echo [2/4] Ejecutando JOB_02...
call :RUN_JOB "%~dp0JOB_02_EJECUTAR_DATASTAGE.bat" "JOB_02_EJECUTAR_DATASTAGE"

if errorlevel 1 (
    echo.
    echo ALERTA: JOB_02 fallo despues de los reintentos.
    echo CONTROL-M: flujo detenido.
    echo.
    exit /b 1
)

echo.
echo [2/4] JOB_02 OK
echo.

echo [3/4] Ejecutando JOB_03...
call :RUN_JOB "%~dp0JOB_03_VALIDAR_OUTPUT.bat" "JOB_03_VALIDAR_OUTPUT"

if errorlevel 1 (
    echo.
    echo ALERTA: JOB_03 fallo despues de los reintentos.
    echo CONTROL-M: flujo detenido.
    echo.
    exit /b 1
)

echo.
echo [3/4] JOB_03 OK
echo.

echo [4/4] Ejecutando JOB_04...
call :RUN_JOB "%~dp0JOB_04_MOVER_ARCHIVO.bat" "JOB_04_MOVER_ARCHIVO"

if errorlevel 1 (
    echo.
    echo ALERTA: JOB_04 fallo despues de los reintentos.
    echo CONTROL-M: flujo detenido.
    echo.
    exit /b 1
)

echo.
echo [4/4] JOB_04 OK
echo.

echo ==============================================
echo       FLUJO COMPLETADO CORRECTAMENTE
echo ==============================================

echo CONTROL-M - EJECUCION EXITOSA >> "%LOG%"
echo Fecha fin: %date% %time% >> "%LOG%"

exit /b 0


:RUN_JOB

set "JOB_SCRIPT=%~1"
set "JOB_NAME=%~2"
set /a ATTEMPT=1

:RETRY_JOB

echo.
echo ----------------------------------------------
echo %JOB_NAME% - INTENTO %ATTEMPT%/%MAX_ATTEMPTS%
echo ----------------------------------------------

echo %JOB_NAME% - Intento %ATTEMPT%/%MAX_ATTEMPTS% >> "%LOG%"

call "%JOB_SCRIPT%"

if not errorlevel 1 (
    echo %JOB_NAME% - EJECUCION EXITOSA >> "%LOG%"
    exit /b 0
)

echo.
echo ERROR: %JOB_NAME% fallo en el intento %ATTEMPT%.
echo %JOB_NAME% - ERROR en intento %ATTEMPT% >> "%LOG%"

if %ATTEMPT% GEQ %MAX_ATTEMPTS% (
    echo.
    echo ==============================================
    echo ALERTA: %JOB_NAME% - REINTENTOS AGOTADOS
    echo ==============================================
    
    echo ALERTA: %JOB_NAME% - Reintentos agotados >> "%LOG%"
    echo %JOB_NAME% - EJECUCION FALLIDA >> "%LOG%"
    
    exit /b 1
)

set /a ATTEMPT+=1

echo.
echo Reintento disponible.
echo Esperando %RETRY_WAIT% segundos...

echo %JOB_NAME% - Esperando %RETRY_WAIT% segundos para reintento >> "%LOG%"

timeout /t %RETRY_WAIT% /nobreak >nul

goto RETRY_JOB