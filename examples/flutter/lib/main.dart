import 'package:flutter/material.dart';
import 'package:flutter_uxrate/flutter_uxrate.dart';

import 'home_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

/// Entry point for the flutter_uxrate example app.
///
/// Demonstrates the minimal UXRate integration:
///   1. Call [UXRate.configure] once before [runApp].
///   2. Call [UXRate.identify] after the user is known.
///   3. Call [UXRate.setScreen] on every screen from [initState].
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UXRate.configure(apiKey: 'YOUR_API_KEY');

  // Identify a demo user — properties can be used in user_segment trigger rules.
  await UXRate.identify(
    userId: 'flutter-user-1',
    properties: {'platform': 'flutter', 'plan': 'pro'},
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UXRate Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MainTabs(),
    );
  }
}

/// Root scaffold with a bottom tab bar — mirrors the iOS demo's TabView layout.
class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int _currentIndex = 0;

  static const _screens = [
    HomeScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
