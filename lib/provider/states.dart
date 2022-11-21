import 'package:flutter/material.dart';

import '../pages/roomScreen.dart';

class States extends ChangeNotifier {
  bool _isRoomPageMinimized = false;
  bool _isRoomOpened = false;
  late RoomScreen _roomInstance;

  bool get isRoomPageMinimized => _isRoomPageMinimized;
  bool get isRoomOpened => _isRoomOpened;
  RoomScreen get roomInstance => _roomInstance;

  set setIsRoomPageMinimized(bool value) {
    _isRoomPageMinimized = value;
    notifyListeners();
  }

  set setIsRoomOpened(bool value) {
    _isRoomOpened = value;
    notifyListeners();
  }

  set setRoomInstance(RoomScreen value) {
    _roomInstance = value;
    notifyListeners();
  }
}
