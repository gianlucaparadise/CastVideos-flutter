import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/widgets/video_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef VideoSelectedCallback = void Function(VideoDescriptor video);

class VideoList extends StatelessWidget {
  VideoList({
    @required this.videoCatalog,
    this.onVideoSelected,
  });

  final VideoCatalog videoCatalog;
  final VideoSelectedCallback onVideoSelected;

  String get _imagePrefix => this.videoCatalog?.categories?.first?.images;

  List<VideoDescriptor> get _videos =>
      this.videoCatalog?.categories?.first?.videos;

  Widget _buildListTile(BuildContext context, int index) {
    var video = _videos?.elementAt(index);
    if (video == null) {
      return ListTile(
        title: Text('---'),
        onTap: () => this.onVideoSelected?.call(video),
      );
    }

    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => this.onVideoSelected?.call(video),
        child: VideoListItem(
          video: video,
          imagePrefix: _imagePrefix,
        ),
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
