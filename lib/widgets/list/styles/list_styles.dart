import 'package:flutter/material.dart';

class ListStyles {
  // Padding general de la pantalla
  static const EdgeInsets screenPadding = EdgeInsets.all(16);

  // Margen vertical y horizontal de la lista
  static const EdgeInsets listPadding = EdgeInsets.symmetric(vertical: 16, horizontal: 16);

  // Altura máxima proporcional (por ejemplo 80% de la altura pantalla)
  static double maxListHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.8;
  }

  // Otros estilos (por ejemplo para input filtro)
  static const EdgeInsets filterInputPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const double filterInputFontSize = 16;
}
