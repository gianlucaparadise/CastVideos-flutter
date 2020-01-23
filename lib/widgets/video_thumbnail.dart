import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:flutter/material.dart';

class VideoThumbnail extends StatelessWidget {
  VideoThumbnail({this.video, this.imagePrefix});

  final String imagePrefix;
  final VideoDescriptor video;

  @override
  Widget build(BuildContext context) {
    final imageUrl = imagePrefix + video.image480x270;

    return AspectRatio(
      aspectRatio: 480.0 / 270.0,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
