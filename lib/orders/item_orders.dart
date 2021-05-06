import 'package:ProyectoMoviles/home/bloc/home_bloc.dart';
import 'package:ProyectoMoviles/model/order.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemOrder extends StatefulWidget {
  Order order;
  ItemOrder({Key key, @required this.order}) : super(key: key);

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
                  "Pedido del ${parseDate()}",
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
                child: Text("\$ ${widget.order.total}",
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
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(
                        ShowOrderDetailEvent(
                            productsList: widget.order.prodList),
                      );
                    },
                    icon: Icon(Icons.info),
                    label: Text("detalles")))
          ],
        ));
  }

  String parseDate() {
    DateTime date = DateTime.parse(widget.order.date);
    String formattedDate = "${date.day}/${date.month}/${date.year}";
    return formattedDate;
  }
}
