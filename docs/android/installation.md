<!-- Android SDK v0.7.0 -->

# Installation

## Requirements

- Android API 24+ (Android 7.0 Nougat)
- Kotlin 2.1+
- Jetpack Compose

## Option 1: Gradle (Recommended)

1. Add the UXRate Maven repository to your **project-level** `settings.gradle.kts`:

```kotlin
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://svug-tech.github.io/UXRateSDK") }
    }
}
```

2. Add the dependency to your **module-level** `build.gradle.kts`:

```kotlin
dependencies {
    implementation("com.uxrate:uxrate-sdk:<version>")
}
```

Replace `<version>` with the latest release version. Transitive dependencies (Compose, Coroutines, etc.) are resolved automatically. No authentication required.

## Option 2: Manual AAR Download

1. Download the latest `uxrate-sdk-<version>.aar` from [Releases](https://github.com/SVUG-Tech/UXRateSDK/releases).
2. Copy the AAR into your module's `libs/` directory.
3. Add the `flatDir` repository and dependency:

**settings.gradle.kts** (project-level):
```kotlin
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        flatDir { dirs("libs") }
    }
}
```

**build.gradle.kts** (module-level):
```kotlin
dependencies {
    implementation(files("libs/uxrate-sdk-<version>.aar"))

    // Required transitive dependencies (AAR does not bundle these)
    implementation(platform("androidx.compose:compose-bom:2024.12.01"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.material3:material3")
    implementation("androidx.compose.material:material-icons-core")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.activity:activity-compose:1.9.3")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.8.7")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.9.0")
}
```

With the Gradle approach transitive dependencies are resolved automatically. With the AAR download you must declare them manually.
