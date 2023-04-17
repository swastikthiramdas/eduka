import 'package:eduka/widgets/video_player.dart';
import 'package:flutter/material.dart';


class PlayVideoScreen extends StatelessWidget {
  final String uil;

  const PlayVideoScreen({Key? key, required this.uil}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
      ),
      body: VideoPlayerItem(videoUrl: uil,),
    );
  }
}
