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
  @HiveField(8)
  final String urlToImage;
  @HiveField(9)
  final String description;

  Product(
      {@required this.idProd,
      @required this.name,
      @required this.amount,
      @required this.size,
      @required this.priceCh,
      @required this.priceM,
      @required this.priceG,
      @required this.type,
      @required this.urlToImage,
      @required this.description});

  Map<String, dynamic> toJson() {
    return {
      'idProd': idProd,
      'name': name,
      'amount': amount,
      'size': size,
      'priceCh': priceCh,
      'priceM': priceM,
      'priceG': priceG,
      'type': type,
      'urlToImage': urlToImage,
      'description': description
    };
  }
}
