/**
 * Settings Screen — intentionally does NOT call UXRate.setScreen().
 *
 * This demonstrates that surveys only appear on screens you explicitly
 * report to the SDK. Because setScreen is not called here, the SDK has no
 * screen context to evaluate trigger rules against.
 */

import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

export default function SettingsScreen() {
  // Note: no UXRate.setScreen() call — surveys will not appear on this screen.

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Settings Screen</Text>
      <Text style={styles.subtitle}>
        No survey button here — UXRate.setScreen() is not called on this screen.
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#F2F2F7',
    gap: 12,
  },
  title: {
    fontSize: 22,
    fontWeight: '600',
  },
  subtitle: {
    fontSize: 15,
    color: '#8E8E93',
    textAlign: 'center',
    paddingHorizontal: 32,
  },
});
