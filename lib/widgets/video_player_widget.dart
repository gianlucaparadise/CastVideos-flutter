import 'package:cast_videos_flutter/cast/cast_manager.dart';
import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/routes/expanded_controls_route.dart';
import 'package:cast_videos_flutter/services/routing/my_page_route.dart';
import 'package:cast_videos_flutter/widgets/video_player_controls.dart';
import 'package:cast_videos_flutter/widgets/video_player_popup_menu_button.dart';
import 'package:cast_videos_flutter/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({
    Key? key,
    required this.video,
    required this.videoPlayerController,
    required this.isCastConnected,
  }) : super(key: key);

  final VideoDescriptor video;
  final bool isCastConnected;

  /// Video Controller. This is an input parameter to keep state over re-instantations of the widget
  final VideoPlayerController videoPlayerController;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerControlsController _controlsController;

  _VideoPlayerWidgetState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  late Future<void> _initializeVideoPlayerFuture;

  /// When true, the video should play.
  /// If the video controller isn't initialized yet, the video should play
  /// as soon as the video controller has initialized.
  bool _hasRequestedStart = false;

  late VoidCallback listener;

  @override
  void initState() {
    _controlsController = VideoPlayerControlsController();

    widget.videoPlayerController.addListener(listener);

    // FIXME: I should avoid videoPlayerController initialization when the app is casting
    if (!widget.videoPlayerController.value.isInitialized) {
      _initializeVideoPlayerFuture = widget.videoPlayerController.initialize();
    } else {
      _initializeVideoPlayerFuture = Future.value();
    }

    super.initState();
  }

  @override
  void deactivate() {
    widget.videoPlayerController.removeListener(listener);
    super.deactivate();
  }

  void _onPlayButtonTap() {
    setState(() {
      _hasRequestedStart = true;

      if (widget.videoPlayerController.value.isPlaying) {
        // If the video is playing, pause it.
        widget.videoPlayerController.pause();
      } else {
        widget.videoPlayerController.play();
      }
    });
  }

  void _onVideoTap() {
    _controlsController.showControls();
  }

  void _onPlayNowToCast() {
    final catalog = Provider.of<VideoCatalog?>(context, listen: false);
    final categories = catalog?.categories;
    if (categories == null || categories.isEmpty) {
      debugPrint("missing catalog categories, cannot load media");
      return;
    }

    final category = categories.first;
    final castManager = Provider.of<CastManager>(context, listen: false);
    castManager.loadMedia(this.widget.video, category, 0, true);

    Navigator.of(context).push(
      createRoute(
        ExpandedControlsRoute(),
      ),
    );
  }

  Widget _getBottomControllers() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: VideoPlayerControls(
        videoPlayerController: widget.videoPlayerController,
        onPlayButtonTap: _onPlayButtonTap,
        controller: _controlsController,
      ),
    );
  }

  Widget _getThumbnail(bool showProgress, bool isCastConnected) {
    var overlay;
    if (showProgress) {
      overlay = CircularProgressIndicator();
    } else if (isCastConnected) {
      overlay = VideoPlayerPopupMenuButton(
        onPlayNow: _onPlayNowToCast,
      );
    } else {
      overlay = IconButton(
        iconSize: 80,
        color: Colors.white,
        onPressed: _onPlayButtonTap,
        icon: Icon(Icons.play_circle_filled),
      );
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
              child: VideoPlayer(widget.videoPlayerController),
            ),
          ),
          _getBottomControllers(),
        ],
      ),
    );
  }

  Widget _getVideoPlayerBuilder() {
    // Use a FutureBuilder to display a loading spinner while waiting for the
    // VideoPlayerController to finish initializing.
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (!_hasRequestedStart) {
          // If the user hasn't started the video, I show the thumbnail
          return _getThumbnail(false, false);
        }

        if (snapshot.connectionState != ConnectionState.done) {
          // If the user has started the video, but the video controller is not ready yet:
          // show the thumbnail with a progress indicator overlay
          return _getThumbnail(true, false);
        }

        // If the user has started the video and the videocontroller is ready:
        // I show the video
        return _getVideoPlayer();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCastConnected) {
      // If I'm connected, I don't need the full video player
      return _getThumbnail(false, true);
    }

    // If I'm not connected, I want to build and initialize the full video player
    return _getVideoPlayerBuilder();
  }
}
