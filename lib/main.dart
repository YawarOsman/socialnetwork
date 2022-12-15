import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:socialnetwork/provider/isAmplifyConfigured.dart';
import 'helper/helper.dart';
import 'pages/forgotPassword.dart';
import 'pages/allMessages.dart';
import 'pages/home.dart';
import 'pages/search.dart';
import 'pages/searchForUsers.dart';
import 'pages/settings.dart';
import 'pages/sigInWithPhone.dart';
import 'pages/signin.dart';
import 'pages/signup.dart';
import 'provider/data.dart';
import 'provider/log.dart';
import 'provider/roomStates.dart';
import 'provider/themeProvider.dart';
import 'submodels/classModels/enums.dart';

bool isFirstTime = true;
bool isDark = false;
bool isLoggedIn = false;
late Log log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  runApp(MultiProvider(providers: [
    ListenableProvider(create: (context) => Data()),
    ListenableProvider(create: (context) => Log()),
    ListenableProvider(create: (context) => Helper()),
    ListenableProvider(create: (context) => ThemeProvider()),
    ListenableProvider(create: (context) => RoomStates()),
    ListenableProvider(create: (context) => IsAmplifyConfigured()),
  ], child: const MainWidget()));
}

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final Helper helper = Helper();

  @override
  void initState() {
    super.initState();
    log = context.read<Log>();

    log.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //this
        if (context.read<ThemeProvider>().isDark) {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            systemNavigationBarColor: Color.fromARGB(255, 24, 24, 24),
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
          ));
        } else {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white,
          ));
        }
      });
    });

    getTheme();
    getLogData();
    envLoad();
    configureAmplify();
  }

  void envLoad() async {
    await dotenv.load();
  }

  configureAmplify() async {
    await helper.configureAmplify().then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<IsAmplifyConfigured>().setIsAmplifyConfigured = true;
      });
    });
  }

  getLogData() async {
    if (!mounted) return;
    isDark = await context.read<ThemeProvider>().isDark;
    isFirstTime = await context.read<Log>().getIsFirstTime;
    isLoggedIn = await context.read<Log>().getIsLoggedIn;
    setState(() {});
  }

  void getTheme() async {
    final appThemeString = await context.read<ThemeProvider>().getIsDark;
    AppTheme appTheme;

    switch (appThemeString) {
      case 'AppTheme.light':
        appTheme = AppTheme.light;
        break;
      case 'AppTheme.dark':
        appTheme = AppTheme.dark;
        break;
      default:
        appTheme = AppTheme.system;
    }
    context.read<ThemeProvider>().setIsDark(appTheme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social App',
      theme: context.watch<ThemeProvider>().lightTheme,
      darkTheme: context.watch<ThemeProvider>().darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/phone': (context) => SignInWithPhone(),
        '/home': (context) => Home(),
        '/settings': (context) => const Settings(),
        '/search': (context) => const Search(),
        '/allmessages': (context) => const AllMessages(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/forgotpassword': (context) => ForgotPassword(),
        '/searchForUsers': (context) => const SearchForUsers(),
      },
      home: Provider.of<Log>(context).isLoggedIn ? Home() : SignIn(),
    );
  }
}
