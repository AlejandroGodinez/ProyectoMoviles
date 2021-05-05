import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/product_detail.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

// import 'bloc/home_bloc.dart';

class ItemCard extends StatefulWidget {
  final Product prod;
  final bool isfavorite;
  ItemCard({Key key, @required this.prod, @required this.isfavorite})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        //padding: EdgeInsets.all(50.0),
        height: 180,
        width: 160,
        decoration: BoxDecoration(
          color: orange,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.prod.name,
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Align(
                alignment: Alignment.center,
                child: Image.network(
                  widget.prod.urlToImage,
                  scale: 2,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ProductDetail(
        //           product: widget.prod,
        //           isfavorite: widget.isfavorite,
        //         )));
        BlocProvider.of<HomeBloc>(context).add(
          ShowCartItemEvent(
            product: widget.prod,
            isfavorite: widget.isfavorite,
          ),
        );
      },
    );
  }
}
