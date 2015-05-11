@echo off
setlocal
pushd "%~dp0"

if exist out-3 rmdir /S /Q out-3
mkdir out-3
cd out-3

echo.
echo ### JAVAC ###
echo.
javac -cp ..\lib\* ..\B64.java -d .

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
jar -cfM B64-assembly.jar META-INF com org

echo.
echo ### Proguard ###
echo.
copy ..\res\B64-3.pro B64.pro > NUL
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
echo ### Compress ###
echo.
pushd unzip
zopfli -qa4 -i 200 ..\B64-cleanup.zip META-INF a com
kzip /q /r ..\B64-cleanup2.zip META-INF a com
popd

deflopt /s /b B64-*.zip
defluff < B64-cleanup.zip > B64-cleanup.jar
defluff < B64-cleanup2.zip > B64-cleanup2.jar
call holizip B64-cleanup.jar B64-cleanup2.jar
ren B64-cleanup.jar_B64-cleanup2.jar_merged.zip holizip.jar
del B64-cleanup*.*
ren holizip.jar B64-obfuscated.jar

echo.
echo ### DIR ###
echo.
dir /O-S *.jar
echo.
pause

echo.
echo ### Run! ###
echo.
echo Obfuscated test > test.txt
java -jar B64-obfuscated.jar < test.txt > test.b64

echo.
pause

echo.
echo ### JD-GUI ###
echo.
jd-gui ..\lib\commons-codec-1.10.jar ..\lib\commons-io-2.4.jar B64-obfuscated.jar

:END
popd
endlocal
goto :EOF
