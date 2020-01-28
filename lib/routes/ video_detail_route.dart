import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/widgets/video_description.dart';
import 'package:cast_videos_flutter/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';

class VideoDetailRoute extends StatelessWidget {
  VideoDetailRoute({
    @required this.videoCatalog,
    @required this.video,
  });

  final VideoCatalog videoCatalog;
  final VideoDescriptor video;

  String get _imagePrefix => this.videoCatalog?.categories?.first?.images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(video.title),
      ),
      body: Column(
        children: <Widget>[
          VideoThumbnail(
            video: video,
            imagePrefix: _imagePrefix,
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
