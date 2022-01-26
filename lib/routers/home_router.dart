import 'package:cast_videos_flutter/routes/mini_controller_route.dart';
import 'package:cast_videos_flutter/routes/video_browser_route.dart';
import 'package:cast_videos_flutter/routes/video_detail_route.dart';
import 'package:flutter/material.dart';

class HomeRouter extends StatefulWidget {
  const HomeRouter({Key? key}) : super(key: key);

  @override
  State<HomeRouter> createState() => _HomeRouterState();
}

class _HomeRouterState extends State<HomeRouter> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  Route _onGenerateRoute(RouteSettings settings) {
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

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Navigator(
              key: _navigatorKey,
              onGenerateRoute: _onGenerateRoute,
            ),
          ),
          MiniControllerRoute()
        ],
      ),
    );
  }
}
