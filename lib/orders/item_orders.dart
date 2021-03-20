import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemOrder extends StatefulWidget {
  ItemOrder({Key key}) : super(key: key);

  @override
  _ItemOrderState createState() => _ItemOrderState();
}

class _ItemOrderState extends State<ItemOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.17,
        child: Stack(
          children: [
            Positioned.fill(
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  // elevation: 4.0,
                  color: buttonBlue),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.shopping_bag,
                color: white,
                size: 40,
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 70),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pedido del 30/08/21",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: white,
                    fontSize: 20,
                  ),
                )),
            Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.7),
                alignment: Alignment.centerLeft,
                child: Text("\$ 200",
                    style: TextStyle(
                        color: white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold))),
            Container(
                margin: EdgeInsets.only(bottom: 5),
                alignment: Alignment.bottomCenter,
                child: TextButton.icon(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(white),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.info),
                    label: Text("detalles")))
          ],
        ));
  }
}
