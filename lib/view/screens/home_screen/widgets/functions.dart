// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FunctionTools extends StatefulWidget {
  const FunctionTools({Key? key}) : super(key: key);

  @override
  State<FunctionTools> createState() => _FunctionToolsState();
}

enum ActionTick { react, comment, save, share }

class _FunctionToolsState extends State<FunctionTools> {
  Map actionTickList = {
    ActionTick.comment: false,
    ActionTick.save: false,
    ActionTick.share: false,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          profilePP(url: 'assets/profile/pp.png', isFriend: true),
          actionBotton(
              iconName: FontAwesomeIcons.solidCommentDots,
              text: '3K',
              tick: ActionTick.comment),
          actionBotton(
              iconName: FontAwesomeIcons.solidBookmark,
              text: '999',
              tick: ActionTick.save),
          actionBotton(
            iconName: FontAwesomeIcons.share,
            text: '22.2K',
            tick: ActionTick.share,
          ),
          // musicCircle(url: 'assets/music/music.png'),
        ],
      ),
    );
  }

  Widget actionBotton(
      {required IconData iconName,
      required String text,
      required ActionTick tick}) {
    Color colorAction;
    if (tick == ActionTick.react) {
      colorAction = actionTickList[tick] ? Colors.red : Colors.white;
    } else {
      colorAction = actionTickList[tick] ? Colors.orange : Colors.white;
    }
    return SizedBox(
      height: 65,
      width: 60,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                actionTickList[tick] = !actionTickList[tick];
              });
            },
            child: Icon(
              iconName,
              size: 40,
              color: colorAction,
            ),
          ),
          Text(text),
        ],
      ),
    );
  }

  // Widget musicCircle({required String url}) {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 25, bottom: 10),
  //     child: Container(
  //       padding: EdgeInsets.all(9),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(25)),
  //         gradient: LinearGradient(
  //           colors: [
  //             Colors.black,
  //             Color.fromARGB(255, 68, 65, 65),
  //             Color.fromARGB(255, 46, 38, 38),
  //             Colors.black,
  //           ],
  //         ),
  //         color: Colors.black,
  //       ),
  //       child: CircleAvatar(
  //         radius: 15,
  //         backgroundImage: AssetImage(url),
  //       ),
  //     ),
  //   );
  // }

  Widget profilePP({required String url, required bool isFriend}) {
    return Container(
      width: 70,
      height: 100,
      padding: EdgeInsets.only(bottom: 15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white30,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(url),
            ),
          ),
          Positioned(
            bottom: 6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Icon(
                isFriend ? FontAwesomeIcons.check : FontAwesomeIcons.plus,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
