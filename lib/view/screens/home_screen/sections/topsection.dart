// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streax_share/routes.dart';

class TopSection extends StatelessWidget {
  const TopSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.black87,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Icon(
              Icons.live_tv,
              size: 28,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, MaterialRoutes.newvideo);
            },
            child: Icon(FontAwesomeIcons.plus),
          ),
          InkWell(
            child: Icon(
              Icons.search,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
