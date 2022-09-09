import 'package:flutter/material.dart';
import 'package:streax_share/view/auth/login.dart';
import 'package:streax_share/view/auth/register.dart';
import 'package:streax_share/view/screens/home_screen/home_screen.dart';

class RoutesManager {
  static const homepage = '/';
  static const login = '/login';
  static const register = '/register';

  static Route<dynamic> routeSettings(RouteSettings settings) {
    switch (settings.name) {
      case (homepage):
        return MaterialPageRoute(builder: ((context) => HomeScreen()));

      case (login):
        return MaterialPageRoute(builder: ((context) => LoginScreen()));

      case (register):
        return MaterialPageRoute(builder: ((context) => RegisterScreen()));

      default:
        throw const FormatException('Routes not found! Check the rutes');
    }
  }
}
