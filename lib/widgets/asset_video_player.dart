import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AssetVideoPlayer extends StatefulWidget {
  final File? file;

  const AssetVideoPlayer({Key? key, required this.file}) : super(key: key);

  @override
  State<AssetVideoPlayer> createState() => _AssetVideoPlayerState();
}

class _AssetVideoPlayerState extends State<AssetVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(widget.file!)
      ..addListener(() => setState(() {}))
      ..initialize().then((_) {
        setState(() {});
        videoPlayerController.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    // videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          VideoPlayer(videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                /*  if (videoPlayerController.value.isPlaying) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }
*/
                setState(() {});
              },
              icon: Icon(
                isPlay ? Icons.pause_circle : Icons.play_circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
