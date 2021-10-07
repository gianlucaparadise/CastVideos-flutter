import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControls extends StatefulWidget {
  VideoPlayerControls({
    Key? key,
    required this.videoPlayerController,
    required this.controller,
    required this.onPlayButtonTap,
  }) : super(key: key);

  final VideoPlayerController videoPlayerController;
  final VideoPlayerControlsController controller;
  final VoidCallback onPlayButtonTap;

  @override
  State<VideoPlayerControls> createState() => _VideoPlayerControlsState();
}

class VideoPlayerControlsController extends ChangeNotifier {
  bool isVisible = true;

  void showControls() {
    this.isVisible = true;
    notifyListeners();
  }

  void hideControls() {
    this.isVisible = false;
    notifyListeners();
  }
}

class _VideoPlayerControlsState extends State<VideoPlayerControls> {
  bool _visible = true;
  Timer? _timer;

  @override
  void initState() {
    widget.controller.addListener(() {
      _setVisibility(widget.controller.isVisible);
    });

    _setVisibility(true);

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  void _setVisibility(bool isVisible) {
    if (isVisible) {
      setState(() {
        _visible = true;
        _waitAndHide();
      });
    } else if (!isVisible) {
      setState(() {
        _visible = false;
      });
    }
  }

  void _waitAndHide() {
    // If it's already hidden, I don't do anything
    if (!_visible) return;

    _timer?.cancel();
    _timer = Timer(
      Duration(milliseconds: 5000),
      () {
        if (!mounted) return;
        setState(() {
          debugPrint("videocontrol: Hiding");
          _visible = false;
        });
      },
    );
  }

  String _positionToString(Duration d, Duration total) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    if (total.inMinutes <= 60) {
      // This is less than a hour, I display only minutes and seconds
      return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}";
    }

    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  Widget get _playPauseButton {
    IconData icon;
    if (widget.videoPlayerController.value.isPlaying) {
      icon = Icons.pause;
    } else {
      icon = Icons.play_arrow;
    }

    return IconButton(
      icon: Icon(icon),
      color: Colors.white,
      onPressed: this.widget.onPlayButtonTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    var total = widget.videoPlayerController.value.duration;

    var controls = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withAlpha(0),
            Colors.black26,
            Colors.black38,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _playPauseButton,
            Text(
              _positionToString(
                  widget.videoPlayerController.value.position, total),
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: VideoProgressIndicator(
                widget.videoPlayerController,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                allowScrubbing: true,
                colors: VideoProgressColors(
                  playedColor: Colors.blue,
                ),
              ),
            ),
            Text(
              _positionToString(total, total),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );

    if (_visible) {
      return controls;
    } else {
      return AnimatedOpacity(
        duration: Duration(milliseconds: 1000),
        opacity: _visible ? 1.0 : 0.0,
        child: controls,
      );
    }
  }
}
