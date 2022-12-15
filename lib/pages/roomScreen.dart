import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialnetwork/models/ModelProvider.dart';
import 'package:socialnetwork/models/Rooms.dart';
import 'package:socialnetwork/widgets/reusableWidgets.dart';
import 'package:videosdk/videosdk.dart';
import '../../helper/audiocall/participant_tile.dart';
import '../models/Participants.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../provider/roomStates.dart';
import '../provider/themeProvider.dart';

class RoomScreen extends StatefulWidget {
  final String roomId;
  const RoomScreen({
    Key? key,
    required this.roomId,
  }) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final Map<String, Stream?> _participantVideoStreams = {};
  late Room _room;
  bool _isRoomReady = false;
  late RoomStates providerListener;
  Rooms? _roomInfo;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void setParticipantStreamEvents(Participant participant) {
    participant.on(Events.streamEnabled, (Stream stream) {
      if (stream.kind == 'video') {
        _participantVideoStreams[participant.id] = stream;
        setState(() {});
      }
    });

    participant.on(Events.streamDisabled, (Stream stream) {
      if (stream.kind == 'video') {
        _participantVideoStreams.remove(participant.id);
        setState(() {});
      }
    });
  }

  void setMeetingEventListener(Room _room) {
    setParticipantStreamEvents(_room.localParticipant);

    _room.on(
      Events.participantJoined,
      (Participant participant) {
        print('participant Joineddddddddddddddddddddddd: ${participant.id}');
        setParticipantStreamEvents(participant);
      },
    );

    _room.on(Events.participantLeft, (String participantId) {
      print(
          'Participant lefttttttttttttttttttttttttttttttttttttttttttttttt: $participantId');
      if (_participantVideoStreams.containsKey(participantId)) {
        setState(() => _participantVideoStreams.remove(participantId));
      }
    });

    _room.on(Events.roomJoined, () {
      print('room Joineddddddddddddddddddddddddddddd:');
      setState(() => _isRoomReady = true);
    });

    _room.on(Events.roomLeft, () {
      _participantVideoStreams.clear();
      print('Room leftttttttttttttttttttttttttttttttttttttttttttttt');
      if (!mounted) return;
      context.read<Log>().setIsRoomActive = false;
      context.read<Log>().setIsRoomPageMinimized = true;
    });
  }

  @override
  void initState() {
    super.initState();
    roomInfo();
    providerListener = context.read<RoomStates>();
    _room = providerListener.videoSDK!;
    setMeetingEventListener(_room);
    providerListener.addListener(() {
      _room = providerListener.videoSDK!;
      setMeetingEventListener(_room);
    });
    print('11111111111111');
  }

  void roomInfo() async {
    await Amplify.DataStore.query(Rooms.classType,
            where: Rooms.ROOMID.eq(widget.roomId))
        .then((value) {
      _roomInfo = value.first;
      setState(() {});
    });
  }

  @override
  void dispose() {
    providerListener.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top,
      child: Consumer2<Log, RoomStates>(
        builder: (context, log, roomStates, child) => Scaffold(
          body: Column(
            children: [
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  color: context.read<ThemeProvider>().isDark
                      ? const Color.fromARGB(255, 22, 22, 22)
                      : Colors.white,
                  height: 125,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 15, bottom: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    log.setIsRoomPageMinimized = true;
                                  },
                                  child: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    if (!_isRoomReady) {
                                      return;
                                    }
                                    showDialog(
                                        context: context,
                                        builder: ((context) => AlertDialog(
                                              backgroundColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13)),
                                              title: const Text(
                                                'You Sure About Ending The Room?',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('No')),
                                                TextButton(
                                                    onPressed: () {
                                                      _room.end();

                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Yes')),
                                              ],
                                            )));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      gradient: const LinearGradient(colors: [
                                        Color.fromARGB(200, 84, 152, 71),
                                        Color.fromARGB(255, 54, 118, 255),
                                      ]),
                                    ),
                                    child: const Text(
                                      'End',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  )),
                              GestureDetector(
                                  onTap: () async {
                                    try {
                                      if (_isRoomReady) {
                                        _room.leave();
                                        final userId = context
                                            .read<Data>()
                                            .userData!
                                            .userId;
                                        final participant =
                                            await Amplify.DataStore.query(
                                                Participants.classType,
                                                where: Participants.USERID
                                                    .eq(userId)
                                                    .and(Participants.ROOMID
                                                        .eq(widget.roomId)));
                                        final firstParticipant =
                                            participant.first;
                                        final updatedParticipant =
                                            firstParticipant.copyWith(
                                                participantStatus:
                                                    Status.inactive);
                                        await Amplify.DataStore.save(
                                            updatedParticipant);
                                      }
                                    } catch (e) {
                                      print(e);
                                      //todo: show a message dialog
                                    }
                                  },
                                  child: const Text(
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
                                        Text(
                                            '${_roomInfo != null ? _roomInfo!.name : ''}'),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: const [
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
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Created by John Doe',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
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
              NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: Expanded(
                  child: _isRoomReady
                      ? GridView.builder(
                          itemCount: _participantVideoStreams.values.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8),
                          itemBuilder: (context, index) => ParticipantTile(
                            stream: _participantVideoStreams.values
                                .elementAt(index)!,
                            roomId: _room.id,
                            isSpeak: true,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  crossAxisCount: 3),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
