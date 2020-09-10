import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatefulWidget {
  final Function onAccept;
  final String text;
  final functionParam;

  ConfirmDialog(this.onAccept, this.text, {this.functionParam});

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(widget.text),
      actions: <Widget>[
        FlatButton(
          child: Text("Não"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Sim"),
          onPressed: () {
            Navigator.pop(context);
            widget.onAccept(widget.functionParam);
          },
        )
      ],
    );
  }
}
