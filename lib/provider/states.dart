import 'package:flutter/material.dart';

import '../pages/roomScreen.dart';

class States extends ChangeNotifier {
  bool _isRoomPageMinimized = false;
  RoomScreen? _roomInstance;
  bool _roomLeaved = false;

  bool get isRoomPageMinimized => _isRoomPageMinimized;
  RoomScreen? get roomInstance => _roomInstance;
  bool get roomLeaved => _roomLeaved;

  set setIsRoomPageMinimized(bool value) {
    _isRoomPageMinimized = value;
    notifyListeners();
  }

  set setRoomInstance(RoomScreen? value) {
    _roomInstance = value;
    notifyListeners();
  }

  set setRoomLeaved(bool value) {
    _roomLeaved = value;
    notifyListeners();
  }
}
