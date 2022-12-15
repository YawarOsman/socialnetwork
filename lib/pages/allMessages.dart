import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialnetwork/models/UserChats.dart';
import 'package:socialnetwork/submodels/appBars/allMessagesAppBar.dart';
import '../models/Users.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import 'userMessages.dart';

class AllMessages extends StatefulWidget {
  const AllMessages({Key? key}) : super(key: key);

  @override
  State<AllMessages> createState() => _AllMessagesState();
}

class _AllMessagesState extends State<AllMessages>
    with SingleTickerProviderStateMixin {
  final StreamController<List<UserChats>?> _usersYouChattedWith =
      StreamController<List<UserChats>?>.broadcast();
  late String myId;
  Future<Users>? _eachUserYouChattedWith = null;

  @override
  void initState() {
    super.initState();
    getUsersYouChattedWith();
  }

  void getUsersYouChattedWith() async {
    //get chats which your or your friend id is in the chat list in UsersChat
    try {
      myId = context.read<Data>().userData!.userId;

      await Amplify.DataStore.query(UserChats.classType,
              where: UserChats.USERIDSENDER
                  .eq(myId)
                  .or(UserChats.USERIDRECIEVER.eq(myId)))
          .then((value) {
        if (!_usersYouChattedWith.isClosed) {
          _usersYouChattedWith.sink.add(value.isNotEmpty ? value : null);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Users> getEachUserYouChatedWith(String userId) async {
    final eachUser = await Amplify.DataStore.query(Users.classType,
        where: Users.USERID.eq(userId));

    return eachUser.first;
  }

  @override
  void dispose() {
    _usersYouChattedWith.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Data, Log>(
        builder: (context, data, log, child) => Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: AllMessagesAppBar(),
              ),
              body: people,
            ));
  }

  Widget get people => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: _usersYouChattedWith.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        getUsersYouChattedWith();
                        return const Center(child: CircularProgressIndicator());
                      }
                      print('111111111111111:${snapshot.data}');
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text('You\'ve not messaged to anyone yet...'),
                        );
                      }
                      List<UserChats> messages =
                          snapshot.data as List<UserChats>;
                      return ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            _eachUserYouChattedWith = getEachUserYouChatedWith(
                                messages[index].userIdReciever == myId
                                    ? messages[index].userIdSender
                                    : messages[index].userIdReciever);
                            return FutureBuilder(
                                future: _eachUserYouChattedWith,
                                builder: (context, snapshot) {
                                  print('33333333333333:${snapshot.data}');
                                  if (!snapshot.hasData) {
                                    return const SizedBox();
                                  }
                                  final eachUser = snapshot.data as Users;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserMessages(
                                                    email: eachUser.email!,
                                                  )));
                                    },
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: AssetImage(
                                                      'assets/images/1.jpeg'),
                                                ),
                                                const SizedBox(width: 13),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        eachUser.userName!,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      Text(
                                                        eachUser.email!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Text(
                                              '12:00 am',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          });
                    })),
          ],
        ),
      );
}
