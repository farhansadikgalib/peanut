## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**

## Dart
-keep class com.google.firebase.** { *; }
-keep class androidx.** { *; }

## GetX
-keep class com.example.peanut.** { *; }
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses

## Dio
-keepattributes SourceFile,LineNumberTable
-keep class com.google.gson.** { *; }
-keep class sun.misc.Unsafe { *; }

## General
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception
-printmapping mapping.txt
