import 'package:ProyectoMoviles/cart/purchase_cart.dart';
import 'package:ProyectoMoviles/home/bloc/home_bloc.dart';
import 'package:ProyectoMoviles/home/bloc/product_favorite_bloc.dart';
import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_drawer.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  bool isfavorite;

  ProductDetail({Key key, @required this.product, @required this.isfavorite})
      : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String size = "Chico";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProductFavoriteBloc();
      },
      child: BlocConsumer<ProductFavoriteBloc, ProductFavoriteState>(
          listener: (context, state) {
        if (state is ProductAddedState) {
          return ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text("Añadiendo al carrito...")));
        } else if (state is FavoriteAddedState) {
          return ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text("Añadiendo a favoritos...")));
        }
        if (state is FavoriteDeletedState) {
          return ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text("Eliminando de favoritos...")));
        }
      }, builder: (context, state) {
        if (state is PurchaseState) {
          List<Product> singleProd = [];
          singleProd.add(widget.product);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  BlocProvider.of<ProductFavoriteBloc>(context)
                      .add(PurchaseBackEvent());
                },
              ),
              title: Text(
                'Comprar producto',
                style: TextStyle(color: Colors.grey),
              ),
              iconTheme: IconThemeData(color: Colors.grey),
              backgroundColor: white,
              // automaticallyImplyLeading: false,
              centerTitle: true,

              actions: <Widget>[],
            ),
            drawer: HomeDrawer(),
            body: PurchaseCart(prodlist: singleProd),
          );
        }
        return Scaffold(
          backgroundColor: orange,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: orange,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(ShowDrinksEvent());
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navigator.of(context).pushNamed('/cart');
                  BlocProvider.of<HomeBloc>(context).add(ShowCartEvent());
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.product.name}',
                          style: TextStyle(color: white, fontSize: 36.0),
                        ),
                        Text(
                          '${widget.product.type}',
                          style: TextStyle(color: white, fontSize: 26.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            size == "Chico"
                                ? '\$${widget.product.priceCh}'
                                : size == "Mediano"
                                ? '\$${widget.product.priceM}'
                                : '\$${widget.product.priceG}',
                            style: TextStyle(color: white, fontSize: 40.0),
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2,
                      right: MediaQuery.of(context).size.width * 0.01),
                  child: Image.network(
                    widget.product.urlToImage,
                    height: 200,
                    width: 200,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Tamaño',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.42,
                      left: MediaQuery.of(context).size.width * 0.01,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              size = "Chico";
                            });
                          },
                          child: Text(
                            'CH',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: size == "Chico" ? orange : Colors.grey),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              size = "Mediano";
                            });
                          },
                          child: Text(
                            'M',
                            style: TextStyle(
                                fontSize: 20.0,
                                color:
                                    size == "Mediano" ? orange : Colors.grey),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              size = "Grande";
                            });
                          },
                          child: Text(
                            'G',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: size == "Grande" ? orange : Colors.grey),
                          ),
                        ),
                      ],
                    )),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    left: MediaQuery.of(context).size.width * 0.04,
                    right: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: Text(widget.product.description),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.72,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.height * 0.35,
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 40.0,
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            widget.product.size = size;
                            print(widget.isfavorite);
                            BlocProvider.of<ProductFavoriteBloc>(context)
                                .add(AddToCartEvent(product: widget.product));
                          },
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.height * 0.02),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              backgroundColor: orange,
                            ),
                            child: Text(
                              'COMPRAR',
                              style: TextStyle(
                                color: white,
                              ),
                            ),
                            onPressed: () {
                              widget.product.size = size;
                              BlocProvider.of<ProductFavoriteBloc>(context)
                                  .add(PurchaseEvent());
                            },
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.height * 0.02),
                        IconButton(
                          iconSize: 40.0,
                          icon: widget.isfavorite
                              ? Icon(Icons.favorite_outlined)
                              : Icon(Icons.favorite_border_outlined),
                          onPressed: () {
                            widget.isfavorite = !widget.isfavorite;
                            widget.isfavorite
                                ? BlocProvider.of<ProductFavoriteBloc>(context)
                                    .add(AddFavoriteEvent(
                                    product: widget.product,
                                  ))
                                : BlocProvider.of<ProductFavoriteBloc>(context)
                                    .add(DeleteFavoriteEvent(
                                        product: widget.product));
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
