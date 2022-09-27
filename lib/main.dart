import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streax_share/constants.dart';
import 'package:streax_share/routes.dart';
import 'package:streax_share/core/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyUI());
}

class MyUI extends StatelessWidget {
  const MyUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => authController,
      child: MaterialApp(
        initialRoute: firebaseAuth.currentUser == null
            ? MaterialRoutes.login
            : MaterialRoutes.homepage,
        debugShowCheckedModeBanner: false,
        theme: MainAppTheme.dark,
        themeMode: ThemeMode.dark,
        onGenerateRoute: MaterialRoutes.routeSettings,
      ),
    );
  }
}
