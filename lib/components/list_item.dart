import 'package:estagio_app/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget pushTo;

  ListItem(this.title, this.icon, this.pushTo);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goTo(),
      child: Container(
        height: 75,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  widget.icon,
                  size: 40,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Icon(FontAwesomeIcons.angleRight),
          ],
        ),
      ),
    );
  }

  _goTo() {
    push(context, widget.pushTo, replace: false);
  }
}
