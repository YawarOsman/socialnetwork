import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialnetwork/models/ModelProvider.dart';
import 'package:socialnetwork/provider/roomStates.dart';
import 'package:socialnetwork/provider/themeProvider.dart';
import 'package:socialnetwork/submodels/classModels/enums.dart';
import 'package:videosdk/videosdk.dart';
import '../helper/audiocall/api.dart';
import '../helper/helper.dart';
import '../models/Participants.dart';
import '../models/Rooms.dart';
import '../pages/roomScreen.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../widgets/reusableWidgets.dart';

class RoomCard extends StatefulWidget {
  RoomCard({
    super.key,
    required this.room,
  });
  Rooms room;

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  List _participantsForEachRoom = [];

  @override
  void initState() {
    super.initState();
    getParticipantsForEachRoom();
  }

  void getParticipantsForEachRoom() async {
    try {
      await Amplify.DataStore.query(Participants.classType,
              where: Participants.ROOMID.eq(widget.room.roomId))
          .then((event) {
        if (event.length > 3) {
          _participantsForEachRoom = event.sublist(3);
        } else {
          _participantsForEachRoom = event;
        }

        setState(() {});
        print(';;;;;;;;;;;;;;;;;;;;;$_participantsForEachRoom');
      });
    } catch (e) {
      print('errrrrrror in getParticpantsForEachRomm ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer5<Data, Log, Helper, RoomStates, ThemeProvider>(
      builder: (context, data, log, helper, roomStates, themeProvider, child) =>
          GestureDetector(
        onTap: () => onRoomCardTap(context, data, log, roomStates),
        child: Card(
          margin: const EdgeInsets.only(bottom: 17, left: 13, right: 13),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 145,
              decoration: BoxDecoration(
                  color: themeProvider.isDark
                      ? Colors.black12
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.room.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        InkWell(
                          onTap: () {},
                          splashColor: Colors.transparent,
                          child: const Icon(
                            Icons.more_vert,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: 49,
                              height: 40,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundImage: AssetImage(
                                        'assets/images/${data.photos[data.photos.length - 3 - 1]}'),
                                  ),
                                  Positioned(
                                    left: 17,
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundImage: AssetImage(
                                          'assets/images/${data.photos[data.photos.length - 4 - 2]}'),
                                    ),
                                  ),
                                  Positioned(
                                    left: 8,
                                    top: 10,
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundImage: AssetImage(
                                          'assets/images/${data.photos[data.photos.length - 2 - 3]}'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person_outline,
                                  size: 13,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(_participantsForEachRoom.length.toString(),
                                    style: const TextStyle(fontSize: 11))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 70,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _participantsForEachRoom.length,
                              itemBuilder: (context, index) => Text(
                                _participantsForEachRoom.isNotEmpty
                                    ? _participantsForEachRoom[index]
                                    : "Ray Kavita",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
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
    );
  }

  onRoomCardTap(
      BuildContext context, Data data, Log log, RoomStates roomStates) async {
    try {
      final con = await Connectivity().checkConnectivity();
      final ReusableWidgets reusableWidgets = ReusableWidgets();
      if (con == ConnectivityResult.none) {
        reusableWidgets.showSnackBarForConnectivity(
            context, 'No Internet Connection');
        return;
      }

      print('aaaaaaaa:${widget.room}');
      if (widget.room == null) {
        // TODO show a dialog error
        return;
      }
      log.setIsRoomPageMinimized = false;
      if (log.isRoomActive) {
        if (roomStates.videoSDK!.id != widget.room.roomId) {
          roomStates.videoSDK!.leave();
        } else {
          log.setIsRoomPageMinimized = false;
        }
      }
      final allParticipants =
          await Amplify.DataStore.query(Participants.classType);
      print('allParticipantsssssssssssss: $allParticipants');
      if (allParticipants.isEmpty ||
          allParticipants
              .where(
                  (element) => element.userId!.userId == data.userData!.userId)
              .isEmpty) {
        print('!!!!!!!!!!!!@@@!@@!@!@!@@!@');
        final Participants participants = Participants(
            userId: data.userData,
            roomId: widget.room,
            role: widget.room.founderId == data.userData!.userId
                ? Role.admin.toString()
                : Role.user.toString(),
            participantStatus: Status.active);
        await Amplify.DataStore.save(participants);
      }

      roomStates.setVideoSDK = VideoSDK.createRoom(
        roomId: widget.room.roomId,
        token: token,
        displayName: "Test Name",
        micEnabled: false,
        camEnabled: true,
        maxResolution: 'hd',
        defaultCameraIndex: 1,
        notification: const NotificationInfo(
          title: "Video SDK",
          message: "Video SDK is sharing screen in the meeting",
          icon: "notification_share", // drawable icon name
        ),
      );

      roomStates.setRoomInstance = RoomScreen(
        roomId: widget.room.roomId,
      );
      roomStates.videoSDK!.join();

      log.setIsRoomActive = true;
    } catch (e) {
      print('errorrrrrrrr:$e');
    }
  }
}
