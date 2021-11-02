import 'package:cast_videos_flutter/cast/cast_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cast_framework/widgets.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  MyAppBar({
    this.title = "",
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    CastManager castManager = Provider.of<CastManager>(context, listen: false);
    return AppBar(
      title: Text(this.title),
      actions: [
        CastButton(
          castFramework: castManager.castFramework,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
