// lib/themes/app_styles.dart

import 'package:flutter/material.dart';

class AppStyles {
  // Colores principales elegantes
  static const Color primaryColor = Color(0xFF031219);      // Azul muy oscuro
  static const Color primaryColorLight = Color(0xFF4A647A); // Versión clara para acentos
  static const Color secondaryColor = Color(0xFFCBDAE1);    // Azul grisáceo claro
  static const Color secondaryColorDark = Color(0xFF9AB0B7); // Azul grisáceo medio

  static const Color backgroundColor = Color(0xFFCBDAE1);   // Fondo suave y claro
  static const Color surfaceColor = Color(0xFFABB0B2);      // Gris claro para tarjetas y contenedores
  static const Color surfaceColorDark = Color(0xFFAFAFAF);  // Gris medio para variantes
  static const Color errorColor = Color(0xFFB00020);

  // Colores de texto
  static const Color textColorPrimary = Color(0xFF031219);  // Azul muy oscuro, casi negro
  static const Color textColorSecondary = Color(0xFF4A647A); // Gris azulado para subtítulos

  // Tipografías (con responsividad básica según ancho de pantalla)
  static TextStyle title(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.06;
    if (size < 20) size = 20;
    if (size > 30) size = 30;
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: textColorPrimary,
      fontFamily: 'Montserrat',  
    );
  }

  static TextStyle subtitle(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.045;
    if (size < 16) size = 16;
    if (size > 22) size = 22;
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: textColorSecondary,
      fontFamily: 'Montserrat',
    );
  }

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: textColorPrimary,
    fontFamily: 'Montserrat',
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: textColorSecondary,
    fontFamily: 'Montserrat',
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: 'Montserrat',
  );

  // Bordes y radios
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 16.0;
  static const double borderRadiusLarge = 32.0;

  static final BorderRadius roundedSmall = BorderRadius.circular(borderRadiusSmall);
  static final BorderRadius roundedMedium = BorderRadius.circular(borderRadiusMedium);
  static final BorderRadius roundedLarge = BorderRadius.circular(borderRadiusLarge);

  // Sombreados suaves y elegantes
  static const BoxShadow boxShadowLight = BoxShadow(
    color: Colors.black12,
    blurRadius: 6,
    offset: Offset(0, 2),
  );

  static const BoxShadow boxShadowStrong = BoxShadow(
    color: Colors.black26,
    blurRadius: 10,
    offset: Offset(0, 4),
  );

  // Espaciados
  static const EdgeInsets paddingPage = EdgeInsets.all(16);
  static const EdgeInsets paddingSmall = EdgeInsets.all(8);

  // Decoraciones de contenedores
  static BoxDecoration containerWithColorBackground({
    Color color = surfaceColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: borderRadius ?? roundedMedium,
      boxShadow: boxShadow ?? [boxShadowLight],
    );
  }

  static BoxDecoration containerWithImageBackground({
    required String imageUrl,
    BorderRadius? borderRadius,
    BoxFit fit = BoxFit.cover,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      borderRadius: borderRadius ?? roundedMedium,
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: fit,
      ),
      boxShadow: boxShadow ?? [boxShadowStrong],
    );
  }

  static BoxDecoration containerPrimaryColorBackground({
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: primaryColor,
      borderRadius: borderRadius ?? roundedMedium,
      boxShadow: boxShadow ?? [boxShadowStrong],
    );
  }
}
