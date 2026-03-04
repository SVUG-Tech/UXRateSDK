import 'package:flutter/material.dart';

/// Orders list — navigated to from HomeScreen.
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const _orders = [
    _Order('#10421', 'MacBook Pro', _OrderStatus.delivered),
    _Order('#10398', 'AirPods Pro', _OrderStatus.shipped),
    _Order('#10375', 'iPhone', _OrderStatus.processing),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: ListView.separated(
        itemCount: _orders.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final order = _orders[index];
          return ListTile(
            leading: const Icon(Icons.receipt_long_outlined),
            title: Text(order.id),
            subtitle: Text(order.item),
            trailing: _StatusBadge(status: order.status),
          );
        },
      ),
    );
  }
}

enum _OrderStatus { delivered, shipped, processing }

class _Order {
  const _Order(this.id, this.item, this.status);
  final String id;
  final String item;
  final _OrderStatus status;
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final _OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      _OrderStatus.delivered => ('Delivered', Colors.green),
      _OrderStatus.shipped => ('Shipped', Colors.blue),
      _OrderStatus.processing => ('Processing', Colors.orange),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
