import 'package:cast_videos_flutter/models/source_descriptor.dart';
import 'package:cast_videos_flutter/models/track_descriptor.dart';

class VideoDescriptor {
  String subtitle;
  List<SourceDescriptor> sources;
  String thumb;
  String image480x270;
  String image780x1200;
  String title;
  String studio;
  int duration;
  List<TrackDescriptor> tracks;

  VideoDescriptor(
      {this.subtitle,
      this.sources,
      this.thumb,
      this.image480x270,
      this.image780x1200,
      this.title,
      this.studio,
      this.duration,
      this.tracks});

  VideoDescriptor.fromJson(Map<String, dynamic> json) {
    subtitle = json['subtitle'];
    if (json['sources'] != null) {
      sources = new List<SourceDescriptor>();
      json['sources'].forEach((v) {
        sources.add(new SourceDescriptor.fromJson(v));
      });
    }
    thumb = json['thumb'];
    image480x270 = json['image-480x270'];
    image780x1200 = json['image-780x1200'];
    title = json['title'];
    studio = json['studio'];
    duration = json['duration'];
    if (json['tracks'] != null) {
      tracks = new List<TrackDescriptor>();
      json['tracks'].forEach((v) {
        tracks.add(new TrackDescriptor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtitle'] = this.subtitle;
    if (this.sources != null) {
      data['sources'] = this.sources.map((v) => v.toJson()).toList();
    }
    data['thumb'] = this.thumb;
    data['image-480x270'] = this.image480x270;
    data['image-780x1200'] = this.image780x1200;
    data['title'] = this.title;
    data['studio'] = this.studio;
    data['duration'] = this.duration;
    if (this.tracks != null) {
      data['tracks'] = this.tracks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
