package com.uxrate.demo

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.outlined.Home
import androidx.compose.material.icons.outlined.Person
import androidx.compose.material.icons.outlined.Settings
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.navigation.NavDestination.Companion.hierarchy
import androidx.navigation.NavGraph.Companion.findStartDestination
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController

/**
 * Main Activity — hosts the bottom tab navigation with Home, Profile, Settings tabs.
 *
 * Mirrors the iOS demo's TabView layout. Screen names are auto-tracked by the SDK
 * from Activity class names, but since we use a single Activity with Compose navigation,
 * we call UXRate.setScreen() manually in each screen composable.
 */
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            UXRateDemoTheme {
                MainScreen()
            }
        }
    }
}

@Composable
private fun UXRateDemoTheme(content: @Composable () -> Unit) {
    val colorScheme = if (android.os.Build.VERSION.SDK_INT >= 31) {
        val context = LocalContext.current
        dynamicLightColorScheme(context)
    } else {
        MaterialTheme.colorScheme
    }

    MaterialTheme(
        colorScheme = colorScheme,
        content = content
    )
}

// ── Navigation ────────────────────────────────────────────────────────────────

private data class TabItem(
    val route: String,
    val label: String,
    val selectedIcon: ImageVector,
    val unselectedIcon: ImageVector,
)

private val tabs = listOf(
    TabItem("home", "Home", Icons.Filled.Home, Icons.Outlined.Home),
    TabItem("profile", "Profile", Icons.Filled.Person, Icons.Outlined.Person),
    TabItem("settings", "Settings", Icons.Filled.Settings, Icons.Outlined.Settings),
)

@Composable
private fun MainScreen() {
    val navController = rememberNavController()
    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentDestination = navBackStackEntry?.destination

    Scaffold(
        bottomBar = {
            NavigationBar {
                tabs.forEach { tab ->
                    val selected = currentDestination?.hierarchy?.any { it.route == tab.route } == true
                    NavigationBarItem(
                        selected = selected,
                        onClick = {
                            navController.navigate(tab.route) {
                                popUpTo(navController.graph.findStartDestination().id) {
                                    saveState = true
                                }
                                launchSingleTop = true
                                restoreState = true
                            }
                        },
                        icon = {
                            Icon(
                                imageVector = if (selected) tab.selectedIcon else tab.unselectedIcon,
                                contentDescription = tab.label,
                            )
                        },
                        label = { Text(tab.label) },
                    )
                }
            }
        }
    ) { innerPadding ->
        NavHost(
            navController = navController,
            startDestination = "home",
            modifier = Modifier.padding(innerPadding),
        ) {
            composable("home") { HomeScreen(navController) }
            composable("profile") { ProfileScreen() }
            composable("settings") { SettingsScreen() }
            composable("products") { ProductsScreen() }
            composable("orders") { OrdersScreen() }
        }
    }
}
