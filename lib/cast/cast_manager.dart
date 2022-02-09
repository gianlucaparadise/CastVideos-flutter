import 'package:cast_videos_flutter/cast/media_load_request_data_helper.dart';
import 'package:cast_videos_flutter/models/category_descriptor.dart';
import 'package:cast_videos_flutter/models/video_descriptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cast_framework/cast.dart';

/// in seconds
const double QUEUE_PRELOAD_TIME = 20;

class CastManager extends ChangeNotifier {
  CastConnectionState _castConnectionState = CastConnectionState.NOT_CONNECTED;
  CastConnectionState get castConnectionState => _castConnectionState;

  PlayerState _playerState = PlayerState.idle;
  PlayerState get playerState => _playerState;

  late FlutterCastFramework castFramework;

  CastManager() {
    debugPrint("CastManager: constructed");
    castFramework = FlutterCastFramework.create([]);
    final sessionManager = castFramework.castContext.sessionManager;

    sessionManager.state.addListener(_onSessionStateChanged);
    sessionManager.remoteMediaClient.playerState
        .addListener(_onPlayerStateChanged);
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

  void queueAppendItem(VideoDescriptor video, CategoryDescriptor category) {
    MediaQueueItem item =
        getMediaQueueItem(video, category, QUEUE_PRELOAD_TIME, false);

    var remoteMediaClient =
        castFramework.castContext.sessionManager.remoteMediaClient;
    remoteMediaClient.queueAppendItem(item);
  }

  void _onSessionStateChanged() {
    var sessionState = castFramework.castContext.sessionManager.state.value;
    debugPrint("CastManager: sessionStateChanged: ${sessionState.toString()}");

    switch (sessionState) {
      case SessionState.start_failed:
      case SessionState.resume_failed:
      case SessionState.ended:
        _castConnectionState = CastConnectionState.NOT_CONNECTED;
        _playerState = PlayerState.idle;
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

  void _onPlayerStateChanged() {
    final sessionManager = castFramework.castContext.sessionManager;
    final playerState = sessionManager.remoteMediaClient.playerState.value;
    debugPrint("CastManager: playerStateChanged: ${playerState.toString()}");

    this._playerState = playerState;
    notifyListeners();
  }
}

enum CastConnectionState {
  NOT_CONNECTED,
  CONNECTED,
}
