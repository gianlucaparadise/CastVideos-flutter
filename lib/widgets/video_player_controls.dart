import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControls extends StatelessWidget {
  VideoPlayerControls({
    Key key,
    @required this.controller,
    @required this.onPlayButtonTap,
  }) : super(key: key);

  final VideoPlayerController controller;
  final VoidCallback onPlayButtonTap;

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
    if (controller.value.isPlaying) {
      icon = Icons.pause;
    } else {
      icon = Icons.play_arrow;
    }

    return IconButton(
      icon: Icon(icon),
      color: Colors.white,
      onPressed: this.onPlayButtonTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    var total = controller.value.duration;

    return Container(
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
              _positionToString(controller.value.position, total),
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: VideoProgressIndicator(
                controller,
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
  }
}
