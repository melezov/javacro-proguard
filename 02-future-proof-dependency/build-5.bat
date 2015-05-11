@echo off
setlocal
pushd "%~dp0"

if exist out-5 rmdir /S /Q out-5
mkdir out-5
cd out-5

echo.
echo ### JAVAC ###
echo.
javac -cp ..\lib\* ..\B64.java -d .

echo.
echo ### Unzip ###
echo.
unzip -o -qq ..\lib\*.jar

echo.
echo ### CUSTOM manifest ###
echo.
copy ..\res\MANIFEST.MF META-INF
echo.

echo.
echo ### JAR ###
echo.
jar -cfM B64-assembly.jar META-INF hr org

echo.
echo ### Proguard ###
echo.
copy ..\res\B64-5.pro B64.pro > NUL
call proguard @B64.pro

echo.
echo ### Unzip ###
echo.
unzip -q -d unzip B64-proguard.jar

echo.
echo ### Cleanup ###
echo.
rmdir /S /Q unzip\org\apache\commons\codec\language
del unzip\META-INF\*.txt
rmdir /S /Q unzip\META-INF\maven

echo.
echo ### PRIVATIZATION ###
echo.
ren unzip\hr\javacro\proguard\B64.class B64.classx
call privatize unzip\hr\javacro\proguard
ren unzip\hr\javacro\proguard\B64.classx B64.class

echo.
echo ### Compress ###
echo.
pushd unzip
zopfli -qa4 -i 200 ..\B64-cleanup.zip META-INF hr
kzip /q /r ..\B64-cleanup2.zip META-INF hr
popd

deflopt /s /b B64-*.zip
defluff < B64-cleanup.zip > B64-cleanup.jar 2> NUL
defluff < B64-cleanup2.zip > B64-cleanup2.jar 2> NUL
call holizip B64-cleanup.jar B64-cleanup2.jar
ren B64-cleanup.jar_B64-cleanup2.jar_merged.zip holizip.jar
del B64-cleanup*.*
ren holizip.jar B64-final.jar

echo.
echo ### DIR ###
echo.
dir /O-S *.jar
echo.
pause

echo.
echo ### Run! ###
echo.
echo Final test > test.txt
java -jar B64-final.jar < test.txt > test.b64

echo.
pause

echo.
echo ### JD-GUI ###
echo.
jd-gui ..\lib\commons-codec-1.10.jar ..\lib\commons-io-2.4.jar B64-final.jar

:END
popd
endlocal
goto :EOF
