import 'package:flutter/material.dart';
import 'package:rymak/source/pages/login_page.dart';
import 'package:rymak/source/pages/unidad_page.dart';
import 'package:rymak/source/pages/user_page.dart';

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      initialRoute: "/login",
      routes: {
        "/login" : (BuildContext context) => LoginPage(),
      },
    );
  }
}
