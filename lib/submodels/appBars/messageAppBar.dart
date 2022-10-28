import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/data.dart';
import '../../provider/log.dart';

class MessageAppBar extends StatefulWidget {
  @override
  State<MessageAppBar> createState() => _MessageAppBarState();
}

class _MessageAppBarState extends State<MessageAppBar> {
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
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: _profileImage != ''
                      ? CircleAvatar(
                          radius: 17.0,
                          backgroundImage: CachedNetworkImageProvider(
                            _profileImage,
                            errorListener: () {},
                          ))
                      : CircleAvatar(
                          radius: 17.0,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpeg'),
                        ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'partners name',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              ],
            ),
          ]),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: Provider.of<Log>(context, listen: false).isDark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
      titleSpacing: 0,
      toolbarHeight: 47,
      iconTheme: Theme.of(context).iconTheme,
      toolbarTextStyle: TextStyle(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white),
    );
  }
}
