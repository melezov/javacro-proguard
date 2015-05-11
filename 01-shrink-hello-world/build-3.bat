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
echo ### CUSTOM manifest ###
echo.
mkdir META-INF
copy ..\res\MANIFEST.MF META-INF
echo.

echo.
echo ### JAR ###
echo.
jar -cvfM Pozdrav-vanilla.jar META-INF hr
echo.

echo.
echo ### Proguard ###
echo.
copy ..\res\Pozdrav.pro Pozdrav.pro > NUL
call proguard @Pozdrav.pro

echo.
dir /OD *.jar
echo.
pause

echo.
echo ### Unzip ###
echo.
unzip Pozdrav-proguard.jar -d unzip

echo.
echo ### ZOPFLI ###
echo.
pushd unzip
zopfli -a4 -i 200 ..\Pozdrav-proguard-zopfli.jar META-INF hr
popd

echo.
echo ### KZIP ###
echo.
pushd unzip
kzip /r ..\Pozdrav-proguard-kzip.jar META-INF hr
popd

echo.
echo ### DEFLOPT ###
echo.
ren Pozdrav-proguard-zopfli.jar Pozdrav-proguard-zopfli-deflopt.zip
ren Pozdrav-proguard-kzip.jar Pozdrav-proguard-kzip-deflopt.zip
deflopt /b Pozdrav-*-deflopt.zip
ren Pozdrav-proguard-zopfli-deflopt.zip Pozdrav-proguard-zopfli-deflopt.jar
ren Pozdrav-proguard-kzip-deflopt.zip Pozdrav-proguard-kzip-deflopt.jar

echo.
echo ### DEFLUFF ###
echo.
defluff < Pozdrav-proguard-zopfli-deflopt.jar > Pozdrav-zopfli.jar
defluff < Pozdrav-proguard-kzip-deflopt.jar > Pozdrav-kzip.jar

del Pozdrav-*-deflopt.jar

echo.
echo ### DIR ###
echo.
dir /O-S *.jar
echo.
pause

echo.
echo ### ZIPMGR ###
echo.
zipmgr

echo.
echo ### HOLIZIP ###
echo.
call holizip Pozdrav-zopfli.jar Pozdrav-kzip.jar
ren Pozdrav-zopfli.jar_Pozdrav-kzip.jar_merged.zip Pozdrav-holizip.jar

echo.
echo ### DIR ###
echo.
dir /O-S *.jar
echo.
pause

:END
popd
endlocal
goto :EOF
