/**
 * Home Screen — survey button should appear here.
 *
 * Integration points:
 * - useFocusEffect calls UXRate.setScreen('Home') every time this tab comes into focus.
 * - UXRate.track() fires when the user taps Products (demonstrates event tracking).
 */

import React, { useCallback } from 'react';
import {
  View,
  Text,
  SectionList,
  TouchableOpacity,
  StyleSheet,
} from 'react-native';
import { useFocusEffect, useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';

import { UXRate } from 'react-native-uxrate';
import type { HomeStackParamList } from '../App';

type NavigationProp = NativeStackNavigationProp<HomeStackParamList, 'Home'>;

export default function HomeScreen() {
  const navigation = useNavigation<NavigationProp>();

  // Report this screen name every time the tab comes into focus.
  useFocusEffect(
    useCallback(() => {
      UXRate.setScreen('Home');
    }, []),
  );

  return (
    <SectionList
      contentInsetAdjustmentBehavior="automatic"
      sections={[
        {
          title: 'BROWSE',
          data: [
            {
              key: 'products',
              label: 'Products',
              onPress: () => {
                UXRate.track({ event: 'products_tapped' });
                navigation.navigate('Products');
              },
            },
            {
              key: 'orders',
              label: 'Orders',
              onPress: () => navigation.navigate('Orders'),
            },
          ],
        },
        {
          title: 'SDK STATUS',
          data: [
            {
              key: 'status',
              label: 'Survey button visible on this screen',
              onPress: undefined,
            },
          ],
        },
      ]}
      keyExtractor={(item) => item.key}
      renderSectionHeader={({ section }) => (
        <Text style={styles.sectionHeader}>{section.title}</Text>
      )}
      renderItem={({ item }) => (
        <TouchableOpacity
          style={styles.row}
          onPress={item.onPress}
          disabled={!item.onPress}
        >
          <Text style={styles.rowLabel}>{item.label}</Text>
          {item.onPress && <Text style={styles.chevron}>></Text>}
        </TouchableOpacity>
      )}
      ItemSeparatorComponent={() => <View style={styles.separator} />}
    />
  );
}

const styles = StyleSheet.create({
  sectionHeader: {
    fontSize: 12,
    fontWeight: '600',
    color: '#8E8E93',
    letterSpacing: 0.8,
    paddingHorizontal: 16,
    paddingTop: 24,
    paddingBottom: 6,
    backgroundColor: '#F2F2F7',
  },
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
    paddingHorizontal: 16,
    paddingVertical: 14,
  },
  rowLabel: {
    flex: 1,
    fontSize: 16,
  },
  chevron: {
    fontSize: 20,
    color: '#C7C7CC',
  },
  separator: {
    height: StyleSheet.hairlineWidth,
    backgroundColor: '#C6C6C8',
    marginLeft: 16,
  },
});
