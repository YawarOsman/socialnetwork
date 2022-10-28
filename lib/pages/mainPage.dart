import 'dart:convert';
import 'dart:developer' as logDev;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/data.dart';
import '../provider/log.dart';
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

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _swidth = _mediaQueryData.size.width;
    _sheight = _mediaQueryData.size.height;

    return Consumer2<Data, Log>(
      builder: (context, data, log, child) => Scaffold(
          drawer: Profile(),
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 47),
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
                        _roomSelected = true;
                        setState(() {});
                        const url1 =
                            'https://api.videosdk.live/v2/sessions/?roomId=a930-oqzm-mapv';
                        final http.Response response1 = await http.get(
                            Uri.parse(url1),
                            headers: {'Authorization': data.token});
                        logDev.log(
                            '___++_+__+_+_+++_+_+_++_: ${jsonDecode(response1.body)['data'][0]['participants'].length}');
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
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            logDev.log('aaaaaaaa:${data.rooms[index]}');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RoomScreen(
                                          roomId: data.rooms[index]['roomId'],
                                          id: data.rooms[index]['id'],
                                          token: data.token,
                                          leaveRoom: () {
                                            log.setIsRoomActive = false;
                                          },
                                          endRoom: () {
                                            log.setIsRoomActive = false;
                                          },
                                        )));
                          },
                          child: Card(
                            margin: EdgeInsets.only(
                                bottom: 17, left: 13, right: 13),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Container(
                                alignment: Alignment.center,
                                width: _swidth / 2 - 20,
                                height: 145,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  Text(
                                                      data.names.length
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 11))
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
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    data.names.length <= 3
                                                        ? data.names.length
                                                        : 3,
                                                itemBuilder: (context,
                                                        _index) =>
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
                        ),
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
}
