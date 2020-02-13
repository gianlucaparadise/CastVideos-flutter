import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({
    Key key,
    @required this.video,
    @required this.controller,
  }) : super(key: key);

  final VideoDescriptor video;

  /// Video Controller. This is an input parameter to keep state over re-instantations of the widget
  final VideoPlayerController controller;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    if (!widget.controller.value.initialized) {
      _initializeVideoPlayerFuture = widget.controller.initialize();
    } else {
      _initializeVideoPlayerFuture = Future.value();
    }

    super.initState();
  }

  void _onVideoTap() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
    } else {
      // If the video is paused, play it.
      widget.controller.play();
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
            aspectRatio: widget.controller.value.aspectRatio,
            // Use the VideoPlayer widget to display the video.
            child: Hero(
              // FIXME: this tag should be unique, but right now it isn't. An ID property is missing in the original json. Should I generate one?
              tag: '${widget.video.title}',
              child: GestureDetector(
                onTap: _onVideoTap,
                child: VideoPlayer(widget.controller),
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
