@ECHO OFF

REM from librecad/src goto LibreCAD root folder
REM CAUTION! pushd isn't tolerant for /, use \
pushd ..\..
cd > PWD
set /p LC_PWD= < PWD
del PWD

set LC_RESOURCEDIR=%LC_PWD%\windows\resources
rem set LC_TSDIRLC=%LC_PWD%\librecad\ts
rem set LC_TSDIRPI=%LC_PWD%\plugins\ts
rem set LC_NSISDIR=%LC_PWD%\scripts\postprocess-windows

REM Postprocess for windows
echo " Copying fonts and patterns"
if not exist "%LC_RESOURCEDIR%\fonts\" (mkdir "%LC_RESOURCEDIR%\fonts")
if not exist "%LC_RESOURCEDIR%\patterns\" (mkdir "%LC_RESOURCEDIR%\patterns")
rem if not exist "%LC_RESOURCEDIR%\library\" (mkdir "%LC_RESOURCEDIR%\library")
rem if not exist "%LC_RESOURCEDIR%\library\misc\" (mkdir "%LC_RESOURCEDIR%\library\misc")
rem if not exist "%LC_RESOURCEDIR%\library\templates\" (mkdir "%LC_RESOURCEDIR%\library\templates")

copy "librecad\support\patterns\*.dxf" "%LC_RESOURCEDIR%\patterns"
copy "librecad\support\fonts\*.lff" "%LC_RESOURCEDIR%\fonts"
rem copy "librecad\support\library\misc\*.dxf" "%LC_RESOURCEDIR%\library\misc"
rem copy "librecad\support\library\templates\*.dxf" "%LC_RESOURCEDIR%\library\templates"


REM Generate translations
rem echo "Generating Translations"
rem lrelease librecad\src\src.pro
rem lrelease plugins\plugins.pro
rem if not exist "%LC_RESOURCEDIR%\qm\" (mkdir "%LC_RESOURCEDIR%\qm")

REM translations for LibreCAD
rem cd "%LC_TSDIRLC%"
rem for /f %%F in ('dir /b *.qm') do (
rem         copy "%%F" "%LC_RESOURCEDIR%\qm\%%F"
rem )

REM translations for PlugIns
rem cd "%LC_TSDIRPI%"
rem for /f %%F in ('dir /b *.qm') do (
rem         copy "%%F" "%LC_RESOURCEDIR%\qm\%%F"
rem )

REM Create NSIS-Include file
rem set LC_SCMREV_NSH=%LC_NSISDIR%\generated_scmrev.nsh
rem echo Create %LC_SCMREV_NSH% for NSIS Installer
rem echo ;CAUTION! >%LC_SCMREV_NSH%
rem echo ;this file is created by postprocess-win.bat during build process >>%LC_SCMREV_NSH%
rem echo ;changes will be overwritten, use custom.nsh for local settings >>%LC_SCMREV_NSH%
rem echo. >>%LC_SCMREV_NSH%
rem echo !define SCMREVISION "%1" >>%LC_SCMREV_NSH%
rem echo. >>%LC_SCMREV_NSH%

rem if exist %LC_NSISDIR%\custom-*.ns? (
rem 	echo.
rem 	echo Warning!
rem 	echo An old NSIS custom include file was found!
rem 	echo Please, rename it to custom.nsh.
rem 	echo.
rem )

REM return to librecad/src
popd
