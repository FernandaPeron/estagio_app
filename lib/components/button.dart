import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final dynamic buttonContent;
  final Function onPressed;
  final bool primary;

  Button(this.buttonContent, this.onPressed, {this.primary = true});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: RaisedButton(
        elevation: 3,
        color: _color(),
        child: widget.buttonContent,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          side: BorderSide(
            color: _color(),
          ),
        ),
        onPressed: () => widget.onPressed(),
      ),
    );
  }

  _color() {
    return widget.primary
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
  }
}
