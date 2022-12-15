import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/themeProvider.dart';

class ReusableWidgets {
  GestureDetector AppPreferences(
      BuildContext context, String text, Function? callback()) {
    return GestureDetector(
      onTap: callback,
      child: Container(
          width: double.infinity,
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.read<ThemeProvider>().isDark
                  ? const Color.fromARGB(255, 34, 34, 34)
                  : const Color.fromARGB(255, 244, 244, 244)),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )),
    );
  }

  loadingDialog(BuildContext context) {
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
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.only(left: 4, right: 4, bottom: isHomePage ? 67 : 8),
      content: SizedBox(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text == 'Internet Connection Available'
                ? Icon(Icons.wifi, color: Colors.green.shade400)
                : const Icon(
                    Icons.wifi_off,
                    color: Colors.grey,
                  ),
            const SizedBox(
              width: 15,
            ),
            Text(text),
          ],
        ),
      ),
    ));
  }
}
