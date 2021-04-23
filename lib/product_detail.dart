import 'package:ProyectoMoviles/home/bloc/home_bloc.dart';
import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  ProductDetail({Key key, @required this.product}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int size = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeBloc();
      },
      child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
        if (state is ProductAddedState) {
          return ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text("Añadiendo al carrito...")));
        }
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: orange,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: orange,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
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
                            '\$${widget.product.price}',
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
                    "https://cdn.shopify.com/s/files/1/0087/6065/5938/products/green-tea-15-5oz-can_2000x.png?v=1581728927",
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
                              size = 0;
                            });
                          },
                          child: Text(
                            'CH',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: size == 0 ? orange : Colors.grey),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              size = 1;
                            });
                          },
                          child: Text(
                            'M',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: size == 1 ? orange : Colors.grey),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              size = 2;
                            });
                          },
                          child: Text(
                            'G',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: size == 2 ? orange : Colors.grey),
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
                  child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.65,
                  ),
                  child: MaterialButton(
                    shape: CircleBorder(),
                    color: Colors.red,
                    child: Icon(
                      Icons.favorite_rounded,
                      color: white,
                    ),
                    onPressed: () {
                      //TODO: agregar a favoritos
                    },
                  ),
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
                      children: [
                        IconButton(
                          iconSize: 40.0,
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(AddToCartEvent(product: widget.product));
                          },
                        ),
                        Container(
                          width: MediaQuery.of(context).size.height * 0.28,
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              backgroundColor: orange,
                            ),
                            child: Text(
                              'COMPRARR',
                              style: TextStyle(
                                color: white,
                              ),
                            ),
                            onPressed: () {
                              //TODO: ir a la ventana de compra de producto
                            },
                          ),
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
