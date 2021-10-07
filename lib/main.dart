import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/routes/video_browser_route.dart';
import 'package:cast_videos_flutter/services/connection_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return MaterialApp(
      title: 'Cast Videos Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoBrowserRoute(title: 'Cast Videos Sample'),
    );
  }
}
