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
      elevation: 1,
      leadingWidth: 40,
      toolbarHeight: 40,
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
    );
  }
}
