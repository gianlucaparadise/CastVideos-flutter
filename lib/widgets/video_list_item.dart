import 'package:cast_videos_flutter/cast/cast_manager.dart';
import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:cast_videos_flutter/routes/expanded_controls_route.dart';
import 'package:cast_videos_flutter/widgets/video_heading.dart';
import 'package:cast_videos_flutter/widgets/video_player_popup_menu_button.dart';
import 'package:cast_videos_flutter/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoListItem extends StatelessWidget {
  VideoListItem({required this.video});

  final VideoDescriptor video;

  void _onPlayNowToCast(BuildContext context, CastManager castManager) {
    final catalog = Provider.of<VideoCatalog?>(context, listen: false);
    final categories = catalog?.categories;
    if (categories == null || categories.isEmpty) {
      debugPrint("missing catalog categories, cannot load media");
      return;
    }

    final category = categories.first;
    castManager.loadMedia(this.video, category, 0, true);

    openExpandedControls(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CastManager>(
      builder: (context, castManager, child) {
        final isCastConnected =
            castManager.castConnectionState == CastConnectionState.CONNECTED;
        final moreMenuButton = MorePlayerPopupMenuButton(
          onPlayNow: () => _onPlayNowToCast(context, castManager),
        );

        return Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: VideoThumbnail(
                video: video,
              ),
            ),
            Container(width: 10), // this is a spacer
            Expanded(
              flex: 1,
              child: VideoHeading(
                video: video,
              ),
            ),
            isCastConnected ? moreMenuButton : SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
