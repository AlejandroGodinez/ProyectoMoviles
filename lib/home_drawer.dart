import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/auth_bloc.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) {
    //     return AuthBloc();
    //   },
    //   child: BlocConsumer<AuthBloc, AuthState>(
    //     listener: (context, state) {},
    //     builder: (context, state) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Container(
              height: 150,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://www.kindpng.com/picc/m/495-4952535_create-digital-profile-icon-blue-user-profile-icon.png',
                ),
                minRadius: 40,
                maxRadius: 80,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              user.displayName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            ListTile(
              title: Text(
                "Inicio",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pushNamed('/home');
              },
            ),
            ListTile(
              title: Text(
                "Mis Pedidos",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              leading: Icon(Icons.store),
              onTap: () {
                Navigator.of(context).pushNamed('/orders');
              },
            ),
            // ListTile(
            //   title: Text("Perfil",
            //       style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            //   leading: Icon(Icons.person),
            //   onTap: () {},
            // ),
            ListTile(
              title: Text("Ayuda",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              leading: Icon(Icons.help),
              onTap: () {
                Navigator.of(context).pushNamed('/help');
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        MdiIcons.facebook,
                        color: Colors.blue[900],
                        size: 40,
                      ),
                      onPressed: () {
                        _launchURL('https://www.facebook.com/NiceTeaLM');
                      }),
                  IconButton(
                      icon: Icon(
                        MdiIcons.twitter,
                        color: Colors.blue[300],
                        size: 40,
                      ),
                      onPressed: () {
                        _launchURL('https://mobile.twitter.com/NiceTeaLM');
                      }),
                  IconButton(
                      icon: Icon(
                        MdiIcons.whatsapp,
                        color: Colors.green,
                        size: 40,
                      ),
                      onPressed: () {
                        FlutterOpenWhatsapp.sendSingleMessage("523310907312", "");
                      })
                ],
              ),
            ),
            ListTile(
              title: Text("Cerrar Sesión"),
              leading: Icon(Icons.logout),
              onTap: () {
                //Navigator.of(context).pushNamed("/");
                BlocProvider.of<AuthBloc>(context).add(
                  SignOutAuthenticationEvent(),
                );
              },
            ),
          ],
        ),
      ),
    );
    //     },
    //   ),
    // );
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
