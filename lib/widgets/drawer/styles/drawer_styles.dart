import 'package:flutter/material.dart';

class DrawerStyles {
  static const TextStyle menuItemStyle = TextStyle(
    fontSize: 16,
    color: Colors.black87,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle selectedItemStyle = TextStyle(
    fontSize: 16,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  static const Color selectedTileColor = Color(0xFFE3F2FD);

  static const EdgeInsets menuPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
}
