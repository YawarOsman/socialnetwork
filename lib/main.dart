import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'helper/helper.dart';
import 'pages/forgotPassword.dart';
import 'pages/allMessages.dart';
import 'pages/home.dart';
import 'pages/profile.dart';
import 'pages/search.dart';
import 'pages/searchForUsers.dart';
import 'pages/settings.dart';
import 'pages/sigInWithPhone.dart';
import 'pages/signin.dart';
import 'pages/signup.dart';
import 'pages/userMessages.dart';
import 'provider/data.dart';
import 'provider/log.dart';

bool isFirstTime = true;
bool isDark = false;
bool isLoggedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }
  runApp(MultiProvider(providers: [
    ListenableProvider(create: (context) => Data()),
    ListenableProvider(create: (context) => Log()),
    ListenableProvider(create: (context) => Helper()),
  ], child: MainWidget()));
}

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    super.initState();

    getLogData();
  }

  getLogData() async {
    isDark = await context.read<Log>().getIsDark;
    isFirstTime = await context.read<Log>().getIsFirstTime;
    isLoggedIn = await context.read<Log>().getIsLoggedIn;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English Tech',
      theme: ThemeData(
          // primarySwatch: Colors.green,

          splashColor: Colors.transparent,
          primaryColor: Color.fromARGB(255, 116, 116, 116),
          accentColor: Color.fromARGB(255, 165, 165, 165),
          focusColor: Colors.blue.shade600,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.light(primary: Colors.blue.shade600),
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          cardColor: Color.fromARGB(255, 244, 244, 244)),
      darkTheme: ThemeData(
        // primarySwatch: Colors.orange,
        splashColor: Colors.transparent,
        primaryColor: Color.fromARGB(255, 125, 125, 125),
        accentColor: Color.fromARGB(255, 145, 145, 145),
        focusColor: Colors.blue.shade600,
        scaffoldBackgroundColor: Color.fromARGB(255, 24, 24, 24),
        colorScheme: ColorScheme.dark(primary: Colors.blue.shade600),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
        appBarTheme:
            AppBarTheme(backgroundColor: Color.fromARGB(255, 24, 24, 24)),
        cardColor: Color.fromARGB(255, 34, 34, 34),
      ),
      themeMode:
          Provider.of<Log>(context).isDark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/phone': (context) => SignInWithPhone(),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/settings': (context) => Settings(),
        '/search': (context) => Search(),
        '/messages': (context) => AllMessages(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/forgotpassword': (context) => ForgotPassword(),
        '/chat': (context) => UserMessages(),
        '/searchForUsers': (context) => SearchForUsers(),
      },
      home: Provider.of<Log>(context).isLoggedIn ? Home() : SignIn(),
    );
  }
}
