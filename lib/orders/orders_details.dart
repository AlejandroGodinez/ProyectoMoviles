import 'package:ProyectoMoviles/orders/item_order_detail.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

import '../home_drawer.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails({Key key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Detalle Pedido',
            style: TextStyle(color: Colors.grey),
          ),
          iconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: white,
          // automaticallyImplyLeading: false,
          centerTitle: true,

          actions: <Widget>[],
        ),
        drawer: HomeDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemOrderDetail();
                  },
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: MediaQuery.of(context).size.height * 0.000005,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                        backgroundColor: buttonBlue,
                      ),
                      child: Text(
                        'Comprar',
                        style: TextStyle(
                          color: white,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
