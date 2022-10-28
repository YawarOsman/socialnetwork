import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:videosdk/videosdk.dart';
import '../../helper/audiocall/api.dart';
import '../../models/ModelProvider.dart';
import '../../models/Participants.dart';
import '../../pages/roomScreen.dart';
import '../../provider/data.dart';
import '../../provider/log.dart';
import '../../widgets/reusableWidgets.dart';
import '../style.dart';

enum role { creator, moderator, participant }

class BottomBar extends StatefulWidget {
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  ReusableWidgets reusableWidgets = ReusableWidgets();
  TextEditingController _roomNameController = TextEditingController();
  GlobalKey<FormState> _roomNameKey = GlobalKey<FormState>();
  Style style = Style();
  int _selectedTab = 4;
  double _roomSize = 40;
  Color _iconColor = Colors.white;
  int modelNumber = 10;
  String roomId = "";
  bool isMeetingActive = false;
  var uuid = Uuid();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    _iconColor = Theme.of(context).iconTheme.color!;

    return DefaultTabController(
      length: 5,
      child: Consumer2<Log, Data>(
        builder: (context, log, data, child) => Container(
          padding: EdgeInsets.only(bottom: Platform.isAndroid ? 0 : 5),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 0.5,
                color: Colors.grey,
              ),
              TabBar(
                  indicatorWeight: 0.1,
                  indicatorColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  tabs: [
                    Tab(
                      icon: Icon(
                          _selectedTab == 0
                              ? Icons.class_sharp
                              : Icons.class_outlined,
                          color: _iconColor),
                    ),
                    Tab(
                      icon: Icon(
                          _selectedTab == 1
                              ? Icons.event_sharp
                              : Icons.event_outlined,
                          color: _iconColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        _roomNameController.clear();
                        if (isMeetingActive) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RoomScreen(
                                        roomId: roomId,
                                        token: token,
                                        leaveRoom: () {
                                          setState(
                                              () => isMeetingActive = false);
                                        },
                                        endRoom: () {
                                          setState(
                                              () => isMeetingActive = false);
                                        },
                                      )));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    contentPadding: EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 20,
                                        bottom: 10),
                                    content: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      child: Form(
                                        key: _roomNameKey,
                                        child: TextFormField(
                                          controller: _roomNameController,
                                          validator: (value) {
                                            return value!.isEmpty
                                                ? 'Room name should not be empty'
                                                : value.length <= 2
                                                    ? 'Room name should be more that 2 characters'
                                                    : null;
                                          },
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                              hintText: "Enter Room Name",
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              border: style.enabledBorder,
                                              focusedBorder:
                                                  style.focusedBorder,
                                              enabledBorder:
                                                  style.enabledBorder,
                                              errorBorder: style.errorBorder),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          child: Text("Cancel"),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          }),
                                      TextButton(
                                          onPressed: () async {
                                            if (!_roomNameKey.currentState!
                                                .validate()) return;

                                            reusableWidgets
                                                .showLoadingDialog(context);
                                            roomId = await createMeeting();
                                            setState(
                                                () => isMeetingActive = true);
                                            //add room data to room table in the database
                                            Rooms room = Rooms(
                                              roomId: roomId,
                                              name: _roomNameController.text,
                                              founderId: data.userData,
                                            );
                                            Participants participant =
                                                Participants(
                                                    participantsId:
                                                        data.userData,
                                                    role:
                                                        role.creator.toString(),
                                                    roomId: room,
                                                    peeringId: uuid.v4());
                                            await Amplify.DataStore.save(room);
                                            await Amplify.DataStore.save(
                                                participant);
                                            Navigator.pop(context);
                                            Navigator.pop(context);

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RoomScreen(
                                                          roomId: roomId,
                                                          token: token,
                                                          leaveRoom: () {
                                                            setState(() =>
                                                                isMeetingActive =
                                                                    false);
                                                          },
                                                          endRoom: () {
                                                            setState(() =>
                                                                isMeetingActive =
                                                                    false);
                                                          },
                                                        )));
                                          },
                                          child: Text("Create")),
                                    ],
                                  ));
                        }
                      },
                      child: Tab(
                        icon: Icon(
                          Icons.add,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Icon(
                          _selectedTab == 3
                              ? Icons.notification_add
                              : Icons.notification_add_outlined,
                          color: _iconColor),
                    ),
                    Tab(
                      icon: Icon(
                        _selectedTab == 4 ? Icons.home : Icons.home_outlined,
                        color: _iconColor,
                      ),
                    ),
                  ],
                  onTap: (index) {
                    _selectedTab = index;
                    log.setSelectedTab = index;
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
