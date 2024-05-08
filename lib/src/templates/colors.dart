String createColorsDart() {
  return r'''
import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    this.white = Colors.white,
    this.black = Colors.black,
  });

  // add your custom colors here and
  // update the constructor, copyWith and lerp methods
  final Color? white;
  final Color? black;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? white,
    Color? black,
  }) {
    return AppColors(
      white: white ?? this.white,
      black: black ?? this.black,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      white: Color.lerp(white, other.white, t),
      black: Color.lerp(black, other.black, t),
    );
  }

  @override
  String toString() => 'AppColors(white: $white, black: $black)';
}

extension AppColorsContextX on BuildContext {
  /// Shortcut to access [AppColors] from [BuildContext]
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
''';
}
