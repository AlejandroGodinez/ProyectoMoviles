import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
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
            Text("Nombre", style: TextStyle(fontSize: 30)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            ListTile(
              title: Text(
                "Mis Pedidos",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              leading: Icon(Icons.store),
              onTap: () {},
            ),
            ListTile(
              title: Text("Perfil",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              leading: Icon(Icons.person),
              onTap: () {},
            ),
            ListTile(
              title: Text("Ayuda",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              leading: Icon(Icons.help),
              onTap: () {},
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
                      onPressed: () {})
                ],
              ),
            ),
            ListTile(
              title: Text("Cerrar Sesión"),
              leading: Icon(Icons.logout),
              onTap: () {
                Navigator.of(context).pushNamed("/");
              },
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
