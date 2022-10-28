import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Users.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../submodels/appBars/allMessagesAppBar.dart';
import '../submodels/appBars/searchForUsrsAppBar.dart';
import 'searchDetails.dart';

class SearchForUsers extends StatefulWidget {
  const SearchForUsers({Key? key}) : super(key: key);

  @override
  State<SearchForUsers> createState() => _SearchForUsersState();
}

class _SearchForUsersState extends State<SearchForUsers> {
  List<int> _topicsListIndex = [];
  String _searchvalue = '';
  late Stream<List<Users>?> _usersStream;

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

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
        builder: (context, data, child) => Scaffold(
              appBar: PreferredSize(
                  child: SearchForUsersAppBar(
                    onSearch: (String searchValue) async {
                      print('searchValue:$searchValue');
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
                                  return ListTile(
                                    title: Text(users.first.userName),
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
