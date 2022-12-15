import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:socialnetwork/provider/themeProvider.dart';
import 'package:uuid/uuid.dart';
import '../models/Users.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../widgets/reusableWidgets.dart';

class SignInOTP extends StatefulWidget {
  SignInOTP(
      {super.key,
      required this.email,
      required this.password,
      required this.username});
  String username;
  String email;
  String password;

  @override
  State<SignInOTP> createState() => _SignInOTPState();
}

class _SignInOTPState extends State<SignInOTP> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  ReusableWidgets reusableWidgets = ReusableWidgets();
  bool isTimedOut = false;
  String errorMessage = '';
  final uuid = const Uuid();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void signIn() async {
    try {
      final data = Provider.of<Data>(context, listen: false);

      await Amplify.Auth.signIn(
              username: widget.email, password: widget.password)
          .then((value) {
        Navigator.popUntil(context, ModalRoute.withName('/home'));
        Navigator.pushNamed(context, '/home');
      });
      final newUser = Users(
        userId: uuid.v1(),
        userName: widget.username,
        email: widget.email,
      );
      await Amplify.DataStore.save(newUser);
      data.setUserData(newUser);
      print(data);
      //todo
      data.setProfileImage();
    } on DataStoreException catch (e) {
      debugPrint(e.toString());
      //todo, show error message and then pop this page
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Data, Log>(
      builder: (context, data, log, child) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.08),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 60,
              width: 250,
              alignment: Alignment.center,
              child: Form(
                  child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                onChanged: (value) {
                  if (value.length == 6) {
                    _otpFocusNode.unfocus();
                    return;
                  }
                  if (value.length > 6) {
                    _otpController.text = value.substring(0, 6);
                    _otpController.selection = TextSelection.fromPosition(
                        const TextPosition(offset: 6));
                  }
                },
                focusNode: _otpFocusNode,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(fontSize: 35, letterSpacing: 13),
                controller: _otpController,
                cursorColor: Colors.grey.shade400,
                decoration: InputDecoration(
                    isDense: true,
                    hintText: 'OTP',
                    hintStyle: TextStyle(
                        letterSpacing: 0,
                        fontSize: 30,
                        color: Colors.grey.shade500),
                    filled: true,
                    fillColor: context.read<ThemeProvider>().isDark
                        ? Colors.grey.shade800
                        : Colors.black12,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 0))),
              )),
            ),
            const SizedBox(
              height: 15,
            ),
            if (isTimedOut)
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    'The OTP code is invalid or expired',
                    style: TextStyle(fontSize: 13, color: Colors.red.shade600),
                  )),
            if (!isTimedOut)
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    '2:45',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )),
            if (errorMessage.isNotEmpty)
              Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).focusColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          if (_otpController.text.isNotEmpty) {
                            reusableWidgets.loadingDialog(context);
                            Amplify.Auth.confirmSignUp(
                                    username: widget.email,
                                    confirmationCode: _otpController.text)
                                .then((value) async {
                              try {
                                final data =
                                    Provider.of<Data>(context, listen: false);

                                await Amplify.Auth.signIn(
                                        username: widget.email,
                                        password: widget.password)
                                    .then((value) {
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/home'));
                                  Navigator.pushNamed(context, '/home');
                                });
                                final newUser = Users(
                                  userId: uuid.v1(),
                                  userName: widget.username,
                                  email: widget.email,
                                );
                                await Amplify.DataStore.save(newUser);
                                data.setUserData(newUser);
                                //todo
                                data.setProfileImage();
                              } on DataStoreException catch (e) {
                                debugPrint('opt signin error:${e.toString()}');
                                //todo, show error message and then pop this page
                                return;
                              }

                              Navigator.popUntil(
                                  context, ModalRoute.withName('/home'));
                              Navigator.pushNamed(context, '/home');
                              data.setEmail(widget.email);
                              log.setIsLoggedIn(true);
                              if (await log.getIsFirstTime) {
                                log.setIsFirstTime(false);
                              }
                            }).catchError((error) {
                              errorMessage = '';
                              if (error
                                  .toString()
                                  .contains('CodeMismatchException')) {
                                setState(() => errorMessage =
                                    'The OTP code is invalid or expired');
                              } else if (error
                                  .toString()
                                  .contains('NotAuthorizedException')) {
                                setState(() => errorMessage =
                                    'The OTP code is invalid or expired');
                              }
                              debugPrint('error catched in otp:$error');
                            });
                          } else {
                            setState(() =>
                                errorMessage = 'Please enter the OTP code');
                          }
                          Navigator.pop(context);
                        } on AuthException catch (e) {
                          debugPrint('signup error: ${e.message}');
                        }
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).focusColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          Amplify.Auth.resendSignUpCode(
                              username: widget.email);
                          print('done resent otp:');
                        } on AuthException catch (e) {
                          debugPrint('signup error: ${e.message}');
                        }
                      },
                      child: Text(
                        'Resend',
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
