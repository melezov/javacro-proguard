@echo off
setlocal
pushd "%~dp0"

if exist out-1 rmdir /S /Q out-1
mkdir out-1
cd out-1

echo.
echo ### JAVAC ###
echo.
javac -verbose -cp ..\lib\* ..\B64.java -d .

echo.
echo ### Unzip ###
echo.
unzip -o -q ..\lib\*.jar

echo.
echo ### CUSTOM manifest ###
echo.
copy ..\res\MANIFEST.MF META-INF
echo.

echo.
echo ### JAR ###
echo.
jar -cvfM B64-assembly.jar META-INF hr org

echo.
echo ### Run! ###
echo.
echo Assembly test > test.txt
java -jar B64-assembly.jar < test.txt > test.b64

echo.
pause

:END
popd
endlocal
goto :EOF
