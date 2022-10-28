import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Log extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isDark = false;
  final _deviceType = TargetPlatform.iOS;
  int _selectedTab = 4;
  bool _amplifyConfigured = false;
  int? _themeModeIndex = 1;
  bool _isFirstTime = true;
  bool _iisRoomActive = false;

  get themeModeIndex => _themeModeIndex;
  get isAmplifyConfigured => _amplifyConfigured;
  get isLoggedIn => _isLoggedIn;

  get isDark => _isDark;
  get isFirstTime => _isFirstTime;

  get getIsDark async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool('isDark') ?? false;
    notifyListeners();
    return _isDark;
  }

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

  get deviceType {
    return _deviceType;
  }

  get selectedTab {
    return _selectedTab;
  }

  get isRoomActive => _iisRoomActive;

  get getIsFirstTime async {
    final prefs = await SharedPreferences.getInstance();
    _isFirstTime = prefs.getBool('isFirstTime') ?? false;
    notifyListeners();
    return _isFirstTime;
  }

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

  void setIsDark(bool isDark) async {
    _isDark = isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
    getIsDark;
    notifyListeners();
  }

  void setThemeModeIndex(int themeModeIndex) async {
    _themeModeIndex = themeModeIndex;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeModeIndex', themeModeIndex);
    notifyListeners();
  }

  set setAmplifyConfigured(bool amplifyConfigured) {
    _amplifyConfigured = amplifyConfigured;
    notifyListeners();
  }

  void setIsFirstTime(bool isFirstTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', isFirstTime);
    _isFirstTime = isFirstTime;
    notifyListeners();
  }

  set setIsRoomActive(bool isRoomActive) {
    _iisRoomActive = isRoomActive;
    notifyListeners();
  }
}
