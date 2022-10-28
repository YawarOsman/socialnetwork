import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import '../provider/log.dart';

class ReusableWidgets {
  Container Notifications(
      BuildContext context, List text, Function? callback(bool val),
      [bool? switchValue]) {
    return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Provider.of<Log>(context, listen: false).isDark
                ? Color.fromARGB(255, 34, 34, 34)
                : Color.fromARGB(255, 244, 244, 244)),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  text[1] != null
                      ? Text(
                          text[1],
                          style: TextStyle(fontSize: 10),
                        )
                      : SizedBox()
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
                  : SizedBox()
            ],
          ),
        ));
  }

  GestureDetector AppPreferences(
      BuildContext context, String text, Function? callback()) {
    return GestureDetector(
      onTap: callback,
      child: Container(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Provider.of<Log>(context, listen: false).isDark
                  ? Color.fromARGB(255, 34, 34, 34)
                  : Color.fromARGB(255, 244, 244, 244)),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )),
    );
  }

  showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).iconTheme.color,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor)));
  }

  showSnackBarForConnectivity(BuildContext context, String text) {
    bool isHomePage =
        ModalRoute.of(context)!.settings.name.toString().contains('/home');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.only(left: 4, right: 4, bottom: isHomePage ? 67 : 8),
      content: Container(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text == 'Internet Connection Available'
                ? Icon(Icons.wifi, color: Colors.green.shade400)
                : Icon(
                    Icons.wifi_off,
                    color: Colors.white,
                  ),
            SizedBox(
              width: 15,
            ),
            Text(text),
          ],
        ),
        alignment: Alignment.center,
      ),
    ));
  }
}
