import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

alert(BuildContext context, String msg, {bool okOnly = true}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: Text(msg),
          actions: <Widget>[
            _actions(context, okOnly),
          ],
        ),
      );
    },
  );
}

_actions(BuildContext context, bool okOnly) {
  if (okOnly) {
    return FlatButton(
      child: Text("Ok"),
      onPressed: () => {
        Navigator.pop(context, true),
      },
    );
  }
  return Row(
    children: <Widget>[
      FlatButton(
        child: Text("Não"),
        onPressed: () => {
          Navigator.pop(context, false),
        },
      ),
      FlatButton(
        child: Text("Sim"),
        onPressed: () => {
          Navigator.pop(context, true),
        },
      )
    ],
  );
}
