// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streax_share/constants.dart';
import 'package:streax_share/routes.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  bool isImageUploaded = false;

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
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  foregroundImage: isImageUploaded
                      ? AssetImage('assets/music/music.png')
                      : null,
                  backgroundImage: AssetImage('assets/profile/default.png'),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () async {
                      FilePickerResult? image =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg', 'jpeg'],
                      );
                      print(image!.names);
                      print('File uploaded successfully !!');
                    },
                    child: Icon(FontAwesomeIcons.camera),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            inputTextField(
              hintText: 'Enter email address',
            ),
            SizedBox(
              height: 15,
            ),
            inputTextField(
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
                Text('Already have an Account?'),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Text(
                    'Log In!',
                    style: TextStyle(
                      color: kbuttonColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, RoutesManager.login);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget submitButton({VoidCallback? ontap}) {
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
            'Register',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget inputTextField({required String hintText}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
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
