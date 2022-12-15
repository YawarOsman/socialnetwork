import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../submodels/classModels/enums.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  get isDark => _isDark;

  final ThemeData _lighTheme = ThemeData(
      splashColor: Colors.transparent,
      primaryColor: const Color.fromARGB(255, 116, 116, 116),
      focusColor: Colors.blue.shade600,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      cardColor: const Color.fromARGB(255, 244, 244, 244),
      colorScheme: ColorScheme.light(primary: Colors.blue.shade600)
          .copyWith(secondary: const Color.fromARGB(255, 62, 62, 62)));
  get lightTheme => _lighTheme;

  final ThemeData _darkTheme = ThemeData(
    splashColor: Colors.transparent,
    primaryColor: const Color.fromARGB(255, 125, 125, 125),
    focusColor: Colors.blue.shade600,
    scaffoldBackgroundColor: const Color.fromARGB(255, 24, 24, 24),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
    ),
    appBarTheme:
        const AppBarTheme(backgroundColor: Color.fromARGB(255, 24, 24, 24)),
    cardColor: const Color.fromARGB(255, 34, 34, 34),
    colorScheme: ColorScheme.dark(primary: Colors.blue.shade600).copyWith(
      secondary: const Color.fromARGB(255, 218, 218, 218),
    ),
  );
  get darkTheme => _darkTheme;

  get getIsDark async {
    final prefs = await SharedPreferences.getInstance();

    final String appTheme =
        json.decode(prefs.getString('appTheme').toString()) ?? 'AppTheme.system';
    switch (appTheme) {
      case 'AppTheme.light':
        _isDark = false;
        break;
      case 'AppTheme.dark':
        _isDark = true;
        break;
      default:
        _isDark = SchedulerBinding.instance.window.platformBrightness ==
            Brightness.dark;
    }
    notifyListeners();
    return appTheme;
  }

  void setIsDark(AppTheme appTheme) async {
    _isDark = appTheme == AppTheme.system
        ? SchedulerBinding.instance.window.platformBrightness == Brightness.dark
        : appTheme == AppTheme.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appTheme', json.encode(appTheme.toString()));
    getIsDark;
    notifyListeners();
  }
}
