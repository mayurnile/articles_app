import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }
}

extension ColorHelper on Color {
  Color opacityValue(double opacity) {
    return withAlpha((opacity * 255).round());
  }
}
