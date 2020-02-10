import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/widgets/video_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

typedef VideoSelectedCallback = void Function(VideoDescriptor video);

class VideoList extends StatelessWidget {
  VideoList({
    this.onVideoSelected,
  });

  final VideoSelectedCallback onVideoSelected;

  Widget _buildListTile(
      BuildContext context, int index, List<VideoDescriptor> videos) {
    final video = videos?.elementAt(index);
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final catalog = Provider.of<VideoCatalog>(context, listen: false);
    final videos = catalog?.categories?.first?.videos;

    return ListView.builder(
      itemCount: videos?.length ?? 0,
      itemBuilder: (context, index) => _buildListTile(context, index, videos),
    );
  }
}
