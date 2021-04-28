import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/product_detail.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

// import 'bloc/home_bloc.dart';

class ItemCard extends StatefulWidget {
  final Product prod;
  final bool isfavorite;
  ItemCard({Key key, @required this.prod, @required this.isfavorite})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(40.0),
        height: 180,
        width: 160,
        decoration: BoxDecoration(
          color: orange,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text("${widget.prod.name}"),
            Image.network(
              "https://cdn.shopify.com/s/files/1/0087/6065/5938/products/green-tea-15-5oz-can_2000x.png?v=1581728927",
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetail(
                  product: widget.prod,
                  isfavorite: widget.isfavorite,
                )));
      },
    );
  }
}
