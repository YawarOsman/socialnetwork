import 'dart:convert';
import 'dart:developer' as logDev;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:videosdk/videosdk.dart';
import '../main.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../provider/states.dart';
import '../submodels/appBars/mainAppBar.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;

import 'roomScreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MediaQueryData _mediaQueryData;
  late double _swidth;
  late double _sheight;
  bool _roomSelected = true;
  final token = dotenv.env['TOKEN']!;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _swidth = _mediaQueryData.size.width;
    _sheight = _mediaQueryData.size.height;

    return Consumer2<Data, Log>(
      builder: (context, data, log, child) => Scaffold(
          key: _scaffoldKey,
          drawer: const Profile(),
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 47),
            child: MainAppBar(theme: Theme.of(context)),
          ),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: Column(children: [
              // Rooms and Learning tabs
              Padding(
                padding: const EdgeInsets.only(
                    left: 13, right: 13, top: 8, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // _roomSelected = true;
                        // setState(() {});
                        // const url1 =
                        //     'https://api.videosdk.live/v2/sessions/?roomId=a930-oqzm-mapv';
                        // final http.Response response1 = await http.get(
                        //     Uri.parse(url1),
                        //     headers: {'Authorization': token});
                        // logDev.log(
                        //     '___++_+__+_+_+++_+_+_++_: ${jsonDecode(response1.body)['data'][0]['participants'].length}');
                      },
                      child: Opacity(
                        opacity: _roomSelected ? 1 : 0.9,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            alignment: Alignment.center,
                            width: _swidth / 2 - 20,
                            height: 30,
                            decoration: BoxDecoration(
                                color: _roomSelected
                                    ? Colors.green.shade600
                                    : Colors.green.shade200,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'Rooms',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: _roomSelected
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _roomSelected = false;
                        setState(() {});
                      },
                      child: Opacity(
                        opacity: _roomSelected ? 0.9 : 1,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            alignment: Alignment.center,
                            width: _swidth / 2 - 20,
                            height: 30,
                            decoration: BoxDecoration(
                                color: _roomSelected
                                    ? Colors.green.shade200
                                    : Colors.green.shade600,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'Learning',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: _roomSelected
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Rooms
              Expanded(
                child: data.rooms.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.rooms.length - 1,
                        itemBuilder: (context, index) =>
                            roomCard(data, index, context, log),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).iconTheme.color,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor)),
              )
            ]),
          )),
    );
  }

  Widget roomCard(Data data, int index, BuildContext context, Log log) {
    return GestureDetector(
      onTap: () {
        logDev.log('aaaaaaaa:${data.rooms[index]}');
        final states = Provider.of<States>(context, listen: false);

        states.setIsRoomPageMinimized = false;
        log.setIsRoomActive = true;
        print(
            '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${states.isRoomPageMinimized}');
        if (states.roomInstance != null) {
          if (states.roomInstance!.roomId != data.rooms[index]['roomId']) {
            states.setRoomLeaved = true;
            states.setRoomInstance = RoomScreen(
              roomId: data.rooms[index]['roomId'],
              id: data.rooms[index]['id'],
              token: token,
            );
          }
        } else {
          states.setRoomInstance = RoomScreen(
            roomId: data.rooms[index]['roomId'],
            id: data.rooms[index]['id'],
            token: token,
          );
        }
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 17, left: 13, right: 13),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
            alignment: Alignment.center,
            width: _swidth / 2 - 20,
            height: 145,
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/${data.photos[index]}'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            data.rooms[index]['roomId'],
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.transparent,
                        child: Icon(
                          Icons.more_vert,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 49,
                            height: 40,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundImage: AssetImage(
                                      'assets/images/${data.photos[data.photos.length - index - 1]}'),
                                ),
                                Positioned(
                                  left: 17,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundImage: AssetImage(
                                        'assets/images/${data.photos[data.photos.length - index - 2]}'),
                                  ),
                                ),
                                Positioned(
                                  left: 8,
                                  top: 10,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundImage: AssetImage(
                                        'assets/images/${data.photos[data.photos.length - index - 3]}'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 13,
                              ),
                              Text(data.names.length.toString(),
                                  style: TextStyle(fontSize: 11))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          height: 70,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                data.names.length <= 3 ? data.names.length : 3,
                            itemBuilder: (context, _index) =>
                                Text(data.names[_index]),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
