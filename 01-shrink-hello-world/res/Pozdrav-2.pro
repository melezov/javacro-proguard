-injars Pozdrav-vanilla.jar
-outjars Pozdrav-proguard.jar

-dontoptimize
-printmapping Pozdrav.map

-libraryjars d:\Java\JDK\JDK-8u45-x64\jre\lib\rt.jar

-keep class hr.javacro.proguard.Pozdrav { public *; }
