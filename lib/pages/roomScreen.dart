import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialnetwork/main.dart';
import 'package:videosdk/videosdk.dart';
import '../../helper/audiocall/participant_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devlog;
import '../helper/audiocall/api.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../provider/states.dart';

class RoomScreen extends StatefulWidget {
  final String roomId;
  final String? id;
  final String token;
  final void Function() leaveRoom;
  final void Function() endRoom;

  const RoomScreen(
      {Key? key,
      this.id,
      required this.roomId,
      required this.token,
      required this.leaveRoom,
      required this.endRoom})
      : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  Map<String, Stream?> participantVideoStreams = {};
  bool micEnabled = false;
  late Room room;
  bool isRoomReady = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void setParticipantStreamEvents(Participant participant) {
    participant.on(Events.streamEnabled, (Stream stream) {
      if (stream.kind == 'video') {
        participantVideoStreams[participant.id] = stream;
        setState(() {});
      }
    });

    participant.on(Events.streamDisabled, (Stream stream) {
      if (stream.kind == 'video') {
        participantVideoStreams.remove(participant.id);
        setState(() {});
      }
    });
  }

  void setMeetingEventListener(Room _room) {
    setParticipantStreamEvents(_room.localParticipant);

    _room.on(Events.roomJoined, () {
      print('room Joined:');
      setState(() => isRoomReady = true);
    });

    _room.on(
      Events.participantJoined,
      (Participant participant) {
        print('participant Joined: ${participant.id}');
        setParticipantStreamEvents(participant);
      },
    );

    _room.on(Events.participantLeft, (String participantId) {
      print('Participant left: $participantId');
      if (participantVideoStreams.containsKey(participantId)) {
        setState(() => participantVideoStreams.remove(participantId));
      }
    });
    _room.on(Events.roomLeft, () {
      participantVideoStreams.clear();
      print('Room left');
    });
  }

  @override
  void initState() {
    super.initState();
    // Create instance of Room (Meeting)

    room = VideoSDK.createRoom(
      roomId: widget.roomId,
      token: widget.token,
      displayName: "Test Name",
      micEnabled: micEnabled,
      camEnabled: true,
      maxResolution: 'hd',
      defaultCameraIndex: 1,
      notification: const NotificationInfo(
        title: "Video SDK",
        message: "Video SDK is sharing screen in the meeting",
        icon: "notification_share", // drawable icon name
      ),
    );

    setMeetingEventListener(room);

    // Join meeting
    room.join();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          //Provider.of<States>(context, listen: false).isRoomPageMinimized
          //     ? 200
          //     :
          MediaQuery.of(context).size.height -
              MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .padding
                  .top,
      child: Scaffold(
        body: Column(
          children: [
            Card(
              elevation: 5,
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Container(
                padding: EdgeInsets.only(top: 10),
                color: context.read<Log>().isDark
                    ? Color.fromARGB(255, 22, 22, 22)
                    : Colors.white,
                height: 150,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 15, bottom: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Provider.of<States>(context, listen: false)
                                      .setIsRoomPageMinimized = true;
                                  print(
                                      'dodododdododododdododododdododododododdodoododdo:${Provider.of<States>(context, listen: false).isRoomPageMinimized}');
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 30,
                                )),
                            GestureDetector(
                                onTap: () {
                                  if (!isRoomReady) {
                                    return;
                                  }
                                  Provider.of<States>(context, listen: false)
                                      .setIsRoomOpened = false;
                                  Provider.of<States>(context, listen: false)
                                      .setIsRoomPageMinimized = true;
                                  room.end();
                                },
                                child: Text(
                                  'End',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                )),
                            GestureDetector(
                                onTap: () async {
                                  if (!isRoomReady) {
                                    return;
                                  }
                                  final id = widget.id;
                                  print(id);
                                  final url =
                                      'https://api.videosdk.live/v2/sessions/$id';
                                  final http.Response response = await http.get(
                                      Uri.parse(url),
                                      headers: {'Authorization': token});
                                  devlog.log(
                                      '___++_+__+_+_+++_+_+_++_: ${jsonDecode(response.body)}');
                                },
                                child: Text(
                                  'show',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                )),
                            GestureDetector(
                                onTap: () {
                                  if (!isRoomReady) {
                                    return;
                                  }
                                  Provider.of<States>(context, listen: false)
                                      .setIsRoomOpened = false;
                                  Provider.of<States>(context, listen: false)
                                      .setIsRoomPageMinimized = true;
                                  room.leave();
                                },
                                child: Text(
                                  'Leave',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                )),
                          ]),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Convince me to buy this'),
                                      Text('Room ID: ${widget.roomId}'),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person_outline, size: 15),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('2/3'),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text('Replays off'),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Created by John Doe',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: participantVideoStreams.values.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                itemBuilder: (context, index) => ParticipantTile(
                  stream: participantVideoStreams.values.elementAt(index)!,
                  roomId: widget.roomId,
                  isSpeak: true,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5, mainAxisSpacing: 5, crossAxisCount: 3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
