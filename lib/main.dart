import 'package:ProyectoMoviles/initial/login.dart';
import 'package:ProyectoMoviles/initial/register_page.dart';
import 'package:ProyectoMoviles/initial/splashscreen_page.dart';
import 'package:flutter/material.dart';

import 'home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material app',
      home: SplashScreenPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
