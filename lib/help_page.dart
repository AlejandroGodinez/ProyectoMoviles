import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: orange,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  color: Colors.white,
                ),
                
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45),
                    ),
                  ),
                ),
                Icon(
                  Icons.mail,
                  color: orange,
                  size: 75,
                )
              ],
            ),
          ],
        ));
  }
}
