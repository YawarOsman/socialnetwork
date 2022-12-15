import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socialnetwork/provider/isAmplifyConfigured.dart';
import 'package:socialnetwork/provider/themeProvider.dart';
import '../helper/helper.dart';
import '../models/Rooms.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../provider/roomStates.dart';
import '../submodels/appBars/mainAppBar.dart';
import '../widgets/roomCard.dart';
import 'profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final token = dotenv.env['TOKEN']!;
  final StreamController<List<Rooms>> _roomCardStreamController =
      StreamController.broadcast();

  // Stream<FileResponse> fileStream = DefaultCacheManager().getFileStream();

  // StreamSubscription<QuerySnapshot<Rooms>>? _roomCardStreamSubscription;

  @override
  void initState() {
    super.initState();
    getUserData();

    getRooms();
    context.read<IsAmplifyConfigured>().addListener(() {
      getRooms();
    });
  }

  void getRooms() async {
    try {

      if (!context.read<IsAmplifyConfigured>().isAmplifyConfigured) return;
      print('*((*(*(*(*(*(*(*(*(*(*((');
      // _roomCardStreamSubscription =
      Amplify.DataStore.query(Rooms.classType).then((event) {
        print('11213213123123123123123123123:${event}');
        _roomCardStreamController.sink.add(event);
      });
    } catch (e) {
      debugPrint('errrrrrror${e.toString()}');
    }
  }

  void getUserData() async {
    try {
      await context.read<Data>().getEmail;
      await context
          .read<Data>()
          .getUserData
          .then((value) async => await context.read<Data>().setProfileImage());
      context.read<Log>().getThemeModeIndex;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    // if (_roomCardStreamSubscription != null)
    //   _roomCardStreamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer5<Data, Log, Helper, ThemeProvider, RoomStates>(
      builder: (context, data, log, helper, themeProvider, roomStates, child) =>
          Scaffold(
              drawer: data.userData == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Profile(),
              appBar: PreferredSize(
                preferredSize: const Size(double.infinity, 47),
                child: MainAppBar(theme: Theme.of(context)),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  getRooms();
                },
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                          width: double.infinity,
                          height: 94,
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 9,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.only(left: 4),
                              itemBuilder: (context, index) => Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 7,
                                            left: 9,
                                            right: 9,
                                            bottom: 2),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage(
                                              'assets/images/${index + 1}.jpeg'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 63,
                                        child: Center(
                                          child: Text(
                                            data.names[index],
                                            style:
                                                const TextStyle(fontSize: 12),
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                          ),
                                        ),
                                      )
                                    ],
                                  ))),
                      // Rooms
                      SizedBox(
                          child: StreamBuilder<List<Rooms>>(
                        stream: _roomCardStreamController.stream,
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.data == null) {
                            return Shimmer.fromColors(
                              baseColor: themeProvider.isDark
                                  ? Colors.grey[900]!
                                  : Colors.grey[200]!,
                              highlightColor: themeProvider.isDark
                                  ? Colors.grey[700]!
                                  : Colors.white,
                              child: Column(
                                children: [
                                  Column(
                                      children: List.generate(
                                          5,
                                          (index) => Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                        horizontal: 13),
                                                width: double.infinity,
                                                height: 148,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              )))
                                ],
                              ),
                            );
                          }

                          print(
                              'getRoomssssssssssssssssssssssssss${snapshot.data}');
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: (snapshot.data as List).length,
                            itemBuilder: (context, index) => RoomCard(
                              room: (snapshot.data as List)[index],
                            ),
                          );
                        }),
                      ))
                    ]),
                  ),
                ),
              )),
    );
  }
}
