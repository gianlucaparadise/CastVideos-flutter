import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlayButton extends StatefulWidget {
  PlayButton({
    @required this.isPlaying,
    this.onTap,
  });

  final VoidCallback onTap;
  final bool isPlaying;

  @override
  State<StatefulWidget> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool _visible = true;

  void _waitAndHide() {
    // If it's already hidden, I don't do anything
    if (!_visible) return;

    Future.delayed(
      Duration(milliseconds: 2000),
      () {
        setState(() {
          debugPrint("playbutton: Hiding button");
          _visible = false;
        });
      },
    );
  }

  Widget _getIcon() {
    if (widget.isPlaying) {
      return Icon(Icons.pause_circle_filled);
    } else {
      // If the video is paused, play it.
      return Icon(Icons.play_circle_filled);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("playbutton: build");

    var button = IconButton(
      iconSize: 80,
      onPressed: widget.onTap,
      icon: _getIcon(),
    );

    if (widget.isPlaying) {
      _waitAndHide();

      return AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: _visible ? 1.0 : 0.0,
        child: button,
      );
    } else {
      _visible = true;
      return button;
    }
  }
}
