import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';
import '../provider/log.dart';
import 'userMessages.dart';

class AllMessages extends StatefulWidget {
  const AllMessages({Key? key}) : super(key: key);

  @override
  State<AllMessages> createState() => _AllMessagesState();
}

class _AllMessagesState extends State<AllMessages> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<Data, Log>(
        builder: (context, data, log, child) => DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  iconTheme: Theme.of(context).iconTheme,
                  toolbarHeight: 80,
                  elevation: 1,
                  leadingWidth: 40,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(left: 13),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/searchForUsers');
                            },
                            child: Icon(Icons.search))
                      ],
                    ),
                    SizedBox(width: 13),
                  ],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: TabBar(
                          labelColor: Theme.of(context).iconTheme.color,
                          indicatorColor: Colors.green.shade600,
                          tabs: [
                            Tab(text: 'People'),
                            Tab(text: 'Groups'),
                            Tab(text: 'Requests')
                          ]),
                    ),
                  ),
                ),
                body: TabBarView(children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: 11,
                                itemBuilder: (context, _index) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserMessages(
                                                      //todo change this email to a dynamic one
                                                      email:
                                                          'yawarhama@gmail.com',
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
                                                        'assets/images/${_index + 1}.jpeg'),
                                                  ),
                                                  SizedBox(width: 13),
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            data.names[_index],
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(
                                                            data.messages[
                                                                _index],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontSize: 13),
                                                          ),
                                                        ],
                                                      ),
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
                                    ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: 8,
                                itemBuilder: (context, _index) => Padding(
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
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    children: [
                                                      Positioned(
                                                        left: 0,
                                                        top: 12,
                                                        child: CircleAvatar(
                                                          radius: 13,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/${_index + 2}.jpeg'),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 7,
                                                        child: CircleAvatar(
                                                          radius: 13,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/${_index + 1}.jpeg'),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 14,
                                                        top: 12,
                                                        child: CircleAvatar(
                                                          radius: 13,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/${_index + 3}.jpeg'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 13),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          data.names[_index],
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(height: 3),
                                                        Text(
                                                          data.messages[_index],
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
                                    ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, _index) => Padding(
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
                                                      'assets/images/${_index + 1}.jpeg'),
                                                ),
                                                SizedBox(width: 13),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          data.names[_index],
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(height: 3),
                                                        Text(
                                                          data.messages[_index],
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
                                    ))),
                      ],
                    ),
                  ),
                ]),
              ),
            ));
  }
}
