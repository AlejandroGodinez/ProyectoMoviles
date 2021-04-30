import 'package:ProyectoMoviles/model/product.dart';
import 'package:flutter/foundation.dart';

class Order {
  final String client;
  final String date;
  final List<Product> prodList;
  final double total;

  Order(
      {@required this.client,
      @required this.date,
      @required this.prodList,
      @required this.total,
      });

  Map<String, dynamic> toJson(){
    var arr = [];
    for (var item in prodList) {
      arr.add(item.toJson());
    }
    return{
      'client': client,
      'date': date,
      'products': arr,
      'total': total
    };
  }
}
