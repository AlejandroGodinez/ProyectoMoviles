import 'package:ProyectoMoviles/cart/bloc/cart_bloc.dart';
import 'package:ProyectoMoviles/cart/item_cart.dart';
import 'package:ProyectoMoviles/home_drawer.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

        actions: <Widget>[],
      ),
      drawer: HomeDrawer(),
      body: BlocProvider(
        create: (context) => CartBloc()..add(LoadProductsEvent()),
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is ElementRemovingState) {
              // show snackbar
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Borrando..."),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is ElementsLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        itemCount: state.prodsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemCart(
                            prod: state.prodsList[index],
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Text('Total'),
                    )
                  ],
                ),
              );
            } else
              return Center(
                child: Text("No hay elementos"),
              );
          },
        ),
      ),
    );
  }
}
