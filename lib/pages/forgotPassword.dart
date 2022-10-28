import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../submodels/style.dart';
import '../widgets/reusableWidgets.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

enum forgotPasswordPages { email, password, code }

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  Style style = Style();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final _emailKey = GlobalKey<FormState>();
  final _password1Key = GlobalKey<FormState>();
  final _password2Key = GlobalKey<FormState>();
  final _otpKey = GlobalKey<FormState>();
  final FocusNode _otpFocusNode = FocusNode();
  ReusableWidgets reusableWidgets = ReusableWidgets();

  bool _passwordVisible1 = true;
  bool _passwordVisible2 = true;

  String _errorMessage = '';
  dynamic _forgotPageState = forgotPasswordPages.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (_forgotPageState == forgotPasswordPages.email)
            SizedBox(
              child: Form(
                  key: _emailKey,
                  child: TextFormField(
                    validator: (value) {
                      return value!.isEmpty
                          ? 'Email field must not be empty'
                          : null;
                    },
                    onChanged: (value) => setState(() {
                      _errorMessage = '';
                    }),
                    controller: _emailController,
                    cursorColor: Theme.of(context).focusColor,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      isDense: true,
                      focusedBorder: style.focusedBorder,
                      enabledBorder: style.focusedBorder,
                      border: style.enabledBorder,
                      errorBorder: style.errorBorder,
                    ),
                  )),
            ),
          if (_forgotPageState == forgotPasswordPages.password)
            Column(
              children: [
                SizedBox(
                  child: Form(
                      key: _password1Key,
                      child: TextFormField(
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Password field must not be empty'
                              : null;
                        },
                        cursorColor: Theme.of(context).focusColor,
                        onChanged: (value) {
                          setState(() {
                            _errorMessage = '';
                          });
                        },
                        controller: _passwordController1,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: _passwordVisible1,
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          isDense: true,
                          suffixIcon: Visibility(
                            visible: _passwordController1.text.isNotEmpty,
                            child: InkWell(
                              child: Icon(
                                _passwordVisible1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: Theme.of(context).focusColor,
                              ),
                              onTap: () {
                                _passwordVisible1 = !_passwordVisible1;
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
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: Form(
                      key: _password2Key,
                      child: TextFormField(
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Password field must not be empty'
                              : null;
                        },
                        cursorColor: Theme.of(context).focusColor,
                        onChanged: (value) {
                          _errorMessage = '';
                          setState(() {});
                        },
                        controller: _passwordController2,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: _passwordVisible2,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          isDense: true,
                          suffixIcon: Visibility(
                            visible: _passwordController2.text.isNotEmpty,
                            child: InkWell(
                              child: Icon(
                                _passwordVisible2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: Theme.of(context).focusColor,
                              ),
                              onTap: () {
                                _passwordVisible2 = !_passwordVisible2;
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
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          if (_forgotPageState == forgotPasswordPages.code)
            SizedBox(
              child: Form(
                  key: _otpKey,
                  child: TextFormField(
                    focusNode: _otpFocusNode,
                    validator: (value) {
                      return value!.isEmpty
                          ? 'otp field must not be empty'
                          : null;
                    },
                    onChanged: (value) => setState(() {
                      _errorMessage = '';
                      if (value.length == 6) {
                        _otpFocusNode.unfocus();
                        return;
                      }
                      if (value.length > 6) {
                        _otpController.text = value.substring(0, 6);
                        _otpController.selection =
                            TextSelection.fromPosition(TextPosition(offset: 6));
                      }
                    }),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 15,
                      fontSize: 25,
                    ),
                    controller: _otpController,
                    cursorColor: Theme.of(context).focusColor,
                    decoration: InputDecoration(
                      hintText: 'OTP Code',
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      hintStyle: TextStyle(
                          letterSpacing: 1,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      isDense: true,
                      focusedBorder: style.focusedBorder,
                      enabledBorder: style.enabledBorder,
                      border: style.enabledBorder,
                      errorBorder: style.errorBorder,
                    ),
                  )),
            ),
          if (_errorMessage.isNotEmpty)
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  try {
                    if (_forgotPageState == forgotPasswordPages.email) {
                      _emailKey.currentState!.validate();
                      if (_emailController.text.isEmpty) return;

                      final isEmailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_emailController.text);
                      if (!isEmailValid) {
                        setState(() {
                          _errorMessage = 'Email is not valid';
                        });
                        return;
                      }
                      reusableWidgets.showLoadingDialog(context);
                      await Amplify.Auth.resetPassword(
                        username: _emailController.text,
                      ).then((value) {
                        setState(() {
                          _forgotPageState = forgotPasswordPages.password;
                        });
                      });
                      Navigator.pop(context);
                    } else if (_forgotPageState ==
                        forgotPasswordPages.password) {
                      _password1Key.currentState!.validate();
                      _password2Key.currentState!.validate();
                      if (_passwordController1.text.isEmpty ||
                          _passwordController2.text.isEmpty) return;

                      final isPassword1Valid = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(_passwordController1.text);

                      if (!isPassword1Valid) {
                        setState(() {
                          _errorMessage = 'Password is not valid';
                        });
                        return;
                      }
                      if (_passwordController1.text !=
                          _passwordController2.text) {
                        setState(() {
                          _errorMessage = 'Passwords do not match';
                        });
                        return;
                      }
                      _forgotPageState = forgotPasswordPages.code;
                      setState(() {});
                    } else if (_forgotPageState == forgotPasswordPages.code) {
                      reusableWidgets.showLoadingDialog(context);

                      if (_otpController.text.isEmpty) return;
                      await Amplify.Auth.confirmResetPassword(
                              username: _emailController.text,
                              newPassword: _passwordController1.text,
                              confirmationCode: _otpController.text)
                          .then((value) {
                        setState(() {});
                      }).catchError((error) {
                        final code =
                            error.toString().contains('CodeExpiredException');
                        if (code) {
                          _errorMessage = 'Invalid OTP';
                          setState(() {});
                        }
                      });
                      Navigator.popUntil(
                          context, ModalRoute.withName('/signin'));
                    }
                  } on AuthException catch (e) {
                    debugPrint(e.message);
                  }
                },
                child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2 - 54,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).focusColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                width: 15,
              ),
              Visibility(
                visible: _forgotPageState == forgotPasswordPages.code,
                child: InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () async {
                    try {
                      _otpController.clear();
                      await Amplify.Auth.resetPassword(
                        username: _emailController.text,
                      );
                    } on AuthException catch (e) {
                      debugPrint(e.message);
                    }
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2 - 54,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).focusColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
