@echo off
chcp 65001 >nul
title Sincronizar proyecto k1-pcb
color 0F

echo ============================================================
echo   SINCRONIZANDO PROYECTO k1-pcb
echo ============================================================
echo.

cd /d "C:\Users\juanc\Documents\proyectos\k1-pcb"
if errorlevel 1 (
    echo [ERROR] No encuentro la carpeta del proyecto:
    echo         C:\Users\juanc\Documents\proyectos\k1-pcb
    goto fin
)

rem ---------- 1. GIT PULL ----------
echo ------------------------------------------------------------
echo  Paso 1 de 4: Descargando cambios del servidor...
echo ------------------------------------------------------------
git pull
if errorlevel 1 (
    echo.
    echo [ERROR] No se han podido descargar los cambios del servidor.
    echo         Puede que no haya conexion o que haya un conflicto
    echo         entre tus archivos y los del servidor. Me detengo aqui
    echo         para no estropear nada.
    goto fin
)
echo.
echo  ^>^> HECHO: Tu carpeta ya tiene la ultima version que habia en el servidor.
echo.

rem ---------- 2. GIT ADD ----------
echo ------------------------------------------------------------
echo  Paso 2 de 4: Preparando tus archivos modificados...
echo ------------------------------------------------------------
git add -A
if errorlevel 1 (
    echo.
    echo [ERROR] No se han podido preparar los archivos.
    goto fin
)
echo.
echo  ^>^> HECHO: He marcado todos tus archivos nuevos, modificados y borrados
echo     para guardarlos.
echo.

rem ---------- 3. GIT COMMIT ----------
echo ------------------------------------------------------------
echo  Paso 3 de 4: Guardando los cambios con el nombre "Cambios Juan Carlos"...
echo ------------------------------------------------------------
git diff --cached --quiet
if not errorlevel 1 (
    echo.
    echo  ^>^> No habia nada nuevo que guardar. Tus archivos ya estaban al dia.
    echo.
    goto push
)
git commit -m "Cambios Juan Carlos"
if errorlevel 1 (
    echo.
    echo [ERROR] No se han podido guardar los cambios.
    goto fin
)
echo.
echo  ^>^> HECHO: Tus cambios han quedado guardados en tu ordenador
echo     con el nombre "Cambios Juan Carlos".
echo.

rem ---------- 4. GIT PUSH ----------
:push
echo ------------------------------------------------------------
echo  Paso 4 de 4: Subiendo tus cambios al servidor...
echo ------------------------------------------------------------
git push
if errorlevel 1 (
    echo.
    echo [ERROR] No se han podido subir los cambios al servidor.
    echo         Revisa la conexion a internet o tus credenciales.
    goto fin
)
echo.
echo  ^>^> HECHO: Tus cambios ya estan en el servidor y el resto del
echo     equipo puede verlos.
echo.
echo ============================================================
echo   TODO TERMINADO CORRECTAMENTE
echo ============================================================

:fin
echo.
echo  Puedes cerrar esta ventana cuando quieras.
:espera
pause >nul
goto espera
