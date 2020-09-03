import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'entity/user_entity.dart';
import 'pages/login/login.dart';
import 'package:provider/provider.dart';

void main() {
  Intl.defaultLocale = "pt_BR";
  initializeDateFormatting('pt_BR', null).then((_) =>
      runApp(
        ChangeNotifierProvider(
          create: (context) => User(),
          child: MyApp(),
        ),
      )
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
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          fontSizeFactor: 1.05,
        ),
        colorScheme: ColorScheme.dark(
          primary: Color(0xff213933),
          secondary: Color(0xff609185),
          background: Color(0xff3D5C54),
          surface: Color(0xffECECEC),
          onSurface: Colors.black,
        ),
      ),
      home: LoginPage(),
    );
  }
}
