import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:flutter/material.dart';

class VideoHeading extends StatelessWidget {
  VideoHeading({this.video});

  final VideoDescriptor video;

  @override
  Widget build(BuildContext context) {
    // Text styles are copied from:
    // https://github.com/googlecast/CastVideos-android/blob/master/res/layout/browse_row.xml

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          video.title,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: 18,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        Container(height: 2),
        Text(
          video.studio,
          style: Theme.of(context).textTheme.caption.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        )
      ],
    );
  }
}
