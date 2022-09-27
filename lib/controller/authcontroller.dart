import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streax_share/constants.dart';
import 'package:firebase_core/firebase_core.dart' as firebasecore;
import 'package:streax_share/model%20/user.dart' as model;

class AuthController {
  AuthController._();
  static final instance = AuthController._();

  // Function to register user with new credentials
  Future<bool> registerUser({
    required String username,
    required String email,
    required String password,
    required PlatformFile? image,
  }) async {
    if (username.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        image!.path != null) {
      try {
        print('User creating');
        UserCredential userCred = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        print('Uploading images');
        Set imageUploadRes = await _uploadToStorage(image);
        if (!imageUploadRes.elementAt(1)) {
          print('Upload error thrown');
          throw Exception('Error occured while uploading Images.');
        }
        String downloadUrl = imageUploadRes.first;
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
            .catchError((error) => print('User Creation failed $error'));
        return true;
      } catch (error) {
        print(
            'User Creation failed \n Primary error in registerUser function $error');
        return false;
      }
    } else {
      print('Null values on input field.');
      return false;
    }
  }

  // Function to upload image to cloud storage
  Future<Set> _uploadToStorage(PlatformFile? image) async {
    String path = firebaseAuth.currentUser!.uid;
    File file = File(image!.path!);
    Reference ref =
        firebaseStorage.ref().child('test/').child('$path/').child(image.name);
    try {
      // The way to upload File type file
      UploadTask uploadTask = ref.putFile(file);
      // UploadTask uploadTask = ref.putData(image.bytes!);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return {downloadUrl, true};
    } on firebasecore.FirebaseException catch (e) {
      print('Error uploading Images $e');
      return {'', false};
    }
  }

  // Login using credential
  Future<Set> loginUser(
    String email,
    String password,
  ) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        // .then((value) => {'', true});
        return {'', true};
      } on FirebaseAuthException catch (error) {
        return {error.message.toString(), false};
      } catch (error) {
        return {error.toString(), false};
      }
    } else {
      return {'Empty Field!', false};
    }
    // } catch (e) {
    //   return {'Network Error!', false};
    // }
  }

  Future<XFile?> pickVideo() async {
    try {
      XFile? image = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 1),
      );
      if (image == null) return null;
      return image;
    } catch (e) {
      return null;
    }
  }
}
