import 'package:flutter/material.dart';

class CreateRoom extends StatelessWidget {
  final void Function() onCreateMeetingButtonPressed;
  CreateRoom({Key? key, required this.onCreateMeetingButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Room'),
      content: Text('Do you want to create a room?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        TextButton(onPressed: onCreateMeetingButtonPressed, child: Text('Yes')),
      ],
    );
    ;
  }
}
