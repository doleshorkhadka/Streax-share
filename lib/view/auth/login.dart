// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:streax_share/constants.dart';
import 'package:streax_share/routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            inputTextField(
              controller: _emailcontroller,
              hintText: 'Enter email address',
            ),
            SizedBox(
              height: 15,
            ),
            inputTextField(
              controller: _emailcontroller,
              hintText: 'Enter Password',
            ),
            SizedBox(
              height: 20,
            ),
            submitButton(),
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

  Widget submitButton({
    VoidCallback? ontap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: kbuttonColor,
      ),
      child: InkWell(
        onTap: ontap,
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget inputTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }
}
