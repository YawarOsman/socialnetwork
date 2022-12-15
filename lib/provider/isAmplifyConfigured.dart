import 'package:flutter/material.dart';

class IsAmplifyConfigured extends ChangeNotifier {
  bool _isAmplifyConfigured = false;

  bool get isAmplifyConfigured => _isAmplifyConfigured;

  set setIsAmplifyConfigured(bool isAmplifyConfigured) {
    _isAmplifyConfigured = isAmplifyConfigured;
    notifyListeners();
  }
}
