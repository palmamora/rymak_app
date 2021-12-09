import 'package:flutter/material.dart';
import 'package:rymak/source/pages/unidad_page.dart';
import 'package:rymak/source/pages/user_page.dart';

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/user",
      routes: {
        "/user": (BuildContext context) => UserPage(),
      },
    );
  }
}
