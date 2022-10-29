import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/helper.dart';
import '../models/Users.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../submodels/appBars/allMessagesAppBar.dart';
import '../submodels/appBars/searchForUsrsAppBar.dart';
import 'searchDetails.dart';
import 'userMessages.dart';

class SearchForUsers extends StatefulWidget {
  const SearchForUsers({Key? key}) : super(key: key);

  @override
  State<SearchForUsers> createState() => _SearchForUsersState();
}

class _SearchForUsersState extends State<SearchForUsers> {
  List<int> _topicsListIndex = [];
  String _searchvalue = '';
  late Stream<List<Users>?> _usersStream;
  String _profileImage = '';
  Helper helper = Helper();

  @override
  void initState() {
    super.initState();
    _usersStream = searchStream(_searchvalue);
  }

  Stream<List<Users>?> searchStream(String searchValue) async* {
    final streamOfUsers = await Amplify.DataStore.query(Users.classType,
        where: Users.USERNAME.eq(searchValue));
    yield streamOfUsers.length > 0 ? streamOfUsers : null;
  }

  Future futureprofileImages(String profile_image) async {
    final imageUrl = await helper.getImages(profile_image);
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
        builder: (context, data, child) => Scaffold(
              appBar: PreferredSize(
                  child: SearchForUsersAppBar(
                    onSearch: (String searchValue) async {
                      _searchvalue = searchValue;
                      _usersStream = searchStream(_searchvalue);
                      setState(() {});
                    },
                  ),
                  preferredSize: Size.fromHeight(38)),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Users',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          height: 600,
                          child: StreamBuilder(
                              stream: _usersStream,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                    ],
                                  );
                                } else if (snapshot.hasData) {
                                  List users = snapshot.data as List;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserMessages(
                                                    email: users.first.email,
                                                  )));
                                    },
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    child: ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      title: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          users.first.profile_image != null
                                              ? FutureBuilder(
                                                  future: futureprofileImages(
                                                      users.first
                                                              .profile_image ??
                                                          ''),
                                                  builder:
                                                      ((context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return CircleAvatar(
                                                        radius: 17.0,
                                                        backgroundImage:
                                                            CachedNetworkImageProvider(
                                                          _profileImage,
                                                          errorListener: () {},
                                                        ),
                                                      );
                                                    } else {
                                                      return CircleAvatar(
                                                        radius: 17.0,
                                                        backgroundColor: context
                                                                .read<Log>()
                                                                .isDark
                                                            ? Colors
                                                                .grey.shade800
                                                            : Colors
                                                                .grey.shade300,
                                                      );
                                                    }
                                                  }))
                                              : CircleAvatar(
                                                  radius: 17.0,
                                                  backgroundColor: context
                                                          .read<Log>()
                                                          .isDark
                                                      ? Colors.grey.shade800
                                                      : Colors.grey.shade300,
                                                ),
                                          SizedBox(
                                            width: 14,
                                          ),
                                          Text(users.first.userName),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Text('No users found');
                                }
                              }),
                        )
                      ]),
                ),
              ),
            ));
  }
}
