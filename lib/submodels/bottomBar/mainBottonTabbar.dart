import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:videosdk/videosdk.dart';
import '../../helper/audiocall/api.dart';
import '../../models/ModelProvider.dart';
import '../../pages/roomScreen.dart';
import '../../provider/data.dart';
import '../../provider/log.dart';
import '../../provider/roomStates.dart';
import '../../widgets/reusableWidgets.dart';
import '../classModels/enums.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  ReusableWidgets reusableWidgets = ReusableWidgets();
  final TextEditingController _roomNameController = TextEditingController();
  final GlobalKey<FormState> _roomNameKey = GlobalKey<FormState>();
  int _selectedTab = 2;
  String _roomId = "";
  int _bottomPadding = 20;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    setBottomPadding();
  }

//this method is used to set the bottom padding of the bottom bar according to the device
  void setBottomPadding() async {
    if (Platform.isAndroid) {
      _bottomPadding = 0;
      setState(() {});
      return;
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo androidInfo = await deviceInfo.iosInfo;
    String model = androidInfo.name!.replaceAll(RegExp(r'[^0-9]'), '');
    if (int.parse(model) < 8) {
      _bottomPadding = 0;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<Log, Data, RoomStates>(
      builder: (context, log, data, states, child) => Container(
        margin: EdgeInsets.only(bottom: _bottomPadding.toDouble()),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 0.3,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _selectedTab = 0;
                          log.setSelectedTab = _selectedTab;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            _selectedTab == 0
                                ? Icons.notification_add
                                : Icons.notification_add_outlined,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            _selectedTab = 1;
                            log.setSelectedTab = _selectedTab;
                            _roomNameController.clear();
                            createRoomBottomSheet(context, data, log);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            height: MediaQuery.of(context).size.height * 0.045,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text('+ ',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.065,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'NunitoBold')),
                                ),
                                Text('Room',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.045,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'NunitoBold')),
                              ],
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          _selectedTab = 2;
                          log.setSelectedTab = _selectedTab;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            _selectedTab == 2
                                ? Icons.home
                                : Icons.home_outlined,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  createRoomBottomSheet(BuildContext context, Data data, Log log) async {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(top: 7),
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create a Room",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _roomNameKey,
                      child: TextFormField(
                        autofocus: true,
                        controller: _roomNameController,
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Room name should not be empty'
                              : value.length <= 2
                                  ? 'Room name should be more that 2 characters'
                                  : null;
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                            hintText: "What do you want to talk about?",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 0,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(200, 84, 152, 71),
                                Color.fromARGB(255, 54, 118, 255),
                              ]),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(TextStyle(
                                    fontSize: (Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .fontSize ??
                                            14) *
                                        1.3,
                                    fontWeight: FontWeight.bold)),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () async {
                                final con =
                                    await Connectivity().checkConnectivity();
                                final ReusableWidgets reusableWidgets =
                                    ReusableWidgets();
                                if (con == ConnectivityResult.none) {
                                  reusableWidgets.showSnackBarForConnectivity(
                                      context, 'No Internet Connection');
                                  Navigator.pop(context);
                                  return;
                                }
                                if (!_roomNameKey.currentState!.validate()) {
                                  return;
                                }
                                reusableWidgets.loadingDialog(context);
                                _roomId = await createMeeting();
                                //add room data to room table in the database
                                Rooms room = Rooms(
                                    roomId: _roomId,
                                    name: _roomNameController.text,
                                    founderId: data.userData,
                                    roomStatus: Status.active);
                                Participants participant = Participants(
                                    userId: data.userData,
                                    role: Role.admin.toString(),
                                    roomId: room,
                                    participantStatus: Status.active);
                                await Amplify.DataStore.save(room);
                                await Amplify.DataStore.save(participant);
                                Navigator.pop(context);
                                Navigator.pop(context);

                                if (room == null) {
                                  // TODO show a dialog error
                                  return;
                                }
                                if (!mounted) return;
                                final roomStates = context.read<RoomStates>();

                                log.setIsRoomPageMinimized = false;
                                if (log.isRoomActive) {
                                  roomStates.videoSDK!.leave();
                                }

                                roomStates.setVideoSDK = VideoSDK.createRoom(
                                  roomId: room.roomId,
                                  token: token,
                                  displayName: "Test Name",
                                  micEnabled: false,
                                  camEnabled: true,
                                  maxResolution: 'hd',
                                  defaultCameraIndex: 1,
                                  notification: const NotificationInfo(
                                    title: "Video SDK",
                                    message:
                                        "Video SDK is sharing screen in the meeting",
                                    icon:
                                        "notification_share", // drawable icon name
                                  ),
                                );

                                roomStates.setRoomInstance = RoomScreen(
                                  roomId: _roomId,
                                );
                                roomStates.videoSDK!.join();
                                log.setIsRoomActive = true;
                              },
                              child: const Text("Create your Room"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const SizedBox(
                            width: 50,
                            child: Text("Cancel"),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
