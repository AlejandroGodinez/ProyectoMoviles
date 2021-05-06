import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ProyectoMoviles/model/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
part 'product_favorite_event.dart';
part 'product_favorite_state.dart';

class ProductFavoriteBloc
    extends Bloc<ProductFavoriteEvent, ProductFavoriteState> {
  var _cFirestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  Box _cartBox = Hive.box("Carrito");
  ProductFavoriteBloc() : super(ProductFavoriteInitial());
  List<Product> catalog = [];
  @override
  Stream<ProductFavoriteState> mapEventToState(
    ProductFavoriteEvent event,
  ) async* {
    if (event is GetCatalogEvent) {
      catalog.addAll(await _getProduct("bebidas"));
      catalog.addAll(await _getProduct("concentrados"));
    } else if (event is AddFavoriteEvent) {
      await _saveFavorite(event.product);
      yield FavoriteAddedState();
    } else if (event is DeleteFavoriteEvent) {
      await _deleteFavorite(event.product);
      yield FavoriteDeletedState();
    } else if (event is AddToCartEvent) {
      var cartElements = _cartBox.get("bebidas", defaultValue: []);
      List<dynamic> newcartElements = cartElements + [event.product];
      await _cartBox.put("bebidas", newcartElements);
      print(cartElements);
      yield ProductAddedState();
      yield ProductFavoriteInitial();
    } else if (event is PurchaseEvent) {
      yield PurchaseState();
    } else if (event is PurchaseBackEvent) {
      yield PurchaseBackState();
    } else if (event is MultipleAddToCartEvent) {
      await _multipleAddToCart(event.products);
      yield (MultipleAddToCartState());
    }
  }

  Future<bool> _saveFavorite(Product product) async {
    var favorite = {product.idProd: product.toJson()};
    try {
      await _cFirestore
          .collection("favoritos")
          .doc(user.email)
          .set(favorite, SetOptions(merge: true));
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> _deleteFavorite(Product product) async {
    try {
      await _cFirestore
          .collection("favoritos")
          .doc(user.email)
          .update({product.idProd: FieldValue.delete()});
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> _multipleAddToCart(List<Product> product) async {
    try {
      List<Product> newCartElements = [];
      product.forEach((product) {
        newCartElements.add(
            catalog.firstWhere((element) => element.idProd == product.idProd));
      });
      newCartElements.forEach((element) {
        element.amount = product
            .firstWhere((product) => element.idProd == product.idProd)
            .amount;
        element.size = product
            .firstWhere((product) => element.idProd == product.idProd)
            .size;
      });
      await _cartBox.put("bebidas", newCartElements);
      print(newCartElements);
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<List<Product>> _getProduct(String collection) async {
    try {
      var noticias = await _cFirestore.collection(collection).get();
      return noticias.docs
          .map(
            (element) => Product(
                idProd: element['idProd'],
                name: element['name'],
                amount: 1,
                size: "Chico",
                priceCh: element['priceCH'].toDouble(),
                priceM: element['priceM'].toDouble(),
                priceG: element['priceG'].toDouble(),
                type: element['type'],
                description: element['description'],
                urlToImage: element['urlToImage']),
          )
          .toList();
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
