pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        // UXRate SDK Maven repository hosted on GitHub Pages
        maven { url = uri("https://svug-tech.github.io/UXRateSDK") }
    }
}

rootProject.name = "UXRateDemoActivities"
include(":app")
