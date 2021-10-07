import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:flutter/material.dart';

class VideoDescription extends StatelessWidget {
  VideoDescription({required this.video});

  final VideoDescriptor video;

  @override
  Widget build(BuildContext context) {
    // This section appear different from the original: https://github.com/googlecast/CastVideos-android/blob/master/res/layout/player_activity.xml#L136-L172
    // This is because the original page is not using themes, while I do.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          video.title ?? "",
          style: Theme.of(context).textTheme.headline5,
        ),
        Container(height: 2), // spacer
        Text(
          video.studio ?? "",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Container(height: 10), // spacer
        Text(
          video.subtitle ?? "",
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
