import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

import '../home_drawer.dart';
import 'item_orders.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

//TODO: Mostrar ordenes pasadas de firebase
class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return ItemOrder();
            },
    ));
  }
}
