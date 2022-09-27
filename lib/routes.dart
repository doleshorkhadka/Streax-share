import 'package:flutter/material.dart';
import 'package:streax_share/view/auth/login.dart';
import 'package:streax_share/view/auth/register.dart';
import 'package:streax_share/view/screens/add_video_screen/newvideoscreen.dart';
import 'package:streax_share/view/screens/home_screen/home_screen.dart';

class MaterialRoutes {
  static const homepage = '/';
  static const login = '/login';
  static const register = '/register';
  static const newvideo = '/newvideoscreen';

  static Route<dynamic> routeSettings(RouteSettings settings) {
    switch (settings.name) {
      case (homepage):
        return MaterialPageRoute(builder: ((context) => HomeScreen()));

      case (login):
        return MaterialPageRoute(builder: ((context) => LoginScreen()));

      case (register):
        return MaterialPageRoute(builder: ((context) => RegisterScreen()));

      case (newvideo):
        return MaterialPageRoute(builder: ((context) => NewVideoScreen()));
      default:
        throw const FormatException('Routes not found! Check the rutes');
    }
  }
}
