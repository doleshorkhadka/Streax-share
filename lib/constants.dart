import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:streax_share/core/app_color.dart';

import 'controller/authcontroller.dart';

double kbottomWidth = 60;

double ktopwidth = 70;

double kbottonSize = 64;

Color kbuttonColor = Colors.orangeAccent;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;

// const variables

var kCaptionDecoration = InputDecoration(
    labelStyle: TextStyle(color: AppColor.primaryColor),
    hintStyle: TextStyle(color: AppColor.backgroundshadeblue),
    labelText: 'Caption',
    hintText: 'Less than 100 words!',
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.primaryColor, width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.primaryColor, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ));
