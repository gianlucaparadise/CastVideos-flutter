import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/routes/mini_controller_route.dart';
import 'package:cast_videos_flutter/services/connection_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cast/cast_manager.dart';
import 'routing.dart';

void main() => runApp(
      FutureProvider<VideoCatalog?>(
        create: (_) async => ConnectionHandler.getCatalog(),
        initialData: null,
        catchError: (context, error) {
          debugPrint("Error: $error");
          return null;
        },
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CastManager(),
        )
      ],
      child: Column(
        children: [
          Expanded(
            child: MaterialApp(
              title: 'Cast Videos Sample',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              onGenerateRoute: onGenerateRoute,
              initialRoute: initialRoute,
            ),
          ),
          MiniControllerRoute()
        ],
      ),
    );
  }
}
