import 'package:ProyectoMoviles/home/bloc/home_bloc.dart';
import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/orders/item_order_detail.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ProyectoMoviles/home/bloc/product_favorite_bloc.dart';

class OrderDetails extends StatefulWidget {
  List<Product> productList;
  OrderDetails({Key key, @required this.productList}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(OrderEvent());
          },
        ),
        title: Text(
          '',
          style: TextStyle(color: Colors.grey),
        ),
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: white,
        // automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: BlocProvider(
        create: (context) => ProductFavoriteBloc()..add(GetCatalogEvent()),
        child: BlocConsumer<ProductFavoriteBloc, ProductFavoriteState>(
            listener: (context, state) {
          if (state is ProductAddedState) {
            return ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text("Añadiendo al carrito...")));
          } else if (state is FavoriteAddedState) {
            return ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text("Añadiendo a favoritos...")));
          }
          if (state is FavoriteDeletedState) {
            return ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text("Eliminando de favoritos...")));
          }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: ListView.builder(
                    itemCount: widget.productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemOrderDetail(
                        prod: widget.productList[index],
                      );
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
                          'Agregar al Carrito',
                          style: TextStyle(
                            color: white,
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<ProductFavoriteBloc>(context).add(
                              MultipleAddToCartEvent(
                                  products: widget.productList));
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content: Text("Pedido añadido al carrito...")));
                          BlocProvider.of<HomeBloc>(context)
                              .add(ShowCartEvent());
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
