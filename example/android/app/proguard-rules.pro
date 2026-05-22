# ProGuard rules for VNPT NFC SDK example app

# ---- VNPT NFC SDK ----
-keep class com.vnptit.nfc.** { *; }
-keep class com.vnpt.** { *; }

# Suppress warnings for missing native lib classes (loaded dynamically at runtime)
-dontwarn ai.icenter.face3d.native_lib.CardConfig
-dontwarn ai.icenter.face3d.native_lib.CardWrapper$Result
-dontwarn ai.icenter.face3d.native_lib.CardWrapper
-dontwarn ai.icenter.face3d.native_lib.NativeLoader
-keep class ai.icenter.face3d.native_lib.** { *; }

# ---- Flutter ----
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Flutter deferred components use Google Play Core (not used in this example app)
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**
-dontwarn com.google.android.play.core.**
