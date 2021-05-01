import 'package:ProyectoMoviles/cart/bloc/cart_bloc.dart';
import 'package:ProyectoMoviles/cart/item_cart.dart';
import 'package:ProyectoMoviles/cart/purchase_cart.dart';
import 'package:ProyectoMoviles/home_drawer.dart';
import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Product> prodsList;
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
            if (state is RemoveProductState) {
              // show snackbar

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Elemento eliminado..."),
                  ),
                );
            } else if (state is ElementsLoadedState) {
              prodsList = state.prodsList;
            } else if (state is SavingOrderState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Guardando elemento en Firebase..."),
                  ),
                );
            } else if (state is SavedOrderState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Elemento guardado en Firebase..."),
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
                      flex: 9,
                      child: ListView.builder(
                        itemCount: state.prodsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemCart(
                              prod: state.prodsList[index], idx: index);
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
                              backgroundColor: orange,
                            ),
                            child: Text(
                              'Comprar',
                              style: TextStyle(
                                color: white,
                              ),
                            ),
                            onPressed: () {
                              //TODO: Mandar mensaje por whatsapp
                              ////TODO: Implementar Paypal
                              BlocProvider.of<CartBloc>(context)
                                  .add(ShowPurchaseEvent());
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (state is ShowPurchaseState) {
              return PurchaseCart(
                prodlist: prodsList,
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
