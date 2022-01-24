import 'package:cast_videos_flutter/routers/home_router.dart';
import 'package:cast_videos_flutter/routes/expanded_controls_route.dart';
import 'package:flutter/material.dart';

class RootRouter extends StatefulWidget {
  const RootRouter({Key? key}) : super(key: key);

  @override
  _RootRouterState createState() => _RootRouterState();
}

class _RootRouterState extends State<RootRouter> {
  Route _onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;

    return MaterialPageRoute(
      builder: (context) {
        switch (routeName) {
          case "/":
            return HomeRouter();

          case ExpandedControlsRoute.routeName:
            return const ExpandedControlsRoute();

          default:
            throw new UnimplementedError(
              'The route \'$routeName\' has not been implemented in RootRouter',
            );
        }
      },
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cast Videos Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _onGenerateRoute,
    );
  }
}
