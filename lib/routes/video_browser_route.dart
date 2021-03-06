import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/routes/video_detail_route.dart';
import 'package:provider/provider.dart';
import 'package:cast_videos_flutter/services/routing/my_page_route.dart';
import 'package:cast_videos_flutter/widgets/video_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoBrowserRoute extends StatelessWidget {
  VideoBrowserRoute({Key key, this.title}) : super(key: key);

  final String title;

  _onVideoSelected(BuildContext context, VideoDescriptor video) {
    Navigator.of(context).push(
      createRoute(
        VideoDetailRoute(
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
      body: Consumer<VideoCatalog>(
        builder: (context, catalog, widget) {
          if (catalog == null) {
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

          // if (snapshot.hasError) {
          //   return Center(
          //     child: Column(
          //       children: <Widget>[
          //         Text("${snapshot.error}"),
          //       ],
          //       mainAxisAlignment: MainAxisAlignment.center,
          //     ),
          //   );
          // }

          return VideoList(
            onVideoSelected: (video) => _onVideoSelected(
              context,
              video,
            ),
          );
        },
      ),
    );
  }
}
