plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.ager_waffer"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"          // ← THIS LINE fixes the inconsistency error
    }

    defaultConfig {
        applicationId = "com.example.ager_waffer"
        minSdk = 23
        targetSdk = 36
        versionCode = 1                  // ← just a number
        versionName = "1.0"              // ← any string you want
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ... your other dependencies

    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")   // ← Latest stable as of Nov 2025
}
