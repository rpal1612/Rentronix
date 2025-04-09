//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//
//plugins{
//    id("com.google.gms.google-services") version "4.3.15" apply false
//    id("com.android.application") version "8.7.0" apply false
//    kotlin("android") version "1.9.0"
//    id("com.android.application")
//
//
////    id("com.android.library") version "8.7.0" apply false
////    id("org.jetbrains.kotlin.android") version "2.1.10" apply false
//}
//buildscript {
//    kotlinVersion = "1.9.0" // or another compatible version
//    // ...
//    val kotlinVersion: String by project
//    dependencies {
//        implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion")
//    }
//}
//
//val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
//rootProject.layout.buildDirectory.value(newBuildDir)
//
//subprojects {
//    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//    project.layout.buildDirectory.value(newSubprojectBuildDir)
//}
//subprojects {
//    project.evaluationDependsOn(":app")
//}
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}

// Top-level build file where you can add configuration options common to all sub-projects/modules.

//import org.gradle.api.tasks.Delete
//import org.gradle.api.Project
////import org.gradle.api.initialization.dsl.ScriptHandler.CentralRepositoryHandler
//import org.gradle.api.artifacts.dsl.RepositoryHandler
//import java.io.File
//
//plugins {
//    id("com.android.application") version "8.7.0" apply false
//    id("com.google.gms.google-services") version "4.3.15" apply false
//    kotlin("android") version "1.8.22" apply false
//}
//
//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//
//buildscript {
//    dependencies {
//        // No longer needed here with new plugin system
//    }
//}
//
//// Optional: Change the root build directory (uncommon, but included per your setup)
//val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
//rootProject.layout.buildDirectory.set(newBuildDir)
//
//subprojects {
//    val newSubprojectBuildDir = newBuildDir.dir(project.name)
//    layout.buildDirectory.set(newSubprojectBuildDir)
//    evaluationDependsOn(":app") // Ensure proper evaluation order
//
//    plugins.withId("org.jetbrains.kotlin.android") {
//        tasks.named("checkKotlinGradlePluginConfigurationErrors").configure {
//            outputs.upToDateWhen { true }
//        }
//    }
//}
//
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}


//
//import org.jetbrains.kotlin.gradle.tasks.CheckKotlinGradlePluginConfigurationTask
//plugins {
//    id("com.android.application") version "8.7.0" apply false
//    id("com.google.gms.google-services") version "4.3.15" apply false
//    kotlin("android") version "1.8.22" apply false
//}
//
//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//    afterEvaluate{
//        tasks.withType<org.jetbrains.kotlin.gradle.tasks.CheckKotlinGradlePluginConfigurationTask>().configureEach {
//            // Add an output file to ensure Gradle can track if the task needs to run
//            outputs.file(project.layout.buildDirectory.file("reports/kotlin-plugin-check-${project.name}.txt"))
//
//            // Force output even if there are no errors
//            doLast {
//                val outputFile = outputs.files.singleFile
//                outputFile.parentFile.mkdirs()
//                outputFile.writeText("Kotlin plugin configuration checked at ${java.time.LocalDateTime.now()}")
//            }
//        }
//    }
//}
//
//
//buildscript {
//    dependencies {
//        // No longer needed here with new plugin system
//    }
//}
//
//// Optional: Change the root build directory (uncommon, but included per your setup)
//val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
//rootProject.layout.buildDirectory.set(newBuildDir)
//
//subprojects {
//    val newSubprojectBuildDir = newBuildDir.dir(project.name)
//    layout.buildDirectory.set(newSubprojectBuildDir)
//    evaluationDependsOn(":app") // Ensure proper evaluation order
//
//    // Fix for Kotlin Gradle plugin configuration errors task
//    plugins.withId("org.jetbrains.kotlin.android") {
//        tasks.configureEach {
//            if (name.contains("checkKotlinGradlePluginConfiguration")) {
//                outputs.upToDateWhen { true }
//            }
//        }
//    }
//}
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}


//plugins {
//    id("com.android.application") version "8.7.0" apply false
//    id("com.google.gms.google-services") version "4.3.15" apply false
//    kotlin("android") version "1.8.22" apply false
//}
//
//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//
//buildscript {
//    dependencies {
//        // No longer needed here with new plugin system
//    }
//}
//
//// Optional: Change the root build directory (uncommon, but included per your setup)
//val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
//rootProject.layout.buildDirectory.set(newBuildDir)
//
//subprojects {
//    val newSubprojectBuildDir = newBuildDir.dir(project.name)
//    layout.buildDirectory.set(newSubprojectBuildDir)
//    evaluationDependsOn(":app") // Ensure proper evaluation order
//
//
//// Fix for the specific Kotlin task in :gradle subproject
//project(":gradle") {
//    tasks.register("fixKotlinTasks") {
//        doLast {
//            tasks.named("checkKotlinGradlePluginConfigurationErrors").configure {
//                outputs.upToDateWhen { true }
//            }
//        }
//    }
//    // Make sure it runs during configuration phase
//    tasks.configureEach {
//        if (name == "checkKotlinGradlePluginConfigurationErrors") {
//            outputs.upToDateWhen { true }
//        }
//    }
//}
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}
//// Add this at the bottom of your existing root build.gradle.kts
//    allprojects {
//        afterEvaluate {
//            tasks.configureEach {
//                if (name == "checkKotlinGradlePluginConfigurationErrors") {
//                    outputs.upToDateWhen { true }
//                }
//            }
//        }
//    }}



plugins {
    id("com.android.application") version "8.7.0" apply false
    id("com.google.gms.google-services") version "4.3.15" apply false
    kotlin("android") version "1.8.22" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
    // Fix for Kotlin Gradle plugin tasks - using string instead of direct type reference
    afterEvaluate {
        tasks.configureEach {
            if (name.contains("checkKotlinGradlePluginConfiguration")) {
                // Add an output file to ensure Gradle can track if the task needs to run
                outputs.file(project.layout.buildDirectory.file("reports/kotlin-plugin-check-${project.name}.txt"))

                // Force output even if there are no errors
                doLast {
                    val outputFile = outputs.files.singleFile
                    outputFile.parentFile.mkdirs()
                    outputFile.writeText("Kotlin plugin configuration checked at ${java.time.LocalDateTime.now()}")
                }
            }
        }
    }
}

buildscript {
    dependencies {
        // No longer needed here with new plugin system
    }
}

// Optional: Change the root build directory (uncommon, but included per your setup)
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    layout.buildDirectory.set(newSubprojectBuildDir)
    evaluationDependsOn(":app") // Ensure proper evaluation order

    // Fix for Kotlin Gradle plugin configuration errors task
    plugins.withId("org.jetbrains.kotlin.android") {
        tasks.configureEach {
            if (name.contains("checkKotlinGradlePluginConfiguration")) {
                outputs.upToDateWhen { true }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}