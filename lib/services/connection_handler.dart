import 'package:cast_videos_flutter/models/video_catalog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConnectionHandler {
  static const String _CATALOG_URL =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/CastVideos/f.json';

  static Future<VideoCatalog> getCatalog() async {
    final response = await http.get(_CATALOG_URL);

    if (response.statusCode == 200) {
      return VideoCatalog.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load video catalog');
    }
  }
}
