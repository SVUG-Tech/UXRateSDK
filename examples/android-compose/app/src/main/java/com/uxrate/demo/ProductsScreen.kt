package com.uxrate.demo

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.ListItem
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight

/**
 * Products list — navigated to from HomeScreen.
 *
 * Does not call UXRate.setScreen() to keep the demo focused on the main tabs.
 * In a real app you would add a setScreen call here if you want surveys on this screen.
 */
@Composable
fun ProductsScreen() {
    val products = listOf(
        Product("MacBook Pro", "💻", "$2,499"),
        Product("iPhone", "📱", "$999"),
        Product("AirPods Pro", "🎧", "$249"),
        Product("Apple Watch", "⌚", "$399"),
        Product("iPad Pro", "📲", "$1,099"),
    )

    LazyColumn(modifier = Modifier.fillMaxSize()) {
        items(products) { product ->
            ListItem(
                headlineContent = { Text(product.name) },
                leadingContent = { Text(product.emoji, style = MaterialTheme.typography.headlineMedium) },
                trailingContent = {
                    Text(
                        product.price,
                        fontWeight = FontWeight.SemiBold,
                    )
                },
            )
            HorizontalDivider()
        }
    }
}

private data class Product(val name: String, val emoji: String, val price: String)
