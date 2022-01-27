import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum VideoPlayerPopupMenuOptions {
  PlayNow,
  AddToQueue,
}

class VideoPlayerPopupMenuButton extends StatelessWidget {
  const VideoPlayerPopupMenuButton({
    this.onPlayNow,
    this.onAddToQueue,
  });

  final VoidCallback? onPlayNow;
  final VoidCallback? onAddToQueue;

  @override
  Widget build(BuildContext context) {
    return _PlayQueuePopupMenuButton(
      icon: Icon(
        Icons.play_circle_filled,
        color: Colors.white,
        size: 80,
      ),
      onPlayNow: this.onPlayNow,
      onAddToQueue: this.onAddToQueue,
    );
  }
}

class MorePlayerPopupMenuButton extends StatelessWidget {
  const MorePlayerPopupMenuButton({
    this.onPlayNow,
    this.onAddToQueue,
  });

  final VoidCallback? onPlayNow;
  final VoidCallback? onAddToQueue;

  @override
  Widget build(BuildContext context) {
    return _PlayQueuePopupMenuButton(
      icon: Icon(Icons.more_vert),
      onPlayNow: this.onPlayNow,
      onAddToQueue: this.onAddToQueue,
    );
  }
}

class _PlayQueuePopupMenuButton extends StatelessWidget {
  const _PlayQueuePopupMenuButton({
    required this.icon,
    this.onPlayNow,
    this.onAddToQueue,
  });

  final Widget icon;
  final VoidCallback? onPlayNow;
  final VoidCallback? onAddToQueue;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VideoPlayerPopupMenuOptions>(
      child: this.icon,
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
