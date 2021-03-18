import 'package:ProyectoMoviles/cart/item_cart.dart';
import 'package:ProyectoMoviles/home_drawer.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carrito de Compras',
          style: TextStyle(color: Colors.grey),
        ),
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: white,
        // automaticallyImplyLeading: false,
        centerTitle: true,

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed('/cart');
            },
          )
        ],
      ),
      drawer: HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ItemCart();
                },
              ),
            ),
            Expanded(
              child: Text('Total'),
            )
          ],
        ),
      ),
    );
  }
}
