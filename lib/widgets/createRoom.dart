import 'package:flutter/material.dart';

class CreateRoom extends StatelessWidget {
  final void Function() onCreateMeetingButtonPressed;
  const CreateRoom({Key? key, required this.onCreateMeetingButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Room'),
      content: const Text('Do you want to create a room?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: onCreateMeetingButtonPressed, child: const Text('Yes')),
      ],
    );
    ;
  }
}
