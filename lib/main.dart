import 'package:ProyectoMoviles/cart/cart.dart';
import 'package:ProyectoMoviles/help_page.dart';
import 'package:ProyectoMoviles/initial/login.dart';
import 'package:ProyectoMoviles/initial/register_page.dart';
import 'package:ProyectoMoviles/initial/splashscreen_page.dart';
import 'package:ProyectoMoviles/orders/orders_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ProyectoMoviles/model/product.dart';

import 'bloc/auth_bloc.dart';
import 'home/home.dart';
import 'orders/orders.dart';

void main() async {
  // asegurarnos de inicializar antes de crear la app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// acceder a localstorage
  final _localStorage = await getExternalStorageDirectory();
  // inicializar Hive pasando path a local storage
  Hive
    ..init(_localStorage.path)
    ..registerAdapter(ProductAdapter());
  await Hive.openBox("Carrito");
  await Hive.openBox("Favoritos");
  //runApp(MyApp());
  runApp(
    BlocProvider(
      create: (context) => AuthBloc()..add(SplashScreenEvent()),
      child: MyApp(),
    ),
  );
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
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AlreadyAuthState) {
            return HomePage();
          }
          if (state is UnAuthState) {
            return LoginPage();
          }
          if (state is RegisterState) {
            return RegisterPage();
          }
          return SplashScreenPage();
        },
      ),
      // SplashScreenPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/help': (context) => HelpPage(),
        '/cart': (context) => Cart(),
        // '/product': (context) => ProductDetail(),
        '/orders': (context) => Orders(),
        '/orderDetail': (context) => OrderDetails(),
      },
    );
  }
}
