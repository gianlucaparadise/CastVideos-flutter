import 'package:cast_videos_flutter/routes/expanded_controls_route.dart';
import 'package:cast_videos_flutter/routes/video_browser_route.dart';
import 'package:cast_videos_flutter/routes/video_detail_route.dart';
import 'package:flutter/material.dart';

const initialRoute = VideoBrowserRoute.routeName;

final Route<dynamic> Function(RouteSettings) onGenerateRoute = (settings) {
  final routeName = settings.name;

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      switch (routeName) {
        case '/':
        case VideoBrowserRoute.routeName:
          return const VideoBrowserRoute();

        case VideoDetailRoute.routeName:
          final args = settings.arguments as VideoDetailRouteArguments;
          return VideoDetailRoute(args);

        case ExpandedControlsRoute.routeName:
          return const ExpandedControlsRoute();

        default:
          throw new UnimplementedError(
            'The route \'$routeName\' has not been implemented',
          );
      }
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = 0.0;
      var end = 1.0;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
  );
};
