// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:streax_share/constants.dart';
import 'package:streax_share/routes.dart';
import 'package:streax_share/view/auth/components.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  bool _isLoggedIn = false;
  String _snackbarText = 'Fill the empty field!!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("assets/app-icon/streaxshare.png")),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Streax Share',
                  style: TextStyle(
                      fontSize: 40,
                      color: kbuttonColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            AuthComponents().inputTextField(
              controller: _emailcontroller,
              hintText: 'Enter email address',
              keyboardtype: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 15,
            ),
            AuthComponents().inputTextField(
              controller: _passwordcontroller,
              hintText: 'Enter Password',
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            AuthComponents().submitButton(
                text: 'Login',
                onClick: () async {
                  if (_emailcontroller.text.isNotEmpty &&
                      _passwordcontroller.text.isNotEmpty) {
                    setState(() {
                      _isLoggedIn = true;
                    });
                    ScaffoldMessengerState messengerState =
                        ScaffoldMessenger.of(context);
                    Set result = await authController.loginUser(
                      _emailcontroller.text,
                      _passwordcontroller.text,
                    );
                    setState(() {
                      _isLoggedIn = false;
                    });
                    _snackbarText = result.first;
                    if (!result.last) {
                      AuthComponents()
                          .notificationBox(messengerState, _snackbarText);
                    } else {
                      if (!mounted) return;
                      Navigator.popAndPushNamed(
                          context, RoutesManager.homepage);
                    }
                  } else {
                    ScaffoldMessengerState messengerState =
                        ScaffoldMessenger.of(context);
                    AuthComponents()
                        .notificationBox(messengerState, _snackbarText);
                  }
                }),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an Account?'),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Text(
                    'Register!',
                    style: TextStyle(
                      color: kbuttonColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, RoutesManager.register);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
