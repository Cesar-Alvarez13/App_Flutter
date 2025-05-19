import 'package:flutter/material.dart';

class SplashStyles {
  // Duraciones
  static const Duration animationDuration = Duration(seconds: 2);
  static const Duration delayDuration = Duration(seconds: 1);

  // Tamaños
  static const double iconSize = 80.0;
  static const double spacing = 20.0;

  // Configuración de animación
  static const Curve animationCurve = Curves.easeInOutBack;

  // Animaciones
  static Animation<double> createScaleAnimation(AnimationController controller) {
    return Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: animationCurve),
    );
  }

  static Animation<double> createOpacityAnimation(AnimationController controller) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );
  }

  static Animation<Offset> createSlideAnimation(AnimationController controller) {
    return Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: controller, curve: animationCurve),
    );
  }
}
