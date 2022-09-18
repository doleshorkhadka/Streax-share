// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
      body: ModalProgressHUD(
        inAsyncCall: _isLoggedIn,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/app-icon/streaxshare.png"),
                  radius: 60,
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
              ReusedComponents().inputTextField(
                controller: _emailcontroller,
                hintText: 'Enter email address',
              ),
              SizedBox(
                height: 15,
              ),
              ReusedComponents().inputTextField(
                controller: _passwordcontroller,
                hintText: 'Enter Password',
                isObsecured: true,
              ),
              SizedBox(
                height: 20,
              ),
              ReusedComponents().submitButton(
                  text: 'Login',
                  ontap: () async {
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
                        ReusedComponents()
                            .notificationBox(messengerState, _snackbarText);
                      } else {
                        if (!mounted) return;
                        Navigator.popAndPushNamed(
                            context, RoutesManager.homepage);
                      }
                    } else {
                      ScaffoldMessengerState messengerState =
                          ScaffoldMessenger.of(context);
                      ReusedComponents()
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
      ),
    );
  }
}
