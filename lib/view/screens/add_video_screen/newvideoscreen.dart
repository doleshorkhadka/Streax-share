import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streax_share/core/app_color.dart';

class NewVideoScreen extends StatefulWidget {
  const NewVideoScreen({super.key});

  @override
  State<NewVideoScreen> createState() => _NewVideoScreenState();
}

class _NewVideoScreenState extends State<NewVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leading: const Icon(FontAwesomeIcons.video),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Add New Video'),
            Icon(FontAwesomeIcons.angleRight),
          ],
        ),
        elevation: 10,
      ),
      backgroundColor: AppColor.backgroundshadeblue,
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height / 7,
      ),
    );
  }
}
