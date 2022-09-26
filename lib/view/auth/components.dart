import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:streax_share/constants.dart';

class AuthComponents {
  Widget inputTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardtype = TextInputType.visiblePassword,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardtype,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }

  Widget submitButton({
    required String text,
    required VoidCallback onClick,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: kbottonSize,
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  notificationBox(massengerstate, message) {
    massengerstate.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget progressIndicator({
    Key? key,
    required inAsyncCall,
    double opacity = 0.3,
    Color color = Colors.grey,
    Widget progressIndicator = const CircularProgressIndicator(),
    Offset? offset,
    bool dismissible = false,
    required Widget child,
    double blur = 0.0,
  }) {
    if (!inAsyncCall) return child;
    Widget layOutProgressIndicator;
    if (offset == null) {
      layOutProgressIndicator = Center(child: progressIndicator);
    } else {
      layOutProgressIndicator = Positioned(
        left: offset.dx,
        top: offset.dy,
        child: progressIndicator,
      );
    }

    return Stack(
      children: [
        child,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: dismissible, color: color),
          ),
        ),
        layOutProgressIndicator,
      ],
    );
  }
}
