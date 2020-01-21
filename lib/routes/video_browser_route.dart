import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/services/connection_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoBrowserRoute extends StatelessWidget {
  VideoBrowserRoute({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: FutureBuilder<VideoCatalog>(
        future: ConnectionHandler.getCatalog(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // Return a centered Circular progress indicator
            return Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: <Widget>[
                  Text("${snapshot.error}"),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            );
          }

          debugPrint('Categories: ${snapshot.data.categories.length}');

          return ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.cast),
                title: Text('Video 1'),
              ),
              ListTile(
                leading: Icon(Icons.cast),
                title: Text('Video 2'),
              ),
              ListTile(
                leading: Icon(Icons.cast),
                title: Text('Video 3'),
              ),
            ],
          );
        },
      ),
    );
  }
}
