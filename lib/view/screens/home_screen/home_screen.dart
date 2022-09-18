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
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: ktopwidth),
              height: height -
                  kbottomWidth -
                  padding.top -
                  padding.bottom -
                  ktopwidth,
              width: width,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(
                      height: height -
                          kbottomWidth -
                          padding.top -
                          padding.bottom -
                          ktopwidth,
                      width: width,
                      color: Color(0x29348823),
                    ),
            ),
            Column(
              children: const [
                TopSection(),
                CenterSection(),
                ReactSection(),
                BottomSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReactSection extends StatelessWidget {
  const ReactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      color: Colors.lightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
            5,
            (index) => Container(
                  height: 50,
                  width: 50,
                  color: Colors.black,
                )),
      ),
    );
  }
}
