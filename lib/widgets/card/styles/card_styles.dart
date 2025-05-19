import 'package:flutter/material.dart';

class CardStyles {
  static const EdgeInsetsGeometry cardMargin = EdgeInsets.symmetric(
    vertical: 8,
    horizontal: 16,
  );

  static const double cardElevation = 3;
  static const double borderRadius = 12;

  static const TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle subtitleStyle = TextStyle(
    color: Colors.black87,
    fontSize: 16,
  );

  static const EdgeInsets contentPadding = EdgeInsets.all(16);
  static const EdgeInsets itemPadding = EdgeInsets.only(bottom: 8);
}
