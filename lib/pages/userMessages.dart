import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialnetwork/models/UserChats.dart';
import 'package:socialnetwork/models/Users.dart';
import 'package:uuid/uuid.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../provider/themeProvider.dart';
import '../submodels/appBars/messageAppBar.dart';

class UserMessages extends StatefulWidget {
  UserMessages({Key? key, required this.email}) : super(key: key);
  String email;
  @override
  State<UserMessages> createState() => _UserMessagesState();
}

class _UserMessagesState extends State<UserMessages> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _messageScrollController = ScrollController();
  String _messageText = '';
  final uuid = const Uuid();
  Users? _recieverInfo;
  Users? _senderInfo;
  final StreamController<List<UserChats>> _streamController =
      StreamController.broadcast();

  StreamSubscription<QuerySnapshot<UserChats>>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    try {
      _senderInfo = context.read<Data>().userData;
      setState(() {});
      await Amplify.DataStore.query(Users.classType,
              where: Users.EMAIL.eq(widget.email))
          .then((value) {
        _recieverInfo = value.first;
        getUserMessages(_senderInfo!.userId, _recieverInfo!.userId);
      }).catchError((error) {
        print(error);
      });
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getUserMessages(String userSender, String userReciever) async {
    _streamSubscription = Amplify.DataStore.observeQuery(UserChats.classType,
            where: (UserChats.USERIDSENDER
                    .eq(userSender)
                    .and(UserChats.USERIDRECIEVER.eq(userReciever)))
                .or(UserChats.USERIDSENDER
                    .eq(userReciever)
                    .and(UserChats.USERIDRECIEVER.eq(userSender))))
        .listen((QuerySnapshot<UserChats> event) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (_messageScrollController.hasClients) {
          _messageScrollController
              .jumpTo(_messageScrollController.position.maxScrollExtent);
        }
      });
      _streamController.sink.add(event.items);
    });
  }

  @override
  void dispose() {
    _streamController.close();
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Log, Data>(
      builder: (context, log, data, child) => Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 47),
            child: MessageAppBar(
              recieverData: _recieverInfo,
            )),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: _recieverInfo != null
                      ? StreamBuilder<List<UserChats>>(
                          stream: _streamController.stream,
                          builder: ((context,
                              AsyncSnapshot<List<UserChats>> snapshot) {
                            //this will get user's messages
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              getUserMessages(
                                  _senderInfo!.userId, _recieverInfo!.userId);
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.data!.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text('No messages'),
                              );
                            }

                            if (snapshot.hasData) {
                              return ListView.builder(
                                  controller: _messageScrollController,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) => Row(
                                        mainAxisAlignment: snapshot.data![index]
                                                    .userIdSender ==
                                                context
                                                    .read<Data>()
                                                    .userData!
                                                    .userId
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Material(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    snapshot
                                                        .data![index].content!,
                                                    style: const TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ));
                            } else {
                              return const Center(
                                  child: Text('No messages yet...'));
                            }
                          }),
                        )
                      : const SizedBox()),
              Column(
                children: [
                 
                  Container(
                    width: double.infinity,
                    height: 0.3,
                    color: Colors.grey,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.read<ThemeProvider>().isDark
                          ? const Color.fromARGB(255, 24, 24, 24)
                          : Colors.white,
                    ),
                    
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _messageController,
                        onChanged: (value) {
                          setState(() {
                            _messageText = value;
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            hintText: 'Message',
                            suffixIcon: _messageText.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.attach_file)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.image)),
                                        ]),
                                  )
                                : IconButton(
                                    onPressed: () async {
                                      final userChats = UserChats(
                                          userChatId: uuid.v4(),
                                          userIdSender: context
                                              .read<Data>()
                                              .userData!
                                              .userId,
                                          userIdReciever: _recieverInfo!.userId,
                                          content: _messageController.text);
                                      await Amplify.DataStore.save(userChats)
                                          .then((value) {
                                        _messageController.clear();
                                        setState(() => _messageText = '');
                                      });
                                    },
                                    icon: const Icon(Icons.send)),
                            contentPadding: const EdgeInsets.only(left: 12),
                            suffixIconColor: Colors.blue.shade600,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
