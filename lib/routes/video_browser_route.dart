import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/routes/%20video_detail_route.dart';
import 'package:cast_videos_flutter/services/connection_handler.dart';
import 'package:cast_videos_flutter/services/routing/my_page_route.dart';
import 'package:cast_videos_flutter/widgets/video_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoBrowserRoute extends StatelessWidget {
  VideoBrowserRoute({Key key, this.title}) : super(key: key);

  final String title;

  _onVideoSelected(
      BuildContext context, VideoCatalog catalog, VideoDescriptor video) {
    Navigator.push(
      context,
      MyPageRoute(
        builder: (context) => VideoDetailRoute(
          videoCatalog: catalog,
          video: video,
        ),
      ),
    );
  }

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

          final catalog = snapshot.data;

          return VideoList(
            videoCatalog: catalog,
            onVideoSelected: (video) => _onVideoSelected(
              context,
              catalog,
              video,
            ),
          );
        },
      ),
    );
  }
}
