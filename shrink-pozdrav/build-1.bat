@echo off
setlocal
pushd "%~dp0"

if exist out-1 rmdir /S /Q out-1
mkdir out-1
cd out-1

echo.
echo ### JAVAC ###
echo.
javac -verbose ..\Pozdrav.java -d .

echo.
echo ### JAR ###
echo.
jar -cvfe Pozdrav.jar com.javacro.proguard.Pozdrav com

echo.
echo ### JD-GUI ###
echo.
jd-gui Pozdrav.jar

echo.
echo ### Run! ###
echo.
java -jar Pozdrav.jar

echo.
pause

:END
popd
endlocal
goto :EOF
