package com.uxrate.demo

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.ListItem
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

/**
 * Orders list — navigated to from HomeScreen.
 */
@Composable
fun OrdersScreen() {
    val orders = listOf(
        Order("#10421", "MacBook Pro", "Delivered", Color(0xFF065F46), Color(0xFFD1FAE5)),
        Order("#10398", "AirPods Pro", "Shipped", Color(0xFF1E40AF), Color(0xFFDBEAFE)),
        Order("#10375", "iPhone Case", "Processing", Color(0xFF92400E), Color(0xFFFEF3C7)),
    )

    LazyColumn(modifier = Modifier.fillMaxSize()) {
        items(orders) { order ->
            ListItem(
                headlineContent = { Text(order.item, fontWeight = FontWeight.SemiBold) },
                supportingContent = { Text(order.id, color = Color.Gray) },
                trailingContent = {
                    Text(
                        order.status,
                        fontSize = 12.sp,
                        fontWeight = FontWeight.SemiBold,
                        color = order.textColor,
                        modifier = Modifier
                            .clip(RoundedCornerShape(12.dp))
                            .background(order.bgColor)
                            .padding(horizontal = 10.dp, vertical = 4.dp),
                    )
                },
            )
            HorizontalDivider()
        }
    }
}

private data class Order(
    val id: String,
    val item: String,
    val status: String,
    val textColor: Color,
    val bgColor: Color,
)
