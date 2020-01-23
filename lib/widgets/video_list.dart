import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/widgets/video_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoList extends StatelessWidget {
  VideoList({this.videoCatalog});

  final VideoCatalog videoCatalog;

  String get imagePrefix => this.videoCatalog?.categories?.first?.images;

  List<VideoDescriptor> get _videos =>
      this.videoCatalog?.categories?.first?.videos;

  Widget _buildListTile(BuildContext context, int index) {
    var video = _videos?.elementAt(index);
    if (video == null) {
      return ListTile(
        title: Text('---'),
      );
    }

    return Padding(
      padding: EdgeInsets.all(10),
      child: VideoListItem(
        video: video,
        imagePrefix: imagePrefix,
      ),
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
