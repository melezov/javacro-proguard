-injars B64-assembly.jar
-outjars B64-proguard.jar

-libraryjars d:\Java\JDK\JDK-8u45-x64\jre\lib\rt.jar
-dontwarn org.apache.commons.codec.digest.HmacUtils

-printmapping B64.map
-keep class hr.javacro.proguard.B64 { public *; }

-forceprocessing
-optimizationpasses 1024
-allowaccessmodification
-mergeinterfacesaggressively
-overloadaggressively

-repackageclasses hr.javacro.proguard
