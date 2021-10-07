import 'package:cast_videos_flutter/models/source_descriptor.dart';
import 'package:cast_videos_flutter/models/track_descriptor.dart';

class VideoDescriptor {
  String? subtitle;
  List<SourceDescriptor>? sources;
  String? thumb;
  String? image480x270;
  String? image780x1200;
  String? title;
  String? studio;
  int duration = 0;
  List<TrackDescriptor>? tracks;

  VideoDescriptor.fromJson(Map<String, dynamic> json) {
    subtitle = json['subtitle'];
    if (json['sources'] != null) {
      var jsonSources = <SourceDescriptor>[];
      json['sources'].forEach((v) {
        jsonSources.add(new SourceDescriptor.fromJson(v));
      });
      this.sources = jsonSources;
    }
    thumb = json['thumb'];
    image480x270 = json['image-480x270'];
    image780x1200 = json['image-780x1200'];
    title = json['title'];
    studio = json['studio'];
    duration = json['duration'];
    if (json['tracks'] != null) {
      var jsonTracks = <TrackDescriptor>[];
      json['tracks'].forEach((v) {
        jsonTracks.add(new TrackDescriptor.fromJson(v));
      });
      this.tracks = jsonTracks;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtitle'] = this.subtitle;
    data['sources'] = this.sources?.map((v) => v.toJson()).toList();
    data['thumb'] = this.thumb;
    data['image-480x270'] = this.image480x270;
    data['image-780x1200'] = this.image780x1200;
    data['title'] = this.title;
    data['studio'] = this.studio;
    data['duration'] = this.duration;
    data['tracks'] = this.tracks?.map((v) => v.toJson()).toList();
    return data;
  }
}
