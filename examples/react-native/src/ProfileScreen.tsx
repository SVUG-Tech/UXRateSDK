/**
 * Profile Screen — survey button should appear here too.
 *
 * useFocusEffect calls UXRate.setScreen('Profile') whenever this tab is focused.
 */

import React, { useCallback } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';

import { UXRate } from 'react-native-uxrate';

export default function ProfileScreen() {
  useFocusEffect(
    useCallback(() => {
      UXRate.setScreen('Profile');
    }, []),
  );

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Profile Screen</Text>
      <Text style={styles.subtitle}>
        The survey button should appear here too.
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
