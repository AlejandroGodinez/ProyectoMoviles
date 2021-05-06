import 'package:ProyectoMoviles/cart/bloc/cart_bloc.dart';
import 'package:ProyectoMoviles/home/bloc/home_bloc.dart';
import 'package:ProyectoMoviles/model/order.dart';
import 'package:ProyectoMoviles/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class PurchaseCart extends StatefulWidget {
  final List<Product> prodlist;
  PurchaseCart({Key key, @required this.prodlist}) : super(key: key);

  @override
  _PurchaseCartState createState() => _PurchaseCartState();
}

class _PurchaseCartState extends State<PurchaseCart> {
  var user = FirebaseAuth.instance.currentUser;
  double _total = 0;
  double _totalProductos = 0;
  double _envio = 50;

  @override
  void initState() {
    super.initState();
    for (var item in widget.prodlist) {
      double selectedPrice = item.size == "Chico"
          ? item.priceCh
          : item.size == "Mediano"
              ? item.priceM
              : item.priceG;
      _totalProductos += (item.amount * selectedPrice);
    }

    _total += _totalProductos + _envio;
  }

  String messageToSend() {
    String products = "";
    for (var item in widget.prodlist) {
      products +=
          "${item.amount} ${item.type}${item.amount > 1 ? 's' : ''} ${item.type == 'Bebida' && item.size == 'Chico' ? 'Chica' : item.type == 'Bebida' && item.size == 'Mediano' ? 'Mediana' : item.size}${item.amount > 1 ? 's' : ''} de ${item.name} \n";
    }
    String msg =
        '''Hola buen dia. He hecho un pedido por la aplicacion N-ICE Tea.\nMi pedido lleva lo siguiente:\n$products\nMi direccion es:\nCerrada de la plaza 5325\nTotal del pedido: $_total''';
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            color: white,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: Text(
                        //TODO: Implementar Google Maps
                        "Pago",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 8.0),
                //   ),
                // ),
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 8.0),
                //   ),
                // ),

                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Productos",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Envio",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "TOTAL",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$$_totalProductos",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "\$$_envio",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "\$$_total",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextButton(
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
                          BlocProvider.of<CartBloc>(context).add(
                            SaveOrderEvent(
                              orden: Order(
                                  client: user.email,
                                  date: DateTime.now().toString(),
                                  prodList: widget.prodlist,
                                  total: _total),
                            ),
                          );
                          FlutterOpenWhatsapp.sendSingleMessage(
                              "523310907312", messageToSend());
                          BlocProvider.of<HomeBloc>(context).add(
                            GetOrdersEvent(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Container(
//         color: white,
//         child: Column(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 16.0),
//                 child: Center(
//                   child: Text(
//                     //TODO: Implementar Google Maps
//                     "Pago",
//                     style: TextStyle(
//                         fontSize: 16.0,
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             ),
//             // Expanded(
//             //   child: Padding(
//             //     padding: const EdgeInsets.only(top: 8.0),
//             //   ),
//             // ),
//             // Expanded(
//             //   child: Padding(
//             //     padding: const EdgeInsets.only(top: 8.0),
//             //   ),
//             // ),

//             Expanded(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Productos",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           Text(
//                             "Envio",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           SizedBox(
//                             height: 8.0,
//                           ),
//                           Text(
//                             "TOTAL",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "\$$_totalProductos",
//                             style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           Text(
//                             "\$$_envio",
//                             style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           SizedBox(
//                             height: 8.0,
//                           ),
//                           Text(
//                             "\$$_total",
//                             style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 8.0,
//                   ),
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(45.0),
//                       ),
//                       backgroundColor: orange,
//                     ),
//                     child: Text(
//                       'Comprar',
//                       style: TextStyle(
//                         color: white,
//                       ),
//                     ),
//                     onPressed: () {
//                       BlocProvider.of<CartBloc>(context).add(
//                         SaveOrderEvent(
//                           orden: Order(
//                               client: user.email,
//                               date: DateTime.now().toString(),
//                               prodList: widget.prodlist,
//                               total: _total),
//                         ),
//                       );
//                       FlutterOpenWhatsapp.sendSingleMessage(
//                           "523310907312", messageToSend());
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
