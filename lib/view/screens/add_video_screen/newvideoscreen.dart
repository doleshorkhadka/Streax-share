import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:streax_share/constants.dart';
import 'package:streax_share/core/app_color.dart';
import 'package:video_player/video_player.dart';

class NewVideoScreen extends StatefulWidget {
  const NewVideoScreen({super.key});

  @override
  State<NewVideoScreen> createState() => _NewVideoScreenState();
}

class _NewVideoScreenState extends State<NewVideoScreen> {
  File? videoFile;
  VideoPlayerController? _videocontroller;
  final TextEditingController _textcontroller = TextEditingController();
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void dispose() {
    if (_videocontroller != null) _videocontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            conditionIconChanger(
              onTap: () {
                setState(() {
                  _textcontroller.clear();
                  _videocontroller = null;
                  videoFile = null;
                });
              },
              condition: _videocontroller == null,
              trueIcon: FontAwesomeIcons.video,
              falseIcon: FontAwesomeIcons.xmark,
            ),
            Text(_videocontroller == null ? 'Add New Video' : 'Upload Video'),
            conditionIconChanger(
              onTap: () {
                print('Uploading');
                Navigator.pop(context);
              },
              condition: _videocontroller == null,
              trueIcon: FontAwesomeIcons.angleRight,
              falseIcon: FontAwesomeIcons.check,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        elevation: 10,
      ),
      backgroundColor: AppColor.backgroundGray,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Column(
            children: [
              videoFile == null
                  ? Container(
                      color: AppColor.backgroundshadeblue,
                      child: TextButton.icon(
                        onPressed: videoPickerFunction,
                        icon: Icon(
                          FontAwesomeIcons.videoSlash,
                          color: AppColor.black,
                        ),
                        label: Text(
                          'Select Videos',
                          style: TextStyle(color: AppColor.black),
                        ),
                      ),
                    )
                  : _videocontroller != null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height -
                              AppBar().preferredSize.height -
                              200,
                          child: videoFutureBuilder(),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
              _videocontroller != null
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: VideoProgressIndicator(
                            _videocontroller!,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              backgroundColor: AppColor.navbar,
                            ),
                          ),
                        ),
                        captionSection()
                      ],
                    )
                  : Container(),
            ],
          ),
          bottomSection
        ],
      ),
    );
  }

  InkWell conditionIconChanger({
    required bool condition,
    required IconData trueIcon,
    required IconData falseIcon,
    VoidCallback? onTap,
    Color color = Colors.white,
  }) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        condition ? trueIcon : falseIcon,
      ),
    );
  }

  Widget captionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        controller: _textcontroller,
        maxLines: 3,
        style: TextStyle(color: AppColor.black),
        decoration: kCaptionDecoration,
      ),
    );
  }

  FutureBuilder<void> videoFutureBuilder() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(_videocontroller!.value.size.height /
              (_videocontroller!.value.aspectRatio * 2));
          return Column(
            children: [
              Expanded(child: Container()),
              AspectRatio(
                aspectRatio: _videocontroller!.value.aspectRatio,
                child: VideoPlayer(_videocontroller!),
              ),
              Expanded(child: Container()),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Container get bottomSection {
    return Container(
      height: 50,
      color: AppColor.background,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Text(
                'Gallery',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.black),
              ),
            ),
          ),
          Container(
            height: 45,
            width: 3,
            color: AppColor.black,
          ),
          Expanded(
            child: Text(
              'Camera',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.black),
            ),
          )
        ],
      ),
    );
  }

  void videoPickerFunction() async {
    XFile? video = await authController.pickVideo();
    if (video != null) {
      setState(() {
        videoFile = File(video.path);
      });
      _videocontroller = VideoPlayerController.file(videoFile!);

      _initializeVideoPlayerFuture = _videocontroller!.initialize().then((_) {
        setState(() {});
      });
    }
  }
}
