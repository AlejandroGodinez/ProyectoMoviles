import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemCart extends StatefulWidget {
  final Product prod;
  ItemCart({
    Key key,
    @required this.prod,
  }) : super(key: key);

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
                // elevation: 4.0,
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
                '${widget.prod.idProd}',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.11,
                  left: MediaQuery.of(context).size.width * 0.01),
              alignment: Alignment.centerLeft,
              child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    //TODO: implementar borrar del carrito
                  }),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.11,
                  left: MediaQuery.of(context).size.width * 0.35),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.white),
                      onPressed: () {
                        //TODO: implementar aumentar amount
                      }),
                  Text("${widget.prod.amount}", style: TextStyle(color: white)),
                  IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.white),
                      onPressed: () {
                        //TODO: implementar decrementar amount
                      }),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.11,
                    left: MediaQuery.of(context).size.width * 0.7),
                alignment: Alignment.centerLeft,
                child: Text("\$${widget.prod.amount * widget.prod.price}",
                    style: TextStyle(
                        color: white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold))),
          ],
        ));
  }
}
