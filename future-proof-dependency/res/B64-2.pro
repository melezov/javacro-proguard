-injars B64-assembly.jar
-outjars B64-proguard.jar

-libraryjars d:\Java\JDK\JDK-8u45-x64\jre\lib\rt.jar
-dontwarn org.apache.commons.codec.digest.HmacUtils

-dontobfuscate
-keep class com.javacro.proguard.B64 { public *; }
