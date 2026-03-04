/**
 * Products Screen — navigated to from Home.
 */

import React from 'react';
import {
  View,
  Text,
  FlatList,
  StyleSheet,
} from 'react-native';

type Product = {
  id: string;
  name: string;
  emoji: string;
  price: string;
};

const PRODUCTS: Product[] = [
  { id: '1', name: 'MacBook Pro', emoji: '💻', price: '$2,499' },
  { id: '2', name: 'iPhone', emoji: '📱', price: '$999' },
  { id: '3', name: 'AirPods Pro', emoji: '🎧', price: '$249' },
  { id: '4', name: 'Apple Watch', emoji: '⌚', price: '$399' },
  { id: '5', name: 'iPad Pro', emoji: '📲', price: '$1,099' },
];

export default function ProductsScreen() {
  return (
    <FlatList
      data={PRODUCTS}
      keyExtractor={(item) => item.id}
      ItemSeparatorComponent={() => <View style={styles.separator} />}
      renderItem={({ item }) => (
        <View style={styles.row}>
          <Text style={styles.emoji}>{item.emoji}</Text>
          <Text style={styles.name}>{item.name}</Text>
          <Text style={styles.price}>{item.price}</Text>
        </View>
      )}
    />
  );
}

const styles = StyleSheet.create({
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
    paddingHorizontal: 16,
    paddingVertical: 14,
  },
  emoji: {
    fontSize: 28,
    width: 44,
  },
  name: {
    flex: 1,
    fontSize: 16,
  },
  price: {
    fontSize: 15,
    fontWeight: '600',
    color: '#1C1C1E',
  },
  separator: {
    height: StyleSheet.hairlineWidth,
    backgroundColor: '#C6C6C8',
    marginLeft: 60,
  },
});
