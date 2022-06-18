import 'package:flutter/material.dart';
import 'package:bloc_test/utils/navigation_service.dart';
import 'package:bloc_test/utils/styles/styles.dart';

class ViewUtil {
  static SSLSnackbar(String msg) {
    /**
     * Using ScaffoldMessenger we can easily access
     * this snackbar from anywhere
     */

    return ScaffoldMessenger.of(Navigation.key.currentContext!).showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: '',
          textColor: Colors.transparent,
          onPressed: () {},
        ),
      ),
    );
  }

  // this varialble is for internet connection check.
  static bool isPresentedDialog = false;
  static showInternetDialog({
    required VoidCallback onPressed,
  }) async {
    // flutter defined function.
    await showDialog(
      context: Navigation.key.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog.
        return AlertDialog(
          title: Text("Connection Error"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Internet is not available"),
              TextButton(child: Text("Try Again"), onPressed: onPressed),
            ],
          ),
          actions: [
            // usually buttons at the bottom of the dialog.
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

// global alert dialog
  static showAlertDialog(
      {String? title,
      required Widget content,
      List<Widget>? actions,
      Color? alertBackgroundColor,
      bool? barrierDismissible,
      BorderRadius? borderRadius}) async {
    // flutter defined function.
    await showDialog(
      context: Navigation.key.currentContext!,
      barrierDismissible: barrierDismissible ?? true,
      builder: (BuildContext context) {
        // return object of type Dialog.
        return AlertDialog(
            backgroundColor: alertBackgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius:
                    borderRadius ?? BorderRadius.all(Radius.circular(8.w))),
            title: title == null ? null : Text(title),
            content: content,
            actions: actions);
      },
    );
  }

 
}

