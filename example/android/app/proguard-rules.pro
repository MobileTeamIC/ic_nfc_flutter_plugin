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

-dontwarn javax.naming.Binding
-dontwarn javax.naming.NamingEnumeration
-dontwarn javax.naming.NamingException
-dontwarn javax.naming.directory.Attribute
-dontwarn javax.naming.directory.Attributes
-dontwarn javax.naming.directory.DirContext
-dontwarn javax.naming.directory.InitialDirContext
-dontwarn javax.naming.directory.SearchControls
-dontwarn javax.naming.directory.SearchResult
-dontwarn org.bouncycastle.jsse.BCSSLParameters
-dontwarn org.bouncycastle.jsse.BCSSLSocket
-dontwarn org.bouncycastle.jsse.provider.BouncyCastleJsseProvider
-dontwarn org.conscrypt.Conscrypt$Version
-dontwarn org.conscrypt.Conscrypt
-dontwarn org.conscrypt.ConscryptHostnameVerifier
-dontwarn org.openjsse.javax.net.ssl.SSLParameters
-dontwarn org.openjsse.javax.net.ssl.SSLSocket
-dontwarn org.openjsse.net.ssl.OpenJSSE
