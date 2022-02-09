// import 'dart:convert';
import 'dart:convert';

import 'package:cast_videos_flutter/models/category_descriptor.dart';
import 'package:cast_videos_flutter/models/source_descriptor.dart';
import 'package:cast_videos_flutter/models/track_descriptor.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:flutter_cast_framework/cast.dart';

const TAG_HLS = 'hls';
const TAG_DASH = "dash";
const TAG_MP4 = "mp4";
const TAG_IMAGES = "images";
const TAG_TRACKS = "tracks";

const TARGET_FORMAT = TAG_HLS;
const KEY_DESCRIPTION = 'description';

MediaLoadRequestData getMediaLoadRequestData(
  VideoDescriptor video,
  CategoryDescriptor category,
  int position,
  bool autoPlay,
) {
  final mediaInfo = getMediaInfo(video, category);

  return MediaLoadRequestData()
    ..mediaInfo = mediaInfo
    ..currentTime = position
    ..shouldAutoplay = autoPlay;
}

String? getPrefix(CategoryDescriptor category, String type) {
  switch (type) {
    case TAG_HLS:
      return category.hls;
    case TAG_DASH:
      return category.dash;
    case TAG_MP4:
      return category.mp4;
    case TAG_IMAGES:
      return category.images;
    case TAG_TRACKS:
      return category.tracks;
    default:
      throw new ArgumentError.value(type);
  }
}

MediaInfo getMediaInfo(VideoDescriptor video, CategoryDescriptor category) {
  final videoSpecs = video.sources;
  if (videoSpecs == null || videoSpecs.length <= 0) {
    return MediaInfo();
  }

  final videoSpec = videoSpecs.firstWhere(
    (source) => source.type == TARGET_FORMAT,
    orElse: () => SourceDescriptor.fromJson({}),
  );
  final videoPrefix = getPrefix(category, TARGET_FORMAT);
  final videoUrl = "$videoPrefix${videoSpec.url}";

  final movieMetadata = getMediaMetadata(video, category);
  final mediaTracks = getMediaTracks(video, category);

  final customData = {
    KEY_DESCRIPTION: video.subtitle,
  };
  final jsonCustomData = jsonEncode(customData);

  return MediaInfo()
    ..contentId = videoUrl
    ..streamType = StreamType.buffered
    ..contentType = videoSpec.type
    ..mediaMetadata = movieMetadata
    ..mediaTracks = mediaTracks
    ..streamDuration = video.duration * 1000
    ..customDataAsJson = jsonCustomData;
}

MediaMetadata getMediaMetadata(
  VideoDescriptor video,
  CategoryDescriptor category,
) {
  MediaMetadata movieMetadata = MediaMetadata();
  movieMetadata.mediaType = MediaType.movie;

  // movieMetadata.strings = {
  // This can't be uncommented because of https://github.com/flutter/flutter/issues/93464
  // MediaMetadataKey.subtitle: video.studio,
  // MediaMetadataKey.title: video.title,
  // };

  final imagesPrefix = getPrefix(category, TAG_IMAGES);
  final img = WebImage()..url = "$imagesPrefix${video.image480x270}";
  final bigImg = WebImage()..url = "$imagesPrefix${video.image780x1200}";
  movieMetadata.webImages = [
    img,
    bigImg,
  ];

  return movieMetadata;
}

List<MediaTrack?>? getMediaTracks(
  VideoDescriptor video,
  CategoryDescriptor category,
) {
  final tracks = video.tracks;
  if (tracks == null) return null;

  final trackPrefix = getPrefix(category, TAG_TRACKS);
  final result =
      tracks.map((track) => getMediaTrack(track, trackPrefix)).toList();
  return result;
}

MediaTrack? getMediaTrack(TrackDescriptor track, String? trackPrefix) {
  int? trackId = int.tryParse(track.id ?? "");

  TrackType trackType = TrackType.unknown;
  switch (track.type) {
    case "text":
      trackType = TrackType.text;
      break;
    case "video":
      trackType = TrackType.video;
      break;
    case "audio":
      trackType = TrackType.audio;
      break;
  }

  TrackSubtype trackSubtype = TrackSubtype.none;
  switch (track.subtype) {
    case "captions":
      trackSubtype = TrackSubtype.captions;
      break;
    case "subtitle":
      trackSubtype = TrackSubtype.subtitles;
      break;
  }

  return MediaTrack()
    ..id = trackId
    ..trackType = trackType
    ..name = track.name
    ..trackSubtype = trackSubtype
    ..contentId = "$trackPrefix${track.contentId}"
    ..language = track.language;
}

MediaQueueItem getMediaQueueItem(
  VideoDescriptor video,
  CategoryDescriptor category,
  double preloadTime,
  bool autoPlay,
) {
  final mediaInfo = getMediaInfo(video, category);

  return MediaQueueItem()
    ..media = mediaInfo
    ..autoplay = autoPlay
    ..preloadTime = preloadTime;
}
