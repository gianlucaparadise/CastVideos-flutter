import 'package:cast_videos_flutter/routes/video_browser_route.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
