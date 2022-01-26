import 'package:cast_videos_flutter/cast/cast_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cast_framework/widgets.dart';
import 'package:provider/provider.dart';

void openExpandedControls(BuildContext context) {
  Navigator.of(context, rootNavigator: true)
      .pushNamed(ExpandedControlsRoute.routeName);
}

class ExpandedControlsRoute extends StatelessWidget {
  static const routeName = "/ExpandedControls";

  const ExpandedControlsRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CastManager castManager = Provider.of<CastManager>(context, listen: false);

    return Scaffold(
      body: ExpandedControls(
        castFramework: castManager.castFramework,
        onCloseRequested: () => Navigator.pop(context),
      ),
    );
  }
}
