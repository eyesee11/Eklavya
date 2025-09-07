# Sports Talent Assessment - ProGuard Rules

# Flutter and Dart specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# TensorFlow Lite Rules
-keep class org.tensorflow.lite.** { *; }
-keep class org.tensorflow.lite.support.** { *; }
-keepclassmembers class * {
    @org.tensorflow.lite.annotations.UsedByReflection <methods>;
}

# MediaPipe Rules
-keep class com.google.mediapipe.** { *; }
-keep class com.google.protobuf.** { *; }

# Camera Plugin Rules
-keep class io.flutter.plugins.camera.** { *; }
-keep class androidx.camera.** { *; }

# Video Player Rules
-keep class io.flutter.plugins.videoplayer.** { *; }

# Permission Handler Rules
-keep class com.baseflow.permissionhandler.** { *; }

# Dio HTTP Client Rules
-keep class dio.** { *; }

# Shared Preferences Rules
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# SQLite Rules
-keep class com.tekartik.sqflite.** { *; }

# Device Info Rules
-keep class dev.fluttercommunity.plus.device_info.** { *; }

# File Picker Rules
-keep class com.mr.flutter.plugin.filepicker.** { *; }

# Image Picker Rules
-keep class io.flutter.plugins.imagepicker.** { *; }

# Path Provider Rules
-keep class io.flutter.plugins.pathprovider.** { *; }

# Connectivity Rules
-keep class dev.fluttercommunity.plus.connectivity.** { *; }

# Gson Rules (for JSON serialization)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Remove logging in release builds
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# Keep model classes (add your specific model classes here)
-keep class com.sih.sportstalent.models.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep enum classes
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep Serializable classes
-keepnames class * implements java.io.Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Crashlytics (if added later)
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Remove debug and verbose logging
-assumenosideeffects class kotlin.jvm.internal.Intrinsics {
    static void checkParameterIsNotNull(java.lang.Object, java.lang.String);
}
