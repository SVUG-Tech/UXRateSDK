import 'package:flutter/material.dart';
import 'package:flutter_uxrate/flutter_uxrate.dart';

import 'orders_screen.dart';
import 'products_screen.dart';

/// Home tab — survey button should appear here.
///
/// Key integration points:
/// - [UXRate.setScreen] called in [initState] to report this screen name.
/// - [UXRate.track] called when a notable action occurs (Products tapped).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Report the screen name — must match the pagePattern regex in your
    // dashboard trigger rule (e.g. "^Home$").
    UXRate.setScreen('Home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children: [
          // Navigation section
          _SectionHeader(title: 'Browse'),
          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined),
            title: const Text('Products'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Track the event — can be used in event-based trigger rules.
              UXRate.track(event: 'products_tapped');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping_outlined),
            title: const Text('Orders'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrdersScreen()),
            ),
          ),
          const Divider(),

          // Survey status indicator
          _SectionHeader(title: 'SDK Status'),
          const ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text('Survey button visible on this screen'),
            subtitle: Text('Trigger rule: pagePattern matches "Home"'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
