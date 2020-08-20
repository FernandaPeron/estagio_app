import 'package:flutter/material.dart';
import 'entity/user_entity.dart';
import 'login/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => User(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff213933),
        fontFamily: "Cairo",
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Color(0xff213933),
          secondary: Color(0xff609185),
          background: Color(0xff3D5C54),
        ),
      ),
      home: LoginPage(),
    );
  }
}
