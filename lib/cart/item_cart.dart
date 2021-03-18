import 'package:flutter/material.dart';

class ItemCart extends StatefulWidget {
  ItemCart({Key key}) : super(key: key);

  @override
  _ItemCartState createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
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
                elevation: 4.0,
                color: Colors.orange,
              ),
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
                  "Arizona",
                  style: TextStyle(fontSize: 25),
                )),
          ],
        ));
  }
}
