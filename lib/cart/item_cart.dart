import 'package:ProyectoMoviles/cart/bloc/cart_bloc.dart';
import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCart extends StatefulWidget {
  final Product prod;
  final int idx;
  ItemCart({
    Key key,
    @required this.prod,
    @required this.idx,
  }) : super(key: key);

  @override
  _ItemCartState createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  double selectedPrice;

  @override
  Widget build(BuildContext context) {
    selectedPrice = widget.prod.size == "Chico"
        ? widget.prod.priceCh
        : widget.prod.size == "Mediano"
            ? widget.prod.priceM
            : widget.prod.priceG;
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
                  color: orange),
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
                  left: MediaQuery.of(context).size.width * 0.01),
              alignment: Alignment.centerLeft,
              child: IconButton(
                  splashRadius: 2.0,
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context)
                        .add(RemoveProductEvent(idx: widget.idx));
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
                      disabledColor: Colors.grey,
                      icon: Icon(Icons.remove_circle, color: Colors.white),
                      onPressed: () {
                        if (widget.prod.amount > 1) {
                          BlocProvider.of<CartBloc>(context)
                              .add(DecrementAmountEvent(idx: widget.idx));
                        }
                      }),
                  Text("${widget.prod.amount}", style: TextStyle(color: white)),
                  IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.white),
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context)
                            .add(IncrementAmountEvent(idx: widget.idx));
                      }),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.11,
                    left: MediaQuery.of(context).size.width * 0.7),
                alignment: Alignment.centerLeft,
                child: Text("\$${widget.prod.amount * selectedPrice}",
                    style: TextStyle(
                        color: white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold))),
          ],
        ));
  }
}
