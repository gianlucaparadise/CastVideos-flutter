import 'package:flutter/material.dart';

class MyPageRoute<T> extends MaterialPageRoute<T> {
  MyPageRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
