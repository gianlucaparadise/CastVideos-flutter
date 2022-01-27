import 'package:cast_videos_flutter/cast/cast_manager.dart';
import 'package:cast_videos_flutter/routes/expanded_controls_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cast_framework/cast.dart';
import 'package:flutter_cast_framework/widgets.dart';
import 'package:provider/provider.dart';

/// I know currently this is not a route, but this can become it
class MiniControllerRoute extends StatelessWidget {
  const MiniControllerRoute({Key? key}) : super(key: key);

  bool isPlayerVisibleForState(CastManager castManager) {
    switch (castManager.playerState) {
      case PlayerState.buffering:
      case PlayerState.loading:
      case PlayerState.paused:
      case PlayerState.playing:
        return true;
      case PlayerState.idle:
      case PlayerState.unknown:
        return false;
      default:
        return false;
    }
  }

  void _onMiniControllerTapped(BuildContext context) {
    openExpandedControls(context);
  }

  Widget _getPlayer(BuildContext context, CastManager castManager) {
    bool isPlayerVisible = isPlayerVisibleForState(castManager);
    if (!isPlayerVisible) return SizedBox.shrink();

    return SafeArea(
      top: false,
      child: MiniController(
        castFramework: castManager.castFramework,
        onControllerTapped: () => _onMiniControllerTapped(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CastManager>(
      builder: (context, castManager, child) {
        return _getPlayer(context, castManager);
      },
    );
  }
}
