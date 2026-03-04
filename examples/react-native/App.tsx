/**
 * react-native-uxrate Example App
 *
 * Demonstrates the minimal UXRate integration in a React Native app:
 *   1. Call UXRate.configure() once at app startup (useEffect with empty deps).
 *   2. Call UXRate.identify() after the user is known.
 *   3. Call UXRate.setScreen() on every screen via useFocusEffect.
 */

import React, { useEffect } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { SafeAreaProvider } from 'react-native-safe-area-context';

import { UXRate } from 'react-native-uxrate';

import HomeScreen from './src/HomeScreen';
import ProfileScreen from './src/ProfileScreen';
import SettingsScreen from './src/SettingsScreen';
import ProductsScreen from './src/ProductsScreen';
import OrdersScreen from './src/OrdersScreen';

// ─── Navigator Types ──────────────────────────────────────────────────────────

export type HomeStackParamList = {
  Home: undefined;
  Products: undefined;
  Orders: undefined;
};

const Tab = createBottomTabNavigator();
const HomeStack = createNativeStackNavigator<HomeStackParamList>();

// ─── Home Stack ───────────────────────────────────────────────────────────────

function HomeStackNavigator() {
  return (
    <HomeStack.Navigator>
      <HomeStack.Screen name="Home" component={HomeScreen} />
      <HomeStack.Screen name="Products" component={ProductsScreen} />
      <HomeStack.Screen name="Orders" component={OrdersScreen} />
    </HomeStack.Navigator>
  );
}

// ─── Root App ─────────────────────────────────────────────────────────────────

export default function App() {
  useEffect(() => {
    UXRate.configure({ apiKey: 'YOUR_API_KEY' });

    // Identify a demo user — properties can be used in user_segment rules.
    UXRate.identify({
      userId: 'rn-user-1',
      properties: { platform: 'react-native', plan: 'pro' },
    });
  }, []);

  return (
    <SafeAreaProvider>
      <NavigationContainer>
        <Tab.Navigator
          screenOptions={{ headerShown: false }}
        >
          <Tab.Screen
            name="HomeTab"
            component={HomeStackNavigator}
            options={{ title: 'Home' }}
          />
          <Tab.Screen
            name="Profile"
            component={ProfileScreen}
          />
          <Tab.Screen
            name="Settings"
            component={SettingsScreen}
          />
        </Tab.Navigator>
      </NavigationContainer>
    </SafeAreaProvider>
  );
}
