import 'package:flutter/material.dart';
import 'route_names.dart';
import '../views/splash/splash_view.dart';
import '../views/login/login_view.dart';
import '../widgets/template/template.dart';
import '../views/register/register_view.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      RouteNames.splash: (context) => const SplashScreen(),
      RouteNames.template: (context) => const TemplateScreen(),
      RouteNames.login: (context) => const LoginScreen(),
      RouteNames.register: (context) => const RegisterScreen(),
    };
  }
}
