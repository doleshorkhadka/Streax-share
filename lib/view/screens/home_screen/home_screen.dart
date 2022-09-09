import 'package:flutter/material.dart';
import 'package:streax_share/constants.dart';
import 'package:streax_share/view/screens/home_screen/sections/bottomsection.dart';
import 'package:streax_share/view/screens/home_screen/sections/topsection.dart';
import 'package:streax_share/view/screens/home_screen/sections/centersection.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = MediaQuery.of(context).viewPadding;
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height - kbottomWidth - padding.top - padding.bottom,
              width: widht,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(
                      height:
                          height - kbottomWidth - padding.top - padding.bottom,
                      width: widht,
                      color: Color(0x29348823),
                    ),
            ),
            Column(
              children: const [
                TopSection(),
                CenterSection(),
                BottomSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
