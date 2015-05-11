@echo off
setlocal
pushd "%~dp0"

if exist out-3 rmdir /S /Q out-3
mkdir out-3
cd out-3

echo.
echo ### JAVAC ###
echo.
javac ..\Pozdrav.java -d .

echo.
echo ### JAR ###
echo.
jar -cvfe Pozdrav-vanilla.jar hr.javacro.proguard.Pozdrav hr

echo.
echo ### Proguard ###
echo.
copy ..\res\Pozdrav-3.pro Pozdrav.pro > NUL
call proguard @Pozdrav.pro

echo.
dir /OD *.jar
echo.
pause

echo.
echo ### Run! ###
echo.
java -jar Pozdrav-proguard.jar

echo.
pause

echo.
echo ### JD-GUI ###
echo.
jd-gui Pozdrav-vanilla.jar Pozdrav-proguard.jar

echo.
echo ### DIR ###
echo.
dir /OD *.jar
echo.

echo.
pause

:END
popd
endlocal
goto :EOF
