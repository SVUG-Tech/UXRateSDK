import 'package:flutter/material.dart';

/// Products list — navigated to from HomeScreen.
///
/// Does not call [UXRate.setScreen] to keep the demo focused on the main tabs.
/// In a real app you would add a setScreen call here if you want surveys on this screen.
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  static const _products = [
    _Product('MacBook Pro', Icons.laptop_mac, '\$2,499'),
    _Product('iPhone', Icons.phone_iphone, '\$999'),
    _Product('AirPods Pro', Icons.headphones, '\$249'),
    _Product('Apple Watch', Icons.watch, '\$399'),
    _Product('iPad Pro', Icons.tablet_mac, '\$1,099'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: ListView.separated(
        itemCount: _products.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            leading: Icon(product.icon, color: Theme.of(context).colorScheme.primary),
            title: Text(product.name),
            trailing: Text(
              product.price,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          );
        },
      ),
    );
  }
}

class _Product {
  const _Product(this.name, this.icon, this.price);
  final String name;
  final IconData icon;
  final String price;
}
