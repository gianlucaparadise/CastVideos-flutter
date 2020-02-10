import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/widgets/video_description.dart';
import 'package:cast_videos_flutter/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';

class VideoDetailRoute extends StatelessWidget {
  VideoDetailRoute({
    @required this.video,
  });

  final VideoDescriptor video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(video.title),
      ),
      body: Column(
        children: <Widget>[
          // VideoThumbnail(
          //   video: video,
          //   imagePrefix: _imagePrefix,
          // ),
          VideoPlayerWidget(
            video: video,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: VideoDescription(
              video: video,
            ),
          ),
        ],
      ),
    );
  }
}
