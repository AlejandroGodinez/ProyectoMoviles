import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  ItemCard({Key key}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
         padding: EdgeInsets.all(40.0),
         height: 180,
         width: 160,
         decoration: BoxDecoration(
           color: orange,
           borderRadius: BorderRadius.circular(16),
         ),
         child: Text("Bebida"),
    );
  }
}