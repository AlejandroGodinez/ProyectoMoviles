import 'package:ProyectoMoviles/model/order.dart';
import 'package:flutter/material.dart';

import 'item_orders.dart';

class Orders extends StatefulWidget {
  final List<Order> ordenes;
  Orders({Key key, @required this.ordenes}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

//TODO: Mostrar ordenes pasadas de firebase
class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    if (widget.ordenes.length == 0) {
      return Center(
        child: Text("No tienes ordenes en tu historial"),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: widget.ordenes.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemOrder(order: widget.ordenes[index]);
        },
      ),
    );
  }
}
