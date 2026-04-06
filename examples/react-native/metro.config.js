const path = require('path');
const { getDefaultConfig, mergeConfig } = require('@react-native/metro-config');

const root = path.resolve(__dirname, '..');
const exampleNodeModules = path.resolve(__dirname, 'node_modules');

const config = {
  watchFolders: [root],
  resolver: {
    // Ensure react-native and other deps resolve from example/node_modules
    nodeModulesPaths: [exampleNodeModules],
    extraNodeModules: {
      'react-native-uxrate': root,
      'react-native': path.resolve(exampleNodeModules, 'react-native'),
      'react': path.resolve(exampleNodeModules, 'react'),
    },
  },
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
