import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/data.dart';

class MainAppBar extends StatefulWidget {
  MainAppBar({Key? key, required this.theme}) : super(key: key);
  final ThemeData theme;

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  String _profileImage = '';

  @override
  Widget build(BuildContext context) {
    //todo fix this(maybe bring this to initState)
    _profileImage = Provider.of<Data>(context, listen: false).profileImage;

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child:
                  //  _profileImage != ''
                  //     ? CircleAvatar(
                  //         radius: 17.0,
                  //         backgroundImage: CachedNetworkImageProvider(
                  //           _profileImage,
                  //           errorListener: () {},
                  //         ),
                  //       )
                  //     :
                  CircleAvatar(
                radius: 17.0,
                backgroundColor: Colors.grey.shade400,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            SizedBox(
              width: 11,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: () {
                Navigator.pushNamed(context, '/allmessages');
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  Icons.message_outlined,
                  size: 22,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  Icons.search_sharp,
                  size: 23,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ]),
          Text(
            'App House',
            style: TextStyle(
                color: widget.theme.textTheme.bodyText1!.color,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
      titleSpacing: 13,
      leadingWidth: 0,
      toolbarHeight: 47,
      automaticallyImplyLeading: false,
      iconTheme: widget.theme.iconTheme,
      toolbarTextStyle: TextStyle(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white),
    );
  }
}
