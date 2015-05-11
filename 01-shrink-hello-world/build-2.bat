@echo off
setlocal
pushd "%~dp0"

if exist out-2 rmdir /S /Q out-2
mkdir out-2
cd out-2

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
copy ..\res\Pozdrav.pro . > NUL
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
echo ### JAVAP ###
echo.
unzip Pozdrav-proguard.jar -d diff
javap -l -p -c hr\javacro\proguard\Pozdrav.class > Pozdrav.javap
javap -l -p -c hr\javacro\proguard\Pozdrav$Poruka.class > Pozdrav$Poruka.javap
javap -l -p -c diff\hr\javacro\proguard\Pozdrav.class > diff\Pozdrav.javap
javap -l -p -c diff\hr\javacro\proguard\a.class > diff\a.javap
TortoiseGitMerge Pozdrav.javap diff\Pozdrav.javap
TortoiseGitMerge Pozdrav$Poruka.javap diff\a.javap

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
