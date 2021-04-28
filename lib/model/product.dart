import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 1, adapterName: "ProductAdapter")
class Product {
  @HiveField(0)
  final String idProd;
  @HiveField(1)
  final String name;
  @HiveField(2)
  int amount;
  @HiveField(3)
  String size;
  @HiveField(4)
  final double priceCh;
  @HiveField(5)
  final double priceM;
  @HiveField(6)
  final double priceG;
  @HiveField(7)
  final String type;

  Product(
      {@required this.idProd,
      @required this.name,
      @required this.amount,
      @required this.size,
      @required this.priceCh,
      @required this.priceM,
      @required this.priceG,
      @required this.type});
}
