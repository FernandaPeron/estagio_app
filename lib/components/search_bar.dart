import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function filter;
  final String hint;

  SearchBar(this.filter, this.hint);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextField(
        controller: _textController,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          focusColor: Colors.transparent,
          suffixIcon: Icon(
              Icons.search,
            color: Colors.black54,
          ),
          filled: true,
          fillColor: Color(0xFFE0E0E0),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(30),
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          hintStyle: TextStyle(
            color: Colors.black54
          ),
          hintText: widget.hint,
        ),
        onChanged: widget.filter,
      ),
    );
  }
}
