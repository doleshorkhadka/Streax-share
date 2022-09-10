// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:streax_share/constants.dart';
import 'package:streax_share/routes.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  PlatformFile? _image;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  bool _isImageUploaded = false;

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
            avatarImage(context),
            SizedBox(
              height: 15,
            ),
            inputTextField(
              controller: _usernamecontroller,
              hintText: 'Enter username',
            ),
            SizedBox(
              height: 15,
            ),
            inputTextField(
              controller: _emailcontroller,
              hintText: 'Enter email address',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 15,
            ),
            inputTextField(
              controller: _passwordcontroller,
              hintText: 'Enter Password',
              isObsecured: true,
            ),
            SizedBox(
              height: 20,
            ),
            submitButton(),
            SizedBox(
              height: 20,
            ),
            loginSection(context)
          ],
        ),
      ),
    );
  }

  InkWell avatarImage(context) {
    return InkWell(
      onTap: uploadImage,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            foregroundImage: _isImageUploaded
                ? null
                : AssetImage('assets/profile/default.png'),
            backgroundImage:
                _image == null ? null : FileImage(io.File(_image!.path!)),
          ),
          Positioned(
              bottom: 5,
              right: 5,
              child: Icon(_isImageUploaded
                  ? FontAwesomeIcons.image
                  : FontAwesomeIcons.fileCirclePlus)),
        ],
      ),
    );
  }

  Row loginSection(BuildContext context) {
    return Row(
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
    );
  }

  void uploadImage() async {
    FilePickerResult? image = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (image != null) {
      Get.snackbar('Success !', 'Image Uploaded');
    }
    setState(() {
      _image = image!.files.first;
      _isImageUploaded = true;
    });
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

  Widget inputTextField({
    required TextEditingController controller,
    required String hintText,
    isObsecured = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObsecured,
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
