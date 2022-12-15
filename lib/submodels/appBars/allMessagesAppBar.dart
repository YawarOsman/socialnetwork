import 'package:flutter/material.dart';

import '../../pages/searchDetails.dart';

class AllMessagesAppBar extends StatefulWidget {
  const AllMessagesAppBar({Key? key}) : super(key: key);

  @override
  State<AllMessagesAppBar> createState() => _AllMessagesAppBarState();
}

class _AllMessagesAppBarState extends State<AllMessagesAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme,
      titleTextStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: 17),
      elevation: 1,
      automaticallyImplyLeading: false,
      toolbarHeight: 47,
      titleSpacing: 18,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
            ),
          ),
          const Text('Messages'),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/searchForUsers');
              },
              child: Icon(Icons.search))
        ],
      ),
    );
  }
}
