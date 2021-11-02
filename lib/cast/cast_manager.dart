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

  void _onSessionStateChanged() {
    var sessionState = castFramework.castContext.sessionManager.state.value;
    debugPrint("CastManager: sessionStateChanged: ${sessionState.toString()}");

    switch (sessionState) {
      case SessionState.session_start_failed:
      case SessionState.session_resume_failed:
      case SessionState.session_ended:
        _castConnectionState = CastConnectionState.NOT_CONNECTED;
        break;

      case SessionState.session_started:
      case SessionState.session_resumed:
        _castConnectionState = CastConnectionState.CONNECTED;
        break;

      case SessionState.idle:
      case SessionState.session_starting:
      case SessionState.session_ending:
      case SessionState.session_resuming:
      case SessionState.session_suspended:
        return;
    }

    notifyListeners();
  }
}

enum CastConnectionState {
  NOT_CONNECTED,
  CONNECTED,
}
