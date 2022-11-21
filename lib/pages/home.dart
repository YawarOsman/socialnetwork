import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialnetwork/pages/roomScreen.dart';
import 'dart:developer' as dev;
import '../helper/audiocall/api.dart';
import '../helper/con.dart';
import '../helper/helper.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../provider/states.dart';
import '../submodels/bottomBar/mainBottonTabbar.dart';
import '../widgets/minimizedRoomPage.dart';
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

  List _list = [];
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    getUserData();
    getRooms();
    _connectivity.initialise(context);
    _connectivity.myStream.listen((source) {
      if (mounted) setState(() => _source = source);
    });
    super.initState();
    _list = [
      // Center with a Text widget in 4 orders
      const Scaffold(
        body: Center(
          child: Text('classes'),
        ),
      ),
      const Scaffold(
        body: Center(
          child: Text('events'),
        ),
      ),
      const MainPage(),
      const Scaffold(
        body: Center(
          child: Text('alerts'),
        ),
      ),
      const MainPage(),
    ];
  }

  void getRooms() async {
    try {
      final rooms = await helper.getOpenedRooms(token);
      if (rooms != null) {
        if (mounted) setState(() {});
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
      await context.read<Data>().getEmail;
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

    return Consumer2<Log, States>(
        builder: ((context, log, states, child) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Scaffold(
                  bottomNavigationBar: BottomBar(),
                  body: Stack(alignment: Alignment.bottomCenter, children: [
                    _list.elementAt(log.selectedTab),
                    (states.isRoomPageMinimized && states.isRoomOpened)
                        ? MinimizedRoomPage()
                        : SizedBox(),
                  ]),
                ),
                states.isRoomOpened
                    ? AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        height: states.isRoomPageMinimized
                            ? 0
                            : _sheight -
                                MediaQueryData.fromWindow(
                                        WidgetsBinding.instance.window)
                                    .padding
                                    .top,
                        width: double.infinity,
                        child: states.roomInstance)
                    : SizedBox()
              ],
            )));
  }
}
