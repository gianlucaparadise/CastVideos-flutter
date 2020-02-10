import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/widgets/video_heading.dart';
import 'package:cast_videos_flutter/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';

class VideoListItem extends StatelessWidget {
  VideoListItem({this.video});

  final VideoDescriptor video;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: VideoThumbnail(
            video: video,
          ),
        ),
        Container(width: 10), // this is a spacer
        Expanded(
          flex: 1,
          child: VideoHeading(
            video: video,
          ),
        )
      ],
    );
  }
}
