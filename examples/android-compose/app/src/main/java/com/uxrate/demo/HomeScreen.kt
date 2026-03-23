package com.uxrate.demo

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.automirrored.filled.KeyboardArrowRight
import androidx.compose.material.icons.outlined.LocalShipping
import androidx.compose.material.icons.outlined.Notifications
import androidx.compose.material.icons.outlined.ShoppingBag
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.ListItem
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.uxrate.sdk.UXRate

/**
 * Home tab — survey button should appear here.
 *
 * Screen tracking is handled automatically by navController.TrackScreens()
 * in MainActivity — no per-screen setup needed.
 */
@Composable
fun HomeScreen(navController: NavController) {
    LazyColumn(modifier = Modifier.fillMaxSize()) {
        // Section header: Browse
        item { SectionHeader("Browse") }

        item {
            BrowseRow(
                icon = Icons.Outlined.ShoppingBag,
                label = "Products",
                onClick = {
                    UXRate.track(event = "products_tapped")
                    navController.navigate("products")
                }
            )
        }

        item {
            BrowseRow(
                icon = Icons.Outlined.LocalShipping,
                label = "Orders",
                onClick = { navController.navigate("orders") }
            )
        }

        item {
            BrowseRow(
                icon = Icons.Outlined.Notifications,
                label = "Notifications",
                onClick = { }
            )
        }

        item { HorizontalDivider() }

        // Section header: SDK Status
        item { SectionHeader("SDK Status") }

        item {
            ListItem(
                headlineContent = { Text("Survey button visible on this screen") },
                supportingContent = { Text("Trigger rule: pagePattern matches \"Home\"") },
                leadingContent = {
                    Icon(
                        Icons.Filled.CheckCircle,
                        contentDescription = null,
                        tint = Color(0xFF4CAF50),
                    )
                },
            )
        }
    }
}

@Composable
private fun SectionHeader(title: String) {
    Text(
        text = title.uppercase(),
        style = MaterialTheme.typography.labelSmall,
        color = MaterialTheme.colorScheme.secondary,
        modifier = Modifier.padding(start = 16.dp, top = 24.dp, bottom = 4.dp),
    )
}

@Composable
private fun BrowseRow(icon: ImageVector, label: String, onClick: () -> Unit) {
    ListItem(
        headlineContent = { Text(label) },
        leadingContent = {
            Icon(icon, contentDescription = null)
        },
        trailingContent = {
            Icon(
                Icons.AutoMirrored.Filled.KeyboardArrowRight,
                contentDescription = null,
                tint = MaterialTheme.colorScheme.onSurfaceVariant,
            )
        },
        modifier = Modifier.clickable(onClick = onClick),
    )
}
