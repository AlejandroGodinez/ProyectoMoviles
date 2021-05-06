import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemOrderDetail extends StatefulWidget {
  Product prod;
  ItemOrderDetail({Key key, @required this.prod}) : super(key: key);

  @override
  _ItemOrderDetailState createState() => _ItemOrderDetailState();
}

class _ItemOrderDetailState extends State<ItemOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
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
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 3),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.network(
                widget.prod.urlToImage,
                height: 170,
                width: 170,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.04,
              left: MediaQuery.of(context).size.width * 0.33,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.prod.name}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: MediaQuery.of(context).size.height * 0.06),
                Text(
                  '${widget.prod.type} ${widget.prod.type == 'Bebida' && widget.prod.size == 'Chico' ? 'Chica' : widget.prod.type == 'Bebida' && widget.prod.size == 'Mediano' ? 'Mediana' : widget.prod.size}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.11,
                left: MediaQuery.of(context).size.width * 0.5),
            alignment: Alignment.centerLeft,
            child: Text(
              "Cantidad: ${widget.prod.amount}",
              style: TextStyle(
                  color: white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
