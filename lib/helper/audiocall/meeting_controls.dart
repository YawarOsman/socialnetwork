import 'package:flutter/material.dart';

class MeetingControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleWebcamButtonPressed;
  final void Function() onLeaveButtonPressed;
  final void Function() onEndButtonPressed;

  const MeetingControls({
    Key? key,
    required this.onToggleMicButtonPressed,
    required this.onToggleWebcamButtonPressed,
    required this.onLeaveButtonPressed,
    required this.onEndButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          child: const Text("End"),
          onPressed: onEndButtonPressed,
        ),
        ElevatedButton(
          child: const Text("Leave"),
          onPressed: onLeaveButtonPressed,
        ),
        ElevatedButton(
          child: const Text("Toggle Mic"),
          onPressed: onToggleMicButtonPressed,
        ),
        ElevatedButton(
          child: const Text("Toggle WebCam"),
          onPressed: onToggleWebcamButtonPressed,
        )
      ],
    );
  }
}
