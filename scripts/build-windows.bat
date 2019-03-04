@echo off

call set-windows-env.bat

pushd ..
qmake.exe librecad.pro -r -spec win32-g++
if not _%1==_NoClean (
	mingw32-make.exe clean
)
mingw32-make.exe -j4
if NOT exist windows\dxf2pdf.exe (
	echo "Building windows\dxf2pdf.exe failed!"
	exit /b /1
)
windeployqt.exe windows\dxf2pdf.exe
popd
rem call build-win-setup.bat
