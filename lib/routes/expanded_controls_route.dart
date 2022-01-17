import 'package:cast_videos_flutter/cast/cast_manager.dart';
import 'package:cast_videos_flutter/services/routing/my_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cast_framework/widgets.dart';
import 'package:provider/provider.dart';

void openExpandedControls(BuildContext context) {
  CastManager castManager = Provider.of<CastManager>(context, listen: false);
  castManager.isInExpandedControls = true;

  Navigator.of(context).push(
    createRoute(
      _ExpandedControlsRoute(),
    ),
  );
}

class _ExpandedControlsRoute extends StatelessWidget {
  const _ExpandedControlsRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CastManager castManager = Provider.of<CastManager>(context, listen: false);

    return Scaffold(
      body: ExpandedControls(
        castFramework: castManager.castFramework,
        onCloseRequested: () {
          Navigator.pop(context);
          castManager.isInExpandedControls = false;
        },
      ),
    );
  }
}
