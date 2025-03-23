plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Apply this in `app/build.gradle.kts`
}

dependencies {
    // Import the Firebase BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:33.11.0"))
    implementation("com.google.firebase:firebase-analytics")

    // Add dependencies for any other Firebase services here
    // Example: implementation("com.google.firebase:firebase-auth")
}

android {
    namespace = "com.example.lunasphere"
    compileSdk = 35 // Manually set, as Flutter might not define it
    ndkVersion = "27.1.12297006" // Set the correct installed NDK version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.example.lunasphere"
        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // Change if needed
        }
    }
}

flutter {
    source = "../.."
}
