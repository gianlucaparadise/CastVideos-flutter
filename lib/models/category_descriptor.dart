import 'package:cast_videos_flutter/models/video_descriptor.dart';

class CategoryDescriptor {
  String name;
  String hls;
  String dash;
  String mp4;
  String images;
  String tracks;
  List<VideoDescriptor> videos;

  CategoryDescriptor(
      {this.name,
      this.hls,
      this.dash,
      this.mp4,
      this.images,
      this.tracks,
      this.videos});

  CategoryDescriptor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hls = json['hls'];
    dash = json['dash'];
    mp4 = json['mp4'];
    images = json['images'];
    tracks = json['tracks'];
    if (json['videos'] != null) {
      videos = new List<VideoDescriptor>();
      json['videos'].forEach((v) {
        videos.add(new VideoDescriptor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['hls'] = this.hls;
    data['dash'] = this.dash;
    data['mp4'] = this.mp4;
    data['images'] = this.images;
    data['tracks'] = this.tracks;
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
