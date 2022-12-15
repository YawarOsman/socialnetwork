import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Log extends ChangeNotifier {
  bool _isLoggedIn = false;
  final _deviceType = TargetPlatform.iOS;
  int _selectedTab = 2;
  int _themeModeIndex = 2;
  bool _isFirstTime = true;
  bool _isRoomActive = false;
  bool _isRoomPageMinimized = false;

  get themeModeIndex => _themeModeIndex;
  get isLoggedIn => _isLoggedIn;

  get isFirstTime => _isFirstTime;

  get getThemeModeIndex async {
    final prefs = await SharedPreferences.getInstance();
    _themeModeIndex = prefs.getInt('themeModeIndex') ?? 2;
    notifyListeners();
    return _themeModeIndex;
  }

  get getIsLoggedIn async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
    return _isLoggedIn;
  }

  get deviceType => _deviceType;

  get selectedTab => _selectedTab;

  get isRoomActive => _isRoomActive;

  get getIsFirstTime async {
    final prefs = await SharedPreferences.getInstance();
    _isFirstTime = prefs.getBool('isFirstTime') ?? false;
    notifyListeners();
    return _isFirstTime;
  }

  bool get isRoomPageMinimized => _isRoomPageMinimized;

  void setIsLoggedIn(bool loggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', loggedIn);
    _isLoggedIn = loggedIn;
    notifyListeners();
  }

  set setSelectedTab(int selectedTab) {
    _selectedTab = selectedTab;
    notifyListeners();
  }

  void setThemeModeIndex(int themeModeIndex) async {
    _themeModeIndex = themeModeIndex;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeModeIndex', themeModeIndex);
    notifyListeners();
  }

  set setAmplifyConfigured(bool amplifyConfigured) {
    notifyListeners();
  }

  void setIsFirstTime(bool isFirstTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', isFirstTime);
    _isFirstTime = isFirstTime;
    notifyListeners();
  }

  set setIsRoomActive(bool isRoomActive) {
    _isRoomActive = isRoomActive;
    notifyListeners();
  }

  set setIsRoomPageMinimized(bool value) {
    _isRoomPageMinimized = value;
    notifyListeners();
  }
}
