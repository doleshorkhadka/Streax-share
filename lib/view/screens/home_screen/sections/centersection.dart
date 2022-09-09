// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:streax_share/view/screens/home_screen/widgets/descriptions.dart';
import 'package:streax_share/view/screens/home_screen/widgets/functions.dart';

class CenterSection extends StatelessWidget {
  const CenterSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: TextDescription(),
          ),
          FunctionTools(),
        ],
      ),
    );
  }
}
