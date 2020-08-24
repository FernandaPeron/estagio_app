import 'package:estagio_app/entity/user_entity.dart';
import 'package:estagio_app/pages/login/login.dart';
import 'package:estagio_app/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  User _user;

  UserAccountsDrawerHeader _header(User user) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color(0xFFACACAC),
      ),
      accountName: Text(
        user.name ?? "",
        style: TextStyle(
          height: 1,
          fontWeight: FontWeight.bold,
          color: Color(0xFF292929),
        ),
      ),
      accountEmail: Text(
        user.email,
        style: TextStyle(
          color: Color(0xFF292929),
        ),
      ),
      currentAccountPicture:
          FittedBox(child: Icon(FontAwesomeIcons.solidUserCircle, color: Colors.black,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);

    return SafeArea(
      child: Drawer(
        child: Container(
          color: Color(0xFFACACAC),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _header(_user),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: Container(
                    child: FlatButton.icon(
                      color: Colors.transparent,
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Color(0xFF292929),
                      ),
                      onPressed: () => _onClickLogout(context),
                      label: Text(
                        'Sair',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF292929),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    push(context, LoginPage(), replace: true);
  }
}
