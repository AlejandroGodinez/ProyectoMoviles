import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 1, adapterName: "CarritoAdapter")
class Product {
  @HiveField(0)
  final String idProd;
  @HiveField(1)
  final String name;
  @HiveField(2)
  int amount;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final String type;

  Product(
      {@required this.idProd,
      @required this.name,
      @required this.amount,
      @required this.price,
      @required this.type});
}
