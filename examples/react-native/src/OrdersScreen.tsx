/**
 * Orders Screen — navigated to from Home.
 */

import React from 'react';
import { View, Text, FlatList, StyleSheet } from 'react-native';

type OrderStatus = 'Delivered' | 'Shipped' | 'Processing';

type Order = {
  id: string;
  orderId: string;
  item: string;
  status: OrderStatus;
};

const ORDERS: Order[] = [
  { id: '1', orderId: '#10421', item: 'MacBook Pro', status: 'Delivered' },
  { id: '2', orderId: '#10398', item: 'AirPods Pro', status: 'Shipped' },
  { id: '3', orderId: '#10375', item: 'iPhone', status: 'Processing' },
];

const STATUS_COLORS: Record<OrderStatus, { bg: string; text: string }> = {
  Delivered: { bg: '#D1FAE5', text: '#065F46' },
  Shipped: { bg: '#DBEAFE', text: '#1E40AF' },
  Processing: { bg: '#FEF3C7', text: '#92400E' },
};

export default function OrdersScreen() {
  return (
    <FlatList
      data={ORDERS}
      keyExtractor={(item) => item.id}
      ItemSeparatorComponent={() => <View style={styles.separator} />}
      renderItem={({ item }) => {
        const colors = STATUS_COLORS[item.status];
        return (
          <View style={styles.row}>
            <View style={styles.info}>
              <Text style={styles.orderId}>{item.orderId}</Text>
              <Text style={styles.item}>{item.item}</Text>
            </View>
            <View style={[styles.badge, { backgroundColor: colors.bg }]}>
              <Text style={[styles.badgeText, { color: colors.text }]}>
                {item.status}
              </Text>
            </View>
          </View>
        );
      }}
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
  info: {
    flex: 1,
  },
  orderId: {
    fontSize: 16,
    fontWeight: '600',
  },
  item: {
    fontSize: 13,
    color: '#8E8E93',
    marginTop: 2,
  },
  badge: {
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 12,
  },
  badgeText: {
    fontSize: 12,
    fontWeight: '600',
  },
  separator: {
    height: StyleSheet.hairlineWidth,
    backgroundColor: '#C6C6C8',
    marginLeft: 16,
  },
});
