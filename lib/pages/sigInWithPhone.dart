import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignInWithPhone extends StatefulWidget {
  SignInWithPhone({Key? key}) : super(key: key);

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  late MediaQueryData mediaQueryData;
  late double swidth;
  late double sheight;
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    swidth = mediaQueryData.size.width;
    sheight = mediaQueryData.size.height;
    theme = Theme.of(context);

    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Text(
                'Sign In with phone number',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 70,
                    child: IntlPhoneField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                          text:
                              'By entering your phone number, it means you are agree to our',
                          style: TextStyle(color: Colors.black45),
                          children: [
                        TextSpan(
                            text: ' Terms of Services ',
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(text: 'and '),
                        TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyle(color: Colors.blue)),
                      ])),
                  Text('Thanks', style: TextStyle(color: Colors.black45))
                ],
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.of(context).pushNamed('/home');
              },
              child: Container(
                width: swidth / 2.5,
                height: 33,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: theme.iconTheme.color,
                    borderRadius: BorderRadius.circular(50)),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: theme.iconTheme.color == Colors.black
                        ? Colors.white
                        : Colors.black,
                    size: 20,
                  )
                ]),
              ),
            )
          ])),
    );
  }
}
