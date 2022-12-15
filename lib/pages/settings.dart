import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../provider/themeProvider.dart';
import '../submodels/classModels/enums.dart';
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
  late int _themeModeIndexTemporary;

  @override
  void initState() {
    super.initState();
    updateThemeModeIndex();
  }

  void updateThemeModeIndex() async {
    await context.read<Log>().getThemeModeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<Data, Log, ThemeProvider>(
        builder: (context, data, log, themeProvider, child) => Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme,
              titleTextStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color),
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
                const SizedBox(width: 13),
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
                    const Text(
                      'Notificatios',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Notifications(
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
                    Notifications(context, [
                      'Message Notifications',
                      'Messages Relating To Chats'
                    ], (bool value) {
                      _messageNotifications = !_messageNotifications;
                      setState(() {});
                    }, _messageNotifications),
                    Notifications(context, [
                      'Room Notifications',
                      'All Messages Relating To Rooms'
                    ], (bool value) {
                      _roomNotifications = !_roomNotifications;
                      setState(() {});
                    }, _roomNotifications),
                    Notifications(context, [
                      'Other Notifications',
                      'Events, New Followers, etc.'
                    ], (bool value) {
                      _otherNotifications = !_otherNotifications;
                      setState(() {});
                    }, _otherNotifications),
                    Notifications(context, [
                      'Fewer Notifications',
                      'This Will Send You Only Important Notifications'
                    ], (bool value) {
                      _fewerNotifications = !_fewerNotifications;
                      setState(() {});
                    }, _fewerNotifications),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'App Preferences',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    reusableWidgets.AppPreferences(
                        context,
                        log.themeModeIndex == 0
                            ? 'Dark Mode'
                            : log.themeModeIndex == 1
                                ? 'Light Mode'
                                : 'System Mode', () {
                      _themeModeIndexTemporary = log.themeModeIndex;
                      print(log.themeModeIndex);
                      showDialog(
                        context: context,
                        builder: (ctx) => StatefulBuilder(
                          builder: (context, setState) => AlertDialog(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            contentPadding: const EdgeInsets.only(bottom: 0),
                            actionsPadding: const EdgeInsets.only(top: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            content: Container(
                              margin: const EdgeInsets.only(
                                  top: 13, left: 13, right: 13),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    margin: const EdgeInsets.only(bottom: 8),
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
                                            : const SizedBox()
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    margin: const EdgeInsets.only(bottom: 8),
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
                                            : const SizedBox()
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    margin: const EdgeInsets.only(bottom: 10),
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
                                            : const SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (_themeModeIndexTemporary == 0) {
                                          themeProvider
                                              .setIsDark(AppTheme.dark);
                                        } else if (_themeModeIndexTemporary ==
                                            1) {
                                          themeProvider
                                              .setIsDark(AppTheme.light);
                                        } else if (_themeModeIndexTemporary ==
                                            2) {
                                          final sysMode = MediaQuery.of(context)
                                              .platformBrightness;
                                          themeProvider
                                              .setIsDark(AppTheme.system);
                                        }
                                        log.setThemeModeIndex(
                                            _themeModeIndexTemporary);

                                        updateThemeModeIndex();
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Theme.of(context).cardColor),
                                        child: const Text('Apply'),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        log.setThemeModeIndex(
                                            _themeModeIndexTemporary);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Theme.of(context).cardColor),
                                        child: const Text('Cancel'),
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
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: themeProvider.isDark
                                  ? const Color.fromARGB(255, 34, 34, 34)
                                  : const Color.fromARGB(255, 244, 244, 244)),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 5),
                            child: const Text(
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

  Container Notifications(
      BuildContext context, List text, Function? callback(bool val),
      [bool? switchValue]) {
    return Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: context.read<ThemeProvider>().isDark
                ? const Color.fromARGB(255, 34, 34, 34)
                : const Color.fromARGB(255, 244, 244, 244)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  text[1] != null
                      ? Text(
                          text[1],
                          style: const TextStyle(fontSize: 10),
                        )
                      : const SizedBox()
                ],
              ),
              switchValue != null
                  ? FlutterSwitch(
                      width: 40,
                      height: 24,
                      padding: 2,
                      toggleSize: 20,
                      value: switchValue,
                      onToggle: callback,
                    )
                  : const SizedBox()
            ],
          ),
        ));
  }
}
