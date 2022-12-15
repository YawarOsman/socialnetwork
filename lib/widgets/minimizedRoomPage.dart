import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/log.dart';
import '../provider/roomStates.dart';
import '../provider/themeProvider.dart';

class MinimizedRoomPage extends StatelessWidget {
  const MinimizedRoomPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<Log>().setIsRoomPageMinimized = false;
      },
      child: Card(
        elevation: 40,
        margin: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.read<ThemeProvider>().isDark
                  ? const Color.fromARGB(255, 40, 40, 40)
                  : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    children: const [
                      Positioned(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/1.jpeg'),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/2.jpeg'),
                        ),
                      ),
                      Positioned(
                        left: 60,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/3.jpeg'),
                        ),
                      ),
                      Positioned(
                        left: 90,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text('+4'),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Leave',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                )
              ],
            )),
      ),
    );
  }
}
