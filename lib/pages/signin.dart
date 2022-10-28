import 'dart:typed_data';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/helper.dart';
import '../models/Users.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../submodels/style.dart';
import '../widgets/reusableWidgets.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Style style = Style();
  final TextEditingController _emailController =
      TextEditingController(text: 'yawarhama@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'Test333@');
  final FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwrodKey = GlobalKey<FormState>();
  ReusableWidgets reusableWidgets = ReusableWidgets();
  bool _passwordVisible = false;
  bool _passwordFocused = false;
  String errorMessage = '';
  Helper helper = Helper();

  @override
  void initState() {
    super.initState();
    helper.configureAmplify();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<Log>().setAmplifyConfigured = true;
    });
    _passwordFocusNode.addListener(() => setState(() {
          _passwordFocused = _passwordFocusNode.hasFocus;
        }));
  }

  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.removeListener(() => setState(() {
          _passwordFocused = _passwordFocusNode.hasFocus;
        }));
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Consumer2<Data, Log>(
          builder: ((context, data, log, child) => Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.08),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Form(
                            key: _emailKey,
                            child: TextFormField(
                              onChanged: (value) => setState(() {
                                errorMessage = '';
                              }),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                isDense: true,
                                focusedBorder: style.focusedBorder,
                                enabledBorder: style.enabledBorder,
                                border: style.enabledBorder,
                                errorBorder: style.errorBorder,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        child: Form(
                            key: _passwrodKey,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              focusNode: _passwordFocusNode,
                              onChanged: (value) {
                                errorMessage = '';
                                if (value.length > 0) {
                                  _passwordFocused = true;
                                } else {
                                  _passwordFocused = false;
                                }
                                setState(() {});
                              },
                              controller: _passwordController,
                              textAlignVertical: TextAlignVertical.center,
                              obscureText: _passwordVisible,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                isDense: true,
                                suffixIcon: Visibility(
                                  visible: _passwordFocused,
                                  child: InkWell(
                                    child: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 20,
                                      color: Theme.of(context).focusColor,
                                    ),
                                    onTap: () {
                                      _passwordVisible = !_passwordVisible;
                                      setState(() {});
                                    },
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                ),
                                focusedBorder: style.focusedBorder,
                                enabledBorder: style.enabledBorder,
                                border: style.enabledBorder,
                                errorBorder: style.errorBorder,
                              ),
                            )),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 6),
                          child: InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () async {
                              Navigator.pushNamed(context, '/forgotpassword');
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 13),
                            ),
                          )),
                      if (errorMessage.isNotEmpty)
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              errorMessage,
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (await data.getInternetConnection ==
                              ConnectivityResult.none) {
                            reusableWidgets.showSnackBarForConnectivity(
                                context, 'No Internet Connection');
                            return;
                          }
                          if (_emailKey.currentState!.validate() &&
                              _passwrodKey.currentState!.validate()) {
                            try {
                              final isEmailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(_emailController.text);
                              final isPasswordValid = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(_passwordController.text);
                              if (!isEmailValid) {
                                setState(() {
                                  errorMessage = 'Email is not valid';
                                });
                                return;
                              }
                              if (!isPasswordValid) {
                                setState(() {
                                  errorMessage = 'Password is not valid';
                                });
                                return;
                              }
                              reusableWidgets.showLoadingDialog(context);

                              final auth =
                                  await Amplify.Auth.fetchAuthSession();
                              if (auth.isSignedIn) {
                                await Amplify.Auth.signOut();
                              }
                              await Amplify.Auth.signIn(
                                      username: _emailController.text,
                                      password: _passwordController.text)
                                  .then((value) async {
                                data.setEmail(_emailController.text);

                                await Amplify.DataStore.query(Users.classType,
                                        where: Users.EMAIL
                                            .eq(_emailController.text))
                                    .then((value) {
                                  data.setUserData(value.first);
                                  //todo
                                  data.setProfileImage();
                                });

                                log.setIsLoggedIn(true);

                                if (await context.read<Log>().getIsFirstTime) {
                                  log.setIsFirstTime(false);
                                }
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  dismissDirection: DismissDirection.down,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  content: Container(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      'logged in successfully',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green.shade400),
                                    ),
                                  ),
                                  duration: Duration(seconds: 2),
                                ));
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/home'));
                                Navigator.pushNamed(context, '/home');

                                return;
                              }).catchError((error) {
                                print('SSSSSSSSSSSSSSSSSSSSSS: ${error}');
                                if (error
                                    .toString()
                                    .contains('UnknownException')) {
                                  setState(() {
                                    errorMessage =
                                        'An error occurred, please try again';
                                    Navigator.pop(context);
                                    _passwordController.clear();
                                  });
                                  Navigator.pop(context);
                                  return;
                                } else if (error
                                    .toString()
                                    .contains('UserNotFoundException')) {
                                  setState(() {
                                    errorMessage =
                                        'The email or password is incorrect';
                                    _passwordController.clear();
                                  });
                                  return;
                                }
                                setState(() {
                                  errorMessage =
                                      'An error occurred, please try again';
                                  Navigator.pop(context);
                                  _passwordController.clear();
                                });
                              });
                            } on AuthException catch (e) {
                              debugPrint(e.message);
                              (context as Element).reassemble();
                            }
                          }
                        },
                        child: Container(
                            width: double.infinity,
                            height: 40,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 70),
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Sig In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12),
                                text: 'Don\'t have an account? Please ',
                                children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, '/signup');
                                        },
                                      text: 'Sig Up',
                                      style: TextStyle(
                                          color: Theme.of(context).focusColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11))
                                ]),
                          )),
                    ]),
              )),
        ));
  }
}
