import 'package:flutter/material.dart';
import '../../../themes/app_styles.dart';

class HomeStyles {
  // Dimensions
  static const double cardRadius = 12.0;
  static const double elevation = 3.0;
  static const double verticalMargin = 8.0;
  static const double horizontalPadding = 16.0;
  static const double iconSize = 24.0;
  static const double arrowIconSize = 16.0;

  // Colors (derivados desde AppStyles)
  static Color get iconColor => AppStyles.primaryColorLight;
  static Color get textColor => AppStyles.textColorPrimary;
  static Color get arrowColor => AppStyles.textColorSecondary;

  // Card decoration
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(cardRadius),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );

  // Icon themes
  static IconThemeData get personIconTheme => IconThemeData(
    color: iconColor,
    size: iconSize,
  );

  // Arrow icon theme
  static IconThemeData get arrowIconTheme => IconThemeData(
    color: arrowColor,
    size: arrowIconSize,
  );

  // Text styles
  static TextStyle get titleStyle => TextStyle(
    color: textColor,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  // Card margin
  static EdgeInsets get cardMargin => const EdgeInsets.symmetric(
    vertical: verticalMargin,
    horizontal: horizontalPadding,
  );

  // Card shape
  static RoundedRectangleBorder get cardShape => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(cardRadius),
  );
}
