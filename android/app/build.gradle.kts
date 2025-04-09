////plugins {
////    id("com.android.application")
////    id("kotlin-android")
////    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
////    id("dev.flutter.flutter-gradle-plugin")
//////    id("com.google.gms.google-services")
////}
////dependencies{
////    implementation(platform("com.google.firebase:firebase-bom:33.12.0"))
//////    implementation("com.google.firebase:firebase-analytics")
////    implementation ("com.google.android.gms:play-services-auth:20.7.0")
//////    https://firebase.google.com/docs/android/setup#available-libraries
////    implementation ("com.google.firebase:firebase-analytics:22.4.0")
////}
////android {
////    namespace = "com.example.rentronix"
////    compileSdk = flutter.compileSdkVersion
////    ndkVersion = "27.0.12077973"
////
////    compileOptions {
////        sourceCompatibility = JavaVersion.VERSION_11
////        targetCompatibility = JavaVersion.VERSION_11
////    }
////    tasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile).configureEach {
////        kotlinOptions {
////            jvmTarget = JavaVersion.VERSION_17.toString()
//////            jvmTarget = '17'.toString() // Use appropriate JVM target
////            // This helps with Kotlin metadata version conflicts
////            freeCompilerArgs = freeCompilerArgs + listOf("-Xskip-metadata-version-check")
////        }
////
//////    kotlinOptions {
//////        jvmTarget = JavaVersion.VERSION_11.toString()
//////        jvmTarget = '17' // Use appropriate JVM target
//////        freeCompilerArgs += ["-Xjvm-default=all"]
//////    }
////
////    defaultConfig {
////        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
////        applicationId = "com.example.rentronix"
////        // You can update the following values to match your application needs.
////        // For more information, see: https://flutter.dev/to/review-gradle-config.
////        minSdk = 23
////        targetSdk = flutter.targetSdkVersion
////        versionCode = flutter.versionCode
////        versionName = flutter.versionName
////    }
////
////    buildTypes {
////        release {
////            // TODO: Add your own signing config for the release build.
////            // Signing with the debug keys for now, so `flutter run --release` works.
////            signingConfig = signingConfigs.getByName("debug")
////        }
////    }
////}
////
////flutter {
////    source = "../.."
////}
//
//


//plugins {
//    id("com.android.application")
//    id("kotlin-android")
//    // Flutter plugin must come after Android and Kotlin plugins
//    id("dev.flutter.flutter-gradle-plugin")
//    id("com.google.gms.google-services") // Required for Firebase
//}
//
//android {
//    tasks.whenTaskAdded { task ->
//        if (task.name == 'copyFlutterAssetsDebug') {
//            task.doFirst {
//                task.destinationDir = file("${buildDir}/intermediates/flutter_assets/debug")
//            }
//        }
//    }
//    buildFeatures {
//        buildConfig = true
//    }
//
//    namespace = "com.example.rentronix"
//    compileSdk = flutter.compileSdkVersion
//    ndkVersion = "27.0.12077973"
//
//    defaultConfig {
//        applicationId = "com.example.rentronix"
//        minSdk = 23
//        targetSdk = flutter.targetSdkVersion
//        versionCode = flutter.versionCode
//        versionName = flutter.versionName
//    }
//
//
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_11
//        targetCompatibility = JavaVersion.VERSION_11
//    }
//
//    kotlinOptions {
//        jvmTarget = JavaVersion.VERSION_11.toString()
//        freeCompilerArgs += listOf("-Xskip-metadata-version-check")
//    }
//
//    buildTypes {
//        release {
//            signingConfig = signingConfigs.getByName("debug") // TODO: Replace with release key
//        }
//    }
//}
//flutter {
//    source = "../.."
//}
//
//dependencies {
//    implementation(platform("com.google.firebase:firebase-bom:33.12.0"))
//
//    // Firebase services (select as needed)
//    implementation("com.google.firebase:firebase-analytics")
//    implementation("com.google.android.gms:play-services-auth:21.3.0")
//}


//plugins {
//    id("com.android.application")
//    id("kotlin-android")
//    // Flutter plugin must come after Android and Kotlin plugins
//    id("dev.flutter.flutter-gradle-plugin")
//    id("com.google.gms.google-services") // Required for Firebase
//}
//
//// Add this at the top level, outside any blocks
//gradle.projectsEvaluated {
//    tasks.findByName("copyFlutterAssetsDebug")?.let { task ->
//        task.destinationDir = new File(buildDir,"intermediates/flutter_assets/debug");
//    }
//}
//
//android {
//    buildFeatures {
//        buildConfig = true
//    }
//
//    namespace = "com.example.rentronix"
//    compileSdk = flutter.compileSdkVersion
//    ndkVersion = "27.0.12077973"
//
//    defaultConfig {
//        applicationId = "com.example.rentronix"
//        minSdk = 23
//        targetSdk = flutter.targetSdkVersion
//        versionCode = flutter.versionCode
//        versionName = flutter.versionName
//    }
//
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_11
//        targetCompatibility = JavaVersion.VERSION_11
//    }
//
//    kotlinOptions {
//        jvmTarget = JavaVersion.VERSION_11.toString()
//        freeCompilerArgs += listOf("-Xskip-metadata-version-check")
//    }
//
//    buildTypes {
//        release {
//            signingConfig = signingConfigs.getByName("debug") // TODO: Replace with release key
//        }
//    }
//}
//
//flutter {
//    source = "../.."
//}
//
//dependencies {
//    implementation(platform("com.google.firebase:firebase-bom:33.12.0"))
//
//    // Firebase services (select as needed)
//    implementation("com.google.firebase:firebase-analytics")
//    implementation("com.google.android.gms:play-services-auth:21.3.0")
//}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter plugin must come after Android and Kotlin plugins
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Required for Firebase
}

// Add this at the top level, outside any blocks
gradle.projectsEvaluated {
    tasks.findByName("copyFlutterAssetsDebug")?.let { task ->
        if (task is Copy) {
            task.destinationDir = File(layout.buildDirectory.get().asFile, "intermediates/flutter_assets/debug")
        }
    }
}

android {
    buildFeatures {
        buildConfig = true
    }

    namespace = "com.example.rentronix"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.example.rentronix"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
        freeCompilerArgs += listOf("-Xskip-metadata-version-check")
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // TODO: Replace with release key
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.12.0"))

    // Firebase services (select as needed)
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.android.gms:play-services-auth:21.3.0")
}