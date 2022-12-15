import 'package:flutter/material.dart';

import '../../provider/log.dart';

class ProfileAppBar extends StatelessWidget {
  ProfileAppBar({super.key, required this.log});
  Log log;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green.shade700, Colors.green.shade400]),
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.bookmark_outline,
                size: 25,
              ),
            ),
            const SizedBox(
              width: 17,
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                log.deviceType == TargetPlatform.iOS
                    ? Icons.ios_share_outlined
                    : Icons.share_outlined,
                size: 25,
              ),
            ),
            const SizedBox(
              width: 17,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Icon(
                Icons.settings_outlined,
                size: 25,
              ),
            ),
          ]),
        ),
      ],
      iconTheme: Theme.of(context).iconTheme,
      toolbarTextStyle:
          TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
      toolbarHeight: 40,
      titleSpacing: 0,
    );
  }
}
