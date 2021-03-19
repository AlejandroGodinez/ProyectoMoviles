import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

// import 'bloc/home_bloc.dart';

class ItemCard extends StatefulWidget {
  final Product prod;
  final ValueChanged<Product> addToCart;
  ItemCard({
    Key key,
    @required this.prod,
    @required this.addToCart,
  }) : super(key: key);

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
      child: Column(
        children: [
          Text("${widget.prod.idProd}"),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.blue,
              size: 50,
            ),
            onPressed: () => widget.addToCart(widget.prod),
          )
        ],
      ),
    );
  }
}
