
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/con.dart';
import '../provider/log.dart';
import '../provider/roomStates.dart';
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

  List _list = [];
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise(context);

    _list = [
      const Scaffold(
        body: Center(
          child: Text('alerts'),
        ),
      ),
      const MainPage(),
      const MainPage(),
    ];
  }
  

 

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.red),
      child: Scaffold(
        body: Consumer2<Log, RoomStates>(
            builder: ((context, log, roomStates, child) => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Scaffold(
                      bottomNavigationBar: const BottomBar(),
                      body: Stack(alignment: Alignment.bottomCenter, children: [
                        _list.elementAt(log.selectedTab),
                        (log.isRoomPageMinimized && log.isRoomActive)
                            ? const MinimizedRoomPage()
                            : const SizedBox(),
                      ]),
                    ),
                    log.isRoomActive
                        ? AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            height: log.isRoomPageMinimized
                                ? 0
                                : MediaQuery.of(context).size.height -
                                    MediaQueryData.fromWindow(
                                            WidgetsBinding.instance.window)
                                        .padding
                                        .top,
                            width: double.infinity,
                            child: roomStates.roomInstance)
                        : const SizedBox()
                  ],
                ))),
      ),
    );
  }
}
