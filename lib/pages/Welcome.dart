// import 'package:amplify_api/amplify_api.dart';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
// import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helper/helper.dart';
import '../provider/data.dart';
import '../widgets/reusableWidgets.dart';

class Welcome extends StatefulWidget {
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  ReusableWidgets reusableWidgets = ReusableWidgets();
  late MediaQueryData mediaQueryData;
  late double swidth;
  late double sheight;
  late ThemeData theme;
  Helper helper = Helper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    swidth = mediaQueryData.size.width;
    sheight = mediaQueryData.size.height;
    theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Text(
              'Welcome to App House',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Text(
                  'App House',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade600),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
                child: Text(
                  'this is an online application to learn english and communication withpeople all over the world and learn other languages',
                  style: TextStyle(
                      fontSize: 13, color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                'login with',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Navigator.pushNamed(context, '/signin');
                },
                child: Container(
                  width: swidth / 2.5,
                  height: 33,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: theme.iconTheme.color,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    'Email & Password',
                    style: TextStyle(color: theme.scaffoldBackgroundColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: Container(
                  width: swidth / 2.5,
                  height: 33,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: theme.iconTheme.color,
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          width: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Google',
                          style:
                              TextStyle(color: theme.scaffoldBackgroundColor),
                        )
                      ]),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
