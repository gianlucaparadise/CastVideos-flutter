import 'package:cast_videos_flutter/cast/media_load_request_data_helper.dart';
import 'package:cast_videos_flutter/models/category_descriptor.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cast_framework/cast.dart';

class CastManager extends ChangeNotifier {
  CastConnectionState _castConnectionState = CastConnectionState.NOT_CONNECTED;
  CastConnectionState get castConnectionState => _castConnectionState;

  late FlutterCastFramework castFramework;

  CastManager() {
    debugPrint("CastManager: constructed");
    castFramework = FlutterCastFramework.create([]);
    castFramework.castContext.sessionManager.state
        .addListener(_onSessionStateChanged);
  }

  void loadMedia(
    VideoDescriptor video,
    CategoryDescriptor category,
    int position,
    bool autoPlay,
  ) {
    MediaLoadRequestData request = getMediaLoadRequestData(
      video,
      category,
      position,
      autoPlay,
    );
    var remoteMediaClient =
        castFramework.castContext.sessionManager.remoteMediaClient;
    remoteMediaClient.load(request);
  }

  void _onSessionStateChanged() {
    var sessionState = castFramework.castContext.sessionManager.state.value;
    debugPrint("CastManager: sessionStateChanged: ${sessionState.toString()}");

    switch (sessionState) {
      case SessionState.start_failed:
      case SessionState.resume_failed:
      case SessionState.ended:
        _castConnectionState = CastConnectionState.NOT_CONNECTED;
        break;

      case SessionState.started:
      case SessionState.resumed:
        _castConnectionState = CastConnectionState.CONNECTED;
        break;

      case SessionState.idle:
      case SessionState.starting:
      case SessionState.ending:
      case SessionState.resuming:
      case SessionState.suspended:
        return;
    }

    notifyListeners();
  }
}

enum CastConnectionState {
  NOT_CONNECTED,
  CONNECTED,
}
