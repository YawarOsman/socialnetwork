import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

import '../pages/roomScreen.dart';

class RoomStates extends ChangeNotifier {
  RoomScreen? _roomInstance;
  Room? _videoSDK;

  RoomScreen? get roomInstance => _roomInstance;
  Room? get videoSDK => _videoSDK;

  set setRoomInstance(RoomScreen? value) {
    _roomInstance = value;
    notifyListeners();
  }

  set setVideoSDK(Room? value) {
    _videoSDK = value;
    notifyListeners();
  }
}
