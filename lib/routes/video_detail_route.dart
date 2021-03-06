import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/widgets/video_description.dart';
import 'package:cast_videos_flutter/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoDetailRoute extends StatefulWidget {
  VideoDetailRoute({
    @required this.video,
  });

  final VideoDescriptor video;

  @override
  _VideoDetailRouteState createState() => _VideoDetailRouteState();
}

class _VideoDetailRouteState extends State<VideoDetailRoute> {
  VideoPlayerController _controller;

  @override
  void initState() {
    final catalog = Provider.of<VideoCatalog>(this.context, listen: false);

    final videoSource = widget.video?.sources
        ?.firstWhere((s) => s.type.toLowerCase() == "hls", orElse: () => null);
    final videoPrefix = catalog?.categories?.first?.hls;
    final videoUrl = videoPrefix + videoSource?.url;
    _controller = VideoPlayerController.network(
      videoUrl,
    );
    // The widget will initialize it if needed

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  Widget _getPortrait() {
    return Column(
      children: <Widget>[
        VideoPlayerWidget(
          video: widget.video,
          controller: _controller,
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: VideoDescription(
            video: widget.video,
          ),
        ),
      ],
    );
  }

  Widget _getLandscape() {
    return Center(
      child: VideoPlayerWidget(
        video: widget.video,
        controller: _controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _getPortrait();
          }
          return _getLandscape();
        },
      ),
    );
  }
}
