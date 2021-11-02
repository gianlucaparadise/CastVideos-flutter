import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum VideoPlayerPopupMenuOptions {
  PlayNow,
  AddToQueue,
}

class VideoPlayerPopupMenuButton extends StatelessWidget {
  VideoPlayerPopupMenuButton({
    this.onPlayNow,
    this.onAddToQueue,
  });

  final VoidCallback? onPlayNow;
  final VoidCallback? onAddToQueue;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VideoPlayerPopupMenuOptions>(
      child: Icon(
        Icons.play_circle_filled,
        color: Colors.white,
        size: 80,
      ),
      onSelected: (value) {
        switch (value) {
          case VideoPlayerPopupMenuOptions.PlayNow:
            this.onPlayNow?.call();
            break;
          case VideoPlayerPopupMenuOptions.AddToQueue:
            this.onAddToQueue?.call();
            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: VideoPlayerPopupMenuOptions.PlayNow,
            child: Text('Play Now'),
          ),
          PopupMenuItem(
            value: VideoPlayerPopupMenuOptions.AddToQueue,
            child: Text('Add to Queue'),
          ),
        ];
      },
    );
  }
}
