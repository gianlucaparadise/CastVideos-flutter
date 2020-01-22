import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoList extends StatelessWidget {
  VideoList({this.videoCatalog});

  final VideoCatalog videoCatalog;

  List<VideoDescriptor> get _videos =>
      this.videoCatalog?.categories?.first?.videos;

  Widget _buildListTile(BuildContext context, int index) {
    var video = _videos?.elementAt(index);
    if (video == null) {
      return ListTile(
        title: Text('---'),
      );
    }

    return ListTile(
      title: Text(video.title),
      subtitle: Text(video.studio),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _videos?.length,
      itemBuilder: _buildListTile,
    );
  }
}
