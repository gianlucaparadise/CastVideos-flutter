import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({
    Key key,
    @required this.video,
  }) : super(key: key);

  final VideoDescriptor video;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create an store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.

    final catalog = Provider.of<VideoCatalog>(this.context, listen: false);

    final videoSource = widget.video?.sources
        ?.firstWhere((s) => s.type.toLowerCase() == "hls", orElse: () => null);
    final videoPrefix = catalog?.categories?.first?.hls;
    final videoUrl = videoPrefix + videoSource?.url;
    _controller = VideoPlayerController.network(
      videoUrl,
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  void _onVideoTap() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      // If the video is paused, play it.
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use a FutureBuilder to display a loading spinner while waiting for the
    // VideoPlayerController to finish initializing.
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the VideoPlayer.
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            // Use the VideoPlayer widget to display the video.
            child: Hero(
              // FIXME: this tag should be unique, but right now it isn't. An ID property is missing in the original json. Should I generate one?
              tag: '${widget.video.title}',
              child: GestureDetector(
                onTap: _onVideoTap,
                child: VideoPlayer(_controller),
              ),
            ),
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              VideoThumbnail(
                video: widget.video,
              ),
              CircularProgressIndicator(),
            ],
          );
        }
      },
    );
  }
}
