import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  void showDialogLoading() {
    Dialog.showLoading(context);
  }

  void hideDialog() {
    Dialog.hide(context);
  }

  void showDialogCustom({String title, String message}) {
    Dialog.show(context, title, message);
  }
}

class Dialog {

  static void show(var context, var title, var message) {
    var titleWidget = title != null ? Text(title) : null;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: titleWidget,
        content: Text(message),
      )
    );
  }

  static void showLoading(var context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            Container(
              margin: const EdgeInsets.only(left: 15.0),
              child: const Text("Procesando", style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      )
    );
  }

  static void hide(var context) {
    Navigator.of(context).pop();
  }
}