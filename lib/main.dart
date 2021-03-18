import 'package:ProyectoMoviles/cart/cart.dart';
import 'package:ProyectoMoviles/help_page.dart';
import 'package:ProyectoMoviles/initial/login.dart';
import 'package:ProyectoMoviles/initial/register_page.dart';
import 'package:ProyectoMoviles/initial/splashscreen_page.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'home/home.dart';

void main() async {
  // // asegurarnos de iinicializar antes de crear la app
  // WidgetsFlutterBinding.ensureInitialized();

  // /// acceder a localstorage
  // final _localStorage = await getExternalStorageDirectory();
  // // inicializar Hive pasando path a local storage
  // Hive
  //   ..init(_localStorage.path)
  //   ..registerAdapter(CarritoAdapter());
  // await Hive.openBox("Carrito");

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
      debugShowCheckedModeBanner: false,
      title: 'Material app',
      home: SplashScreenPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/help': (context) => HelpPage(),
        '/cart': (context) => Cart(),
      },
    );
  }
}
