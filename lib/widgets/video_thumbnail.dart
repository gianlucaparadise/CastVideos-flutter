import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoThumbnail extends StatelessWidget {
  VideoThumbnail({required this.video});

  final VideoDescriptor video;

  @override
  Widget build(BuildContext context) {
    final catalog = Provider.of<VideoCatalog?>(context, listen: false);
    final imagePrefix = catalog?.categories?.first.images;
    final imageUrl = "$imagePrefix" "${video.image480x270}";

    return AspectRatio(
      aspectRatio: 480.0 / 270.0,
      child: Hero(
        // FIXME: this tag should be unique, but right now it isn't. An ID property is missing in the original json. Should I generate one?
        tag: '${video.title}',
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: imageUrl,
        ),
      ),
    );
  }
}
