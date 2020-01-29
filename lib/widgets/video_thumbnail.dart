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
      child: Hero(
        // FIXME: this tag should be unique, but right now it isn't. An ID property is missing in the original json
        tag: '${video.title}',
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
