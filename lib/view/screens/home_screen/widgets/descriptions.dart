// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextDescription extends StatefulWidget {
  TextDescription({Key? key}) : super(key: key);

  @override
  State<TextDescription> createState() => _TextDescriptionState();
}

class _TextDescriptionState extends State<TextDescription> {
  bool isTextShown = false;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(left: 5, bottom: 10),
          child: Text(
            'Doleshor Khadka',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        description(deviceWidth),
      ],
    );
  }

  // Row musicDetails() {
  //   return Row(mainAxisSize: MainAxisSize.min, children: [
  //     Icon(
  //       Icons.music_note_outlined,
  //     ),
  //     SizedBox(
  //       width: 5,
  //     ),
  //     Expanded(
  //       child: Container(
  //         padding: EdgeInsets.only(right: 15),
  //         child: Text(
  //           'original sound - Manisha sujal sagar dancing in the rain. ',
  //           overflow: TextOverflow.ellipsis,
  //           maxLines: 1,
  //           softWrap: true,
  //         ),
  //       ),
  //     ),
  //   ]);
  // }

  Row description(double deviceWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: isTextShown ? 85 : 16,
            padding: EdgeInsets.only(left: 5),
            child: Text(
              'This is considered an error condition because it indicates that there is content that cannot be seen. If the content is legitimately bigger than the available space',
              maxLines: isTextShown ? 5 : 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          width: deviceWidth / 4,
          child: InkWell(
            child: Text(
              isTextShown ? 'Hide' : 'See more',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              setState(() {
                isTextShown = !isTextShown;
              });
            },
          ),
        ),
      ],
    );
  }
}
