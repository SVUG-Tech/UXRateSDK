import React, { useEffect } from 'react';
import { View, Text, Button, StyleSheet } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { UXRate } from 'react-native-uxrate';

const Stack = createNativeStackNavigator();

// ------------------------------------------------------------------
// Configure the UXRate SDK at app startup.
// Replace YOUR_API_KEY with your real key from the UXRate dashboard.
// ------------------------------------------------------------------
function App(): React.JSX.Element {
  useEffect(() => {
    // Mock service — works immediately without dashboard setup.
    // Replace with your real API key (uxr_…) for live surveys; the SDK
    // auto-resolves the backend from the key prefix.
    UXRate.configure({
      apiKey: 'mock',
    });
  }, []);

  return (
    <NavigationContainer
      onStateChange={(state) => {
        const route = state?.routes[state.index];
        if (route) {
          UXRate.setScreen(route.name);
        }
      }}
    >
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Products" component={ProductsScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

function HomeScreen({ navigation }: any): React.JSX.Element {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Home Screen</Text>
      <Button
        title="Go to Products"
        onPress={() => navigation.navigate('Products')}
      />
      <View style={styles.spacer} />
      <Button
        title="Track Button Tap"
        onPress={() => UXRate.track({ event: 'button_tapped' })}
      />
    </View>
  );
}

function ProductsScreen(): React.JSX.Element {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Products Screen</Text>
      <Button
        title="Track Button Tap"
        onPress={() => UXRate.track({ event: 'button_tapped' })}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, alignItems: 'center', justifyContent: 'center' },
  title: { fontSize: 24, marginBottom: 20 },
  spacer: { height: 12 },
});

export default App;
