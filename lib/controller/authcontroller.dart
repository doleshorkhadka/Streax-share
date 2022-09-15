import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:streax_share/constants.dart';
import 'package:firebase_core/firebase_core.dart' as firebasecore;
import 'package:streax_share/model%20/user.dart' as model;

class AuthController {
  AuthController._();
  static final instance = AuthController._();

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required PlatformFile? image,
  }) async {
    if (username.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        image != null) {
      UserCredential userCred = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      String downloadUrl = await _uploadToStorage(image);
      model.User user = model.User(
        username: username,
        email: email,
        uid: userCred.user!.uid,
        imageUrl: downloadUrl,
      );
      firestore
          .collection('/users')
          .doc(firebaseAuth.currentUser!.uid)
          .set(user.toJson())
          .then((_) => print("user-created"))
          .catchError((error) => print('Add failed: $error'));
    }
  }

  Future<String> _uploadToStorage(PlatformFile image) async {
    String path = firebaseAuth.currentUser!.uid;
    Reference ref =
        firebaseStorage.ref().child('test/').child('$path/').child(image.name);
    try {
      // The way to upload File type file
      // UploadTask uploadTask = ref.putFile(file);
      UploadTask uploadTask = ref.putData(image.bytes!);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
    } on firebasecore.FirebaseException catch (e) {
      print(e);
      return 'Fuckkkkkkkkkk';
    }
  }
}
