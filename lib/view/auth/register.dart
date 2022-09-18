// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:streax_share/constants.dart';
import 'package:streax_share/model%20/user.dart' as model;
import 'package:streax_share/routes.dart';
import 'package:streax_share/view/auth/components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  PlatformFile? _image;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isImageUploaded = false;
  bool _isProcessBar = false;
  bool _registerUserSts = false;
  bool _isregisterClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isProcessBar,
        child: Center(
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
              inputInfo(
                context,
                _usernamecontroller,
                '@Must be atleast 4 characters!',
              ),
              ReusedComponents().inputTextField(
                controller: _usernamecontroller,
                hintText: 'Enter username',
              ),
              inputInfo(
                context,
                _emailcontroller,
                '@Must be valid email address!',
              ),
              ReusedComponents().inputTextField(
                controller: _emailcontroller,
                hintText: 'Enter email address',
                keyboardType: TextInputType.emailAddress,
              ),
              inputInfo(
                context,
                _passwordcontroller,
                '@Must be atleast 8 characters!',
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
                  text: 'Register',
                  ontap: () async {
                    setState(() {
                      _isProcessBar = true;
                      _isregisterClicked = true;
                    });
                    ScaffoldMessengerState messengerState =
                        ScaffoldMessenger.of(context);
                    if (_emailcontroller.value.text.isEmpty ||
                        _passwordcontroller.value.text.isEmpty ||
                        _usernamecontroller.value.text.isEmpty ||
                        _image == null) {
                      ReusedComponents().notificationBox(
                          messengerState, 'Fill all input fields !!!');
                      setState(() {
                        _isProcessBar = false;
                      });
                      return;
                    }
                    _registerUserSts = await authController.registerUser(
                      email: _emailcontroller.value.text,
                      username: _usernamecontroller.value.text,
                      password: _passwordcontroller.value.text,
                      image: _image,
                    );
                    setState(() {
                      _isProcessBar = false;
                    });
                    if (!_registerUserSts) {
                      ReusedComponents().notificationBox(
                          messengerState, 'Error creating user !!!');
                    } else {
                      if (!mounted) return;
                      Navigator.popAndPushNamed(
                          context, RoutesManager.homepage);
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              loginSection(context)
            ],
          ),
        ),
      ),
    );
  }

  Container inputInfo(
    BuildContext context,
    TextEditingController controller,
    String message,
  ) {
    Color color = (_isregisterClicked && controller.text.isEmpty)
        ? Colors.red
        : Colors.white;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        height: 10,
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.circleInfo,
              size: 10,
              color: color,
            ),
            SizedBox(
              width: 5,
            ),
            Text(message,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                )),
          ],
        ));
  }

  InkWell avatarImage(BuildContext context) {
    Color color =
        (_isregisterClicked && _image == null) ? Colors.red : Colors.white;
    return InkWell(
      onTap: uploadImage,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: color,
              ),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 60,
              foregroundImage: _isImageUploaded
                  ? null
                  : AssetImage('assets/profile/default.png'),
              backgroundImage:
                  _image == null ? null : FileImage(io.File(_image!.path!)),
            ),
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
    ScaffoldMessengerState messengerState = ScaffoldMessenger.of(context);
    FilePickerResult? image = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (image != null) {
      setState(() {
        _image = image.files.first;
        _isImageUploaded = true;
      });
      ReusedComponents().notificationBox(messengerState, 'Image Uploaded');
    }
    if (image == null) {
      ReusedComponents().notificationBox(messengerState, 'No Image Selected');
      return null;
    }
  }
}
