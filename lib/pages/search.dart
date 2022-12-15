import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../provider/themeProvider.dart';
import 'searchDetails.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<int> _topicsListIndex = [];
  @override
  Widget build(BuildContext context) {
    return Consumer2<Data, Log>(
        builder: (context, data, log, child) => GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                appBar: AppBar(
                    iconTheme: Theme.of(context).iconTheme,
                    leadingWidth: 0,
                    leading: SizedBox(width: 0),
                    elevation: 0,
                    titleSpacing: 0,
                    toolbarHeight: 38,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 3),
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 38,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).cardColor),
                            child: TextField(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, anim1, anim2) =>
                                          SearchDetails(),
                                      transitionDuration:
                                          Duration(milliseconds: 0),
                                    ));
                              },
                              enableInteractiveSelection: false,
                              readOnly: true,
                              cursorColor: Colors.green.shade600,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: Colors.green.shade600,
                                  ),
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 13)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.more_vert),
                          )
                        ],
                      ),
                    )),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 13),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Topics',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          Wrap(
                            children: List.generate(
                                data.topics.length > 10
                                    ? 10
                                    : data.topics.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        if (_topicsListIndex.contains(index)) {
                                          _topicsListIndex.remove(index);
                                        } else {
                                          _topicsListIndex.add(index);
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(right: 13, top: 13),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 13, vertical: 3),
                                        decoration: BoxDecoration(
                                            color: _topicsListIndex
                                                    .contains(index)
                                                ? Colors.green.shade600
                                                : context
                                                        .read<ThemeProvider>()
                                                        .isDark
                                                    ? Color.fromARGB(
                                                        255, 34, 34, 34)
                                                    : Color.fromARGB(
                                                        255, 244, 244, 244),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              data.topics[index],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Icon(
                                              _topicsListIndex.contains(index)
                                                  ? Icons.check
                                                  : Icons.add,
                                              size: 18,
                                              color: _topicsListIndex
                                                      .contains(index)
                                                  ? Colors.white
                                                  : Colors.green.shade600,
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              ..add(Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    child: Row(
                                      children: [
                                        Text('Show all topics'),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rooms To Join',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.green.shade600,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('JURY DUTY'),
                                            Text(
                                              'Thursday - 5:00 PM',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      'join',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.red.shade600,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('THE MAX WAVE'),
                                            Text(
                                              '12/06/2020 - 12:00 PM',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      'join',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.cyan,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('COME PLAY'),
                                            Text(
                                              'Wednesday - 8:00 AM',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      'join',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'People You May Know',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.green.shade600,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Zizo Pola'),
                                            Text(
                                              'your preception of the world is the best',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      'follow',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.red.shade600,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Jwan Polus'),
                                            Text(
                                              'NEVER GIVE UP',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      'follow',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.cyan,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Cardy Neon'),
                                                Text(
                                                  'sometimes you have to take a break, but never do it',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      'follow',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.red.shade600,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Jwan Polus'),
                                            Text(
                                              'NEVER GIVE UP',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      'follow',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ));
  }
}
