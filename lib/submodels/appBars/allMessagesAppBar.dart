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
                          transitionDuration: Duration(milliseconds: 0),
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
        ));
  }
}
