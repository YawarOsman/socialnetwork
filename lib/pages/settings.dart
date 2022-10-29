import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';
import '../provider/log.dart';
import '../widgets/reusableWidgets.dart';
import 'signin.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ReusableWidgets reusableWidgets = ReusableWidgets();
  bool _pushNotifications = true;
  bool _messageNotifications = true;
  bool _roomNotifications = true;
  bool _otherNotifications = true;
  bool _fewerNotifications = false;
  int _themeModeIndex = 2;
  late int _themeModeIndexTemporary;

  @override
  void initState() {
    super.initState();
    updateThemeModeIndex();
  }

  void updateThemeModeIndex() async {
    _themeModeIndex = context.read<Log>().themeModeIndex;
    _themeModeIndex = await context.read<Log>().getThemeModeIndex;
    _themeModeIndexTemporary = _themeModeIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Data, Log>(
        builder: (context, data, log, child) => Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme,
              textTheme: Theme.of(context).textTheme,
              actions: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(width: 13),
              ],
              toolbarHeight: 40,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notificatios',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    reusableWidgets.Notifications(
                        context, ['Push Notifications', 'All Notifications'],
                        (bool value) {
                      _pushNotifications = !_pushNotifications;
                      if (_pushNotifications == false) {
                        _messageNotifications = false;
                        _roomNotifications = false;
                        _otherNotifications = false;
                      } else {
                        _messageNotifications = true;
                        _roomNotifications = true;
                        _otherNotifications = true;
                      }
                      setState(() {});
                    }, _pushNotifications),
                    reusableWidgets.Notifications(context, [
                      'Message Notifications',
                      'Messages Relating To Chats'
                    ], (bool value) {
                      _messageNotifications = !_messageNotifications;
                      setState(() {});
                    }, _messageNotifications),
                    reusableWidgets.Notifications(context, [
                      'Room Notifications',
                      'All Messages Relating To Rooms'
                    ], (bool value) {
                      _roomNotifications = !_roomNotifications;
                      setState(() {});
                    }, _roomNotifications),
                    reusableWidgets.Notifications(context, [
                      'Other Notifications',
                      'Events, New Followers, etc.'
                    ], (bool value) {
                      _otherNotifications = !_otherNotifications;
                      setState(() {});
                    }, _otherNotifications),
                    reusableWidgets.Notifications(context, [
                      'Fewer Notifications',
                      'This Will Send You Only Important Notifications'
                    ], (bool value) {
                      _fewerNotifications = !_fewerNotifications;
                      setState(() {});
                    }, _fewerNotifications),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'App Preferences',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    reusableWidgets.AppPreferences(
                        context,
                        _themeModeIndex == 0
                            ? 'Dark Mode'
                            : _themeModeIndex == 1
                                ? 'Light Mode'
                                : 'System Mode', () {
                      _themeModeIndexTemporary = _themeModeIndex;
                      print(_themeModeIndex);
                      showDialog(
                        context: context,
                        builder: (ctx) => StatefulBuilder(
                          builder: (context, setState) => AlertDialog(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            contentPadding: EdgeInsets.only(bottom: 0),
                            actionsPadding: EdgeInsets.only(top: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            content: Container(
                              margin:
                                  EdgeInsets.only(top: 13, left: 13, right: 13),
                              height: 185,
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(children: [
                                GestureDetector(
                                  onTap: () {
                                    _themeModeIndexTemporary = 0;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 35,
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 13),
                                    margin: EdgeInsets.only(bottom: 8),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Dark Mode',
                                          style: TextStyle(
                                              color:
                                                  _themeModeIndexTemporary == 0
                                                      ? Colors.green.shade600
                                                      : Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color),
                                        ),
                                        _themeModeIndexTemporary == 0
                                            ? Icon(Icons.check,
                                                color: Colors.green.shade600)
                                            : SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _themeModeIndexTemporary = 1;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 35,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 13),
                                    margin: EdgeInsets.only(bottom: 8),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Light Mode',
                                            style: TextStyle(
                                                color:
                                                    _themeModeIndexTemporary ==
                                                            1
                                                        ? Colors.green.shade400
                                                        : Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .color)),
                                        _themeModeIndexTemporary == 1
                                            ? Icon(Icons.check,
                                                color: Colors.green.shade600)
                                            : SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _themeModeIndexTemporary = 2;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 35,
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 13),
                                    margin: EdgeInsets.only(bottom: 10),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'System Mode',
                                          style: TextStyle(
                                              color:
                                                  _themeModeIndexTemporary == 2
                                                      ? Colors.green.shade400
                                                      : Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color),
                                        ),
                                        _themeModeIndexTemporary == 2
                                            ? Icon(Icons.check,
                                                color: Colors.green.shade600)
                                            : SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (_themeModeIndexTemporary == 0) {
                                          log.setIsDark(true);
                                        } else if (_themeModeIndexTemporary ==
                                            1) {
                                          log.setIsDark(false);
                                        } else if (_themeModeIndexTemporary ==
                                            2) {
                                          final sysMode = MediaQuery.of(context)
                                              .platformBrightness;
                                          log.setIsDark(
                                              sysMode == Brightness.dark);
                                        }
                                        print(_themeModeIndexTemporary);
                                        log.setThemeModeIndex(
                                            _themeModeIndexTemporary);

                                        updateThemeModeIndex();
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Theme.of(context).cardColor),
                                        child: Text('Apply'),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        _themeModeIndex =
                                            _themeModeIndexTemporary;
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Theme.of(context).cardColor),
                                        child: Text('Cancel'),
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ),
                      );
                    }),
                    reusableWidgets.AppPreferences(context, 'Languages', () {}),
                    reusableWidgets.AppPreferences(
                        context, 'Terms And Services', () {}),
                    reusableWidgets.AppPreferences(
                        context, 'Privacy Policy', () {}),
                    GestureDetector(
                      onTap: () async {
                        try {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                              (route) => false);
                          await Amplify.Auth.signOut();
                          log.setIsLoggedIn(false);
                          data.removeEmail();
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: log.isDark
                                  ? Color.fromARGB(255, 34, 34, 34)
                                  : Color.fromARGB(255, 244, 244, 244)),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 5),
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            )));
  }
}
