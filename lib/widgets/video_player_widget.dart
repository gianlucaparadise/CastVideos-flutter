import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/widgets/play_button.dart';
import 'package:cast_videos_flutter/widgets/video_player_controls.dart';
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
  _VideoPlayerWidgetState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  Future<void> _initializeVideoPlayerFuture;

  /// When true, the video should play.
  /// If the video controller isn't initialized yet, the video should play
  /// as soon as the video controller has initialized.
  bool _hasRequestedStart = false;

  VoidCallback listener;

  @override
  void initState() {
    widget.controller.addListener(listener);

    if (!widget.controller.value.isInitialized) {
      _initializeVideoPlayerFuture = widget.controller.initialize();
    } else {
      _initializeVideoPlayerFuture = Future.value();
    }

    super.initState();
  }

  @override
  void deactivate() {
    widget.controller.removeListener(listener);
    super.deactivate();
  }

  void _onVideoTap() {
    setState(() {
      _hasRequestedStart = true;

      if (widget.controller.value.isPlaying) {
        // If the video is playing, pause it.
        widget.controller.pause();
      } else {
        widget.controller.play();
      }
    });
  }

  Widget _getPlayButton() {
    return PlayButton(
      isPlaying: widget.controller.value.isPlaying,
      onTap: _onVideoTap,
    );
  }

  Widget _getBottomControllers() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: VideoPlayerControls(
        controller: widget.controller,
        onPlayButtonTap: _onVideoTap,
      ),
    );
  }

  Widget _getThumbnail(bool showProgress) {
    var overlay;
    if (showProgress) {
      overlay = CircularProgressIndicator();
    } else {
      overlay = _getPlayButton();
    }

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        VideoThumbnail(
          video: widget.video,
        ),
        overlay,
      ],
    );
  }

  Widget _getVideoPlayer() {
    return AspectRatio(
      aspectRatio: 480.0 / 270.0,
      // Use the VideoPlayer widget to display the video.
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: _onVideoTap,
            child: Hero(
              tag: '${widget.video.title}',
              child: VideoPlayer(widget.controller),
            ),
          ),
          _getPlayButton(),
          _getBottomControllers(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use a FutureBuilder to display a loading spinner while waiting for the
    // VideoPlayerController to finish initializing.
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (!_hasRequestedStart) {
          // If the user hasn't started the video, I show the thumbnail
          return _getThumbnail(false);
        }

        if (snapshot.connectionState != ConnectionState.done) {
          // If the user has started the video, but the video controller is not ready yet:
          // show the thumbnail with a progress indicator overlay
          return _getThumbnail(true);
        }

        // If the user has started the video and the videocontroller is ready:
        // I show the video
        return _getVideoPlayer();
      },
    );
  }
}
