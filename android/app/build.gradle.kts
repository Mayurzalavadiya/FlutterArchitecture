plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}

android {
    namespace = "com.example.my_first_app"
    compileSdk = flutter.compileSdkVersion
//    ndkVersion = flutter.ndkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true

    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.my_first_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // ✅ Replace with your actual release signing config
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false

            /*ndk {
                debugSymbolLevel = DebugSymbolLevel.FULL
            }*/

        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.core:core:1.9.0")
    // Import the BoM for the Firebase platform
    implementation(platform("com.google.firebase:firebase-bom:34.0.0"))
    //Messaging
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    // Add the dependency for the Firebase Authentication library
    // When using the BoM, you don't specify versions in Firebase library dependencies
    implementation("com.google.firebase:firebase-auth")
    implementation ("com.google.firebase:firebase-crashlytics")
    implementation ("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-crashlytics-ndk")
    implementation("com.google.android.gms:play-services-auth:21.0.0")
}
