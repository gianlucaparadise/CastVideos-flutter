import 'package:cast_videos_flutter/cast/cast_manager.dart';
import 'package:cast_videos_flutter/routes/queue_list_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cast_framework/widgets.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  MyAppBar({
    this.title = "",
  });

  final String title;

  void _onQueueButtonPressed(BuildContext context) {
    openQueueList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CastManager>(
      builder: (context, castManager, child) {
        final isConnected =
            castManager.castConnectionState == CastConnectionState.CONNECTED;

        final queueButton = IconButton(
          onPressed: () => _onQueueButtonPressed(context),
          icon: Icon(
            Icons.playlist_play,
            color: Colors.white,
          ),
        );

        return AppBar(
          title: Text(this.title),
          actions: [
            isConnected ? queueButton : SizedBox.shrink(),
            CastButton(
              castFramework: castManager.castFramework,
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
