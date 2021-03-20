import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemOrderDetail extends StatefulWidget {
  ItemOrderDetail({Key key}) : super(key: key);

  @override
  _ItemOrderDetailState createState() => _ItemOrderDetailState();
}

class _ItemOrderDetailState extends State<ItemOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: Stack(
          children: [
            Positioned.fill(
              top: 90,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  // elevation: 4.0,
                  color: buttonBlue),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Image.network(
                "https://cdn.shopify.com/s/files/1/0087/6065/5938/products/green-tea-15-5oz-can_2000x.png?v=1581728927",
                height: 180,
                width: 180,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.08,
                  left: MediaQuery.of(context).size.width * 0.35),
              child: Text(
                'Naranjita',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.11,
                  left: MediaQuery.of(context).size.width * 0.35),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text("amount", style: TextStyle(color: white)),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.11,
                    left: MediaQuery.of(context).size.width * 0.7),
                alignment: Alignment.centerLeft,
                child: Text("\$ Price",
                    style: TextStyle(
                        color: white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold))),
          ],
        ));
  }
}
