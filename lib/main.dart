import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:streax_share/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // .then((value) {
  //   AuthController();
  // });
  runApp(const MyUI());
}

class MyUI extends StatelessWidget {
  const MyUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RoutesManager.register,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      onGenerateRoute: RoutesManager.routeSettings,
    );
  }
}
