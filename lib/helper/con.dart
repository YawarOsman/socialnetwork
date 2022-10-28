import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../widgets/reusableWidgets.dart';

class MyConnectivity {
  bool isFirsttime = true;
  ReusableWidgets reusableWidgets = ReusableWidgets();

  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise(BuildContext context) async {
    ConnectivityResult res = await connectivity.checkConnectivity();
    _checkStatus(res);

    bool ftime = true;
    connectivity.onConnectivityChanged.listen((result) {
      if ((result != ConnectivityResult.none) && isFirsttime) {
        isFirsttime = false;
        return;
      }
      if ((result == ConnectivityResult.none) &&
          isFirsttime &&
          Platform.isIOS) {
        isFirsttime = false;
        return;
      }
      if (result != ConnectivityResult.none && ftime && Platform.isIOS) {
        ftime = false;
        return;
      }
      String message = '';

      if (result == ConnectivityResult.none) {
        message = 'No Internet Connection';
      } else if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        message = 'Internet Connection Available';
      }
      reusableWidgets.showSnackBarForConnectivity(context, message);
      _checkStatus(result);
    });

    if (res == ConnectivityResult.none && !Platform.isIOS) {
      reusableWidgets.showSnackBarForConnectivity(
          context, 'No Internet Connection');

      isFirsttime = false;
      return;
    }
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}
