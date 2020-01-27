import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:flutter/material.dart';

class VideoDetailRoute extends StatelessWidget {
  VideoDetailRoute({@required this.video});

  final VideoDescriptor video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(video.title),
      ),
      body: Container(),
    );
  }
}
