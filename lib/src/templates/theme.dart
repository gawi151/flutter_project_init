String createThemeDart() {
  return '''
import 'package:flutter/material.dart';

export 'colors.dart';

ThemeData createLightTheme() {
  // TODO(dev): Implement the light theme
  return ThemeData.from(colorScheme: const ColorScheme.light());
}

ThemeData createDarkTheme() {
  // TODO(dev): Implement the dark theme
  return ThemeData.from(colorScheme: const ColorScheme.dark());
}
''';
}
