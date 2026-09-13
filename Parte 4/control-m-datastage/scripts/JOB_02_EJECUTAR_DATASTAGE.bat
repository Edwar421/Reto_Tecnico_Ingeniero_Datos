@echo off
setlocal

set BASE_DIR=%~dp0..
set LOG=%BASE_DIR%\logs\controlm.log

echo ====================================== >> "%LOG%"
echo JOB_02 - EJECUCION DATASTAGE >> "%LOG%"
echo Fecha: %date% %time% >> "%LOG%"
echo ====================================== >> "%LOG%"

echo.
echo ======================================
echo JOB_02 - EJECUCION DATASTAGE
echo ======================================
echo.

echo DataStage: IBM Cloud Pak for Data >> "%LOG%"
echo Flujo: DS_CLIENTES_TRANS >> "%LOG%"
echo Ejecucion: Realizada en IBM DataStage >> "%LOG%"

echo.
echo IMPORTANTE:
echo La ejecucion del flujo DataStage se realiza
echo desde IBM Cloud Pak for Data.
echo.

echo Flujo: DS_CLIENTES_TRANS
echo Proyecto: prueba-datastage-bdb
echo.

echo Ejecucion DataStage registrada >> "%LOG%"
echo JOB_02 OK >> "%LOG%"

echo JOB_02 - OK
exit /b 0