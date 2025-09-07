plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.sih.sportstalent"
    compileSdk = 34
    ndkVersion = "25.2.9519653"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.sih.sportstalent"
        // Minimum SDK 21 for better Camera2 API and ML support
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
        
        // Enable multidex for large apps
        multiDexEnabled = true
        
        // Optimize for performance
        vectorDrawables.useSupportLibrary = true
        
        // NDK configuration for TensorFlow Lite
        ndk {
            abiFilters += listOf("arm64-v8a", "armeabi-v7a", "x86_64")
        }
        
        // Proguard configuration
        proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
    }

    buildTypes {
        debug {
            isMinifyEnabled = false
            isShrinkResources = false
            isDebuggable = true
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-debug"
        }
        
        release {
            // Enable R8 optimization
            isMinifyEnabled = true
            isShrinkResources = true
            isDebuggable = false
            
            // Signing with debug keys for now - replace with release keys later
            signingConfig = signingConfigs.getByName("debug")
            
            // Proguard rules
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
    
    // Optimize APK size
    packagingOptions {
        resources {
            excludes += listOf(
                "META-INF/DEPENDENCIES",
                "META-INF/LICENSE",
                "META-INF/LICENSE.txt",
                "META-INF/NOTICE",
                "META-INF/NOTICE.txt"
            )
        }
    }
}

flutter {
    source = "../.."
}
