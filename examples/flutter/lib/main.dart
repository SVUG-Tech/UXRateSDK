import 'package:flutter/material.dart';
import 'package:flutter_uxrate/flutter_uxrate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Mock environment — works immediately without dashboard setup.
  // Switch to 'production' with your real API key for live surveys.
  await UXRate.configure(
    apiKey: 'YOUR_API_KEY',
    environment: 'mock',
  );

  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UXRate Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ---------------------------------------------------------------------------
// Home Screen
// ---------------------------------------------------------------------------

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tapCount = 0;

  @override
  void initState() {
    super.initState();
    UXRate.setScreen('Home');
  }

  void _onButtonTapped() {
    setState(() => _tapCount++);
    UXRate.track(event: 'button_tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UXRate Demo - Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Button tapped $_tapCount time(s)'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _onButtonTapped,
              child: const Text('Tap Me'),
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProductsScreen(),
                  ),
                );
              },
              child: const Text('Go to Products'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Products Screen
// ---------------------------------------------------------------------------

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    UXRate.setScreen('Products');
  }

  @override
  Widget build(BuildContext context) {
    final products = ['Widget A', 'Widget B', 'Widget C'];

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]),
            onTap: () {
              UXRate.track(event: 'product_viewed');
            },
          );
        },
      ),
    );
  }
}
