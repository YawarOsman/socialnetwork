import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../helper/helper.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../submodels/style.dart';
import '../widgets/reusableWidgets.dart';
import 'signupOTP.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Style style = Style();
  final TextEditingController _usernameController =
      TextEditingController(text: 'yara');
  final TextEditingController _emailController =
      TextEditingController(text: 'hunarmandanymilly@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'Test333@');
  final FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _usernameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwrodKey = GlobalKey<FormState>();
  ReusableWidgets reusableWidgets = ReusableWidgets();
  Helper helper = Helper();
  bool _passwordVisible = false;
  bool _passwordFocused = false;
  bool isEmailUsed = false;
  String errorMessage = '';
  var uuid = Uuid();

  @override
  void initState() {
    super.initState();
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
        builder: (context, data, log, child) => Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.08),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              child: Form(
                  key: _usernameKey,
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    }),
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
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
                  key: _emailKey,
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    }),
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
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    }),
                    focusNode: _passwordFocusNode,
                    onChanged: (value) {
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
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                      ),
                      focusedBorder: style.focusedBorder,
                      enabledBorder: style.enabledBorder,
                      border: style.enabledBorder,
                      errorBorder: style.errorBorder,
                    ),
                  )),
            ),
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
              height: 15,
            ),
            GestureDetector(
              onTap: () async {
                if (_usernameKey.currentState!.validate() &&
                    _emailKey.currentState!.validate() &&
                    _passwrodKey.currentState!.validate()) {
                  try {
                    final isEmailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailController.text);
                    final isPasswordValid = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                        .hasMatch(_passwordController.text);
                    if (!isEmailValid) {
                      errorMessage = ' Email is not valid';
                      return;
                    }
                    if (!isPasswordValid) {
                      errorMessage = ' Password is not valid';
                      return;
                    }
                    if (_usernameController.text.length < 3) {
                      errorMessage =
                          ' Username have to be at least 3 characters';
                      return;
                    }

                    reusableWidgets.showLoadingDialog(context);

                    await Amplify.Auth.signOut();
                    final _isEmailUsed = await Amplify.Auth.signIn(
                            username: _emailController.text, password: '123')
                        .then((value) async {
                      await Amplify.Auth.signOut();
                      return false;
                    }).catchError((error) {
                      if (error.toString().contains('NotAuthorizedException')) {
                        return true;
                      } else if (error
                          .toString()
                          .contains('UserNotFoundException')) {
                        return false;
                      } else {
                        return false;
                      }
                    });

                    if (!_isEmailUsed) {
                      final userAttributes = <CognitoUserAttributeKey, String>{
                        CognitoUserAttributeKey.preferredUsername:
                            _usernameController.text,
                      };
                      final result = await Amplify.Auth.signUp(
                        username: _emailController.text,
                        password: _passwordController.text,
                        options: CognitoSignUpOptions(
                            userAttributes: userAttributes),
                      ).then(((value) async {
                        print('ttttttttttt');
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInOTP(
                                      email: _emailController.text,
                                      username: _usernameController.text,
                                      password: _passwordController.text,
                                    )));
                      })).catchError((error) {
                        // here we can check if user already exists or not
                        if (error
                            .toString()
                            .contains('UsernameExistsException')) {
                          setState(() {
                            errorMessage = 'This email has already been used';
                            print(errorMessage);
                          });
                        } else if (error
                            .toString()
                            .contains('InvalidStateException')) {
                          setState(() {
                            errorMessage = 'This email is not valid';
                            print(errorMessage);
                          });
                        } else {
                          print(error);
                          setState(() {
                            errorMessage = 'An error occured please try again';
                          });
                        }

                        Navigator.pop(context);
                        return error;
                      }).onError((error, stackTrace) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Error'),
                                  content: Text(
                                      'An error has occurred, please ty again'),
                                ));

                        return null;
                      });
                    } else {
                      setState(() {
                        errorMessage = 'This email has already been used';
                      });
                    }
                    Navigator.pop(context);
                  } on AuthException catch (e) {
                    debugPrint('signup error: ${e.message}');
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
                    'Sig Up',
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
                          color: Theme.of(context).primaryColor, fontSize: 12),
                      text: 'Already have an account? Please ',
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                            text: 'Sig In',
                            style: TextStyle(
                                color: Theme.of(context).focusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11))
                      ]),
                )),
          ]),
        ),
      ),
    );
  }
}
