import 'package:flutter/material.dart';
import 'package:flutter_cast_framework/widgets.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  MyAppBar({
    this.title = "",
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
      actions: [
        CastButton(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
