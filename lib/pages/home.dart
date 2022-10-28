import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;
import '../helper/audiocall/api.dart';
import '../helper/con.dart';
import '../helper/helper.dart';
import '../models/Users.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../submodels/bottomBar/mainBottonTabbar.dart';
import 'mainPage.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MediaQueryData _mediaQueryData;
  Helper helper = Helper();
  late double _swidth;
  late double _sheight;
  bool _roomSelected = true;
  Map rooms = {};

  List _list = [
    // Center with a Text widget in 4 orders
    Scaffold(
      body: Center(
        child: Text('classes'),
      ),
    ),
    Scaffold(
      body: Center(
        child: Text('events'),
      ),
    ),
    MainPage(),
    Scaffold(
      body: Center(
        child: Text('alerts'),
      ),
    ),
    MainPage(),
  ];
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    getUserData();
    getRooms();
    _connectivity.initialise(context);
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
    super.initState();
  }

  void getRooms() async {
    try {
      final rooms = await helper.getOpenedRooms(token);
      if (rooms != null) {
        setState(() {});
        List dataper = rooms['data'];
        List data = [];
        data.addAll(dataper);
        List roomId = [];
        int i = 0;
        data.forEach((element) {
          if (element['disabled'] == false) {
            roomId.add(element['roomId']);
          } else {
            dataper.removeAt(i);
          }
          i++;
        });

        Provider.of<Data>(context, listen: false).setRooms(dataper);

        debugPrint(roomId.toString());
        this.rooms = rooms;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getUserData() async {
    try {
      final email = await context.read<Data>().getEmail;
      await context
          .read<Data>()
          .getUserData
// //todo

          .then((value) async => await context.read<Data>().setProfileImage());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _swidth = _mediaQueryData.size.width;
    _sheight = _mediaQueryData.size.height;

    return Consumer<Log>(
        builder: ((context, consumer, child) => Scaffold(
              bottomSheet: BottomBar(),
              body: _list.elementAt(consumer.selectedTab),
            )));
  }
}
