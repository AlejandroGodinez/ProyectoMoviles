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

class ProductFavoriteBloc extends Bloc<ProductFavoriteEvent, ProductFavoriteState> {
  var _cFirestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  Box _cartBox = Hive.box("Carrito");
  ProductFavoriteBloc() : super(ProductFavoriteInitial());

  @override
  Stream<ProductFavoriteState> mapEventToState(
    ProductFavoriteEvent event,
  ) async* {
    if (event is AddFavoriteEvent) {
        await _saveFavorite(event.product);
        yield FavoriteAddedState();
        // yield HomeInitial();
      } else if (event is DeleteFavoriteEvent) {
        await _deleteFavorite(event.product);
        yield FavoriteDeletedState();
        // yield HomeInitial();
    } else if (event is AddToCartEvent) {
      var cartElements = _cartBox.get("bebidas", defaultValue: []);
      List<dynamic> newcartElements = cartElements + [event.product];
      await _cartBox.put("bebidas", newcartElements);
      print(cartElements);
      yield ProductAddedState();
      yield ProductFavoriteInitial();
    } else if (event is PurchaseEvent) {
      yield PurchaseState();
    } else if (event is PurchaseBackEvent){
      yield PurchaseBackState();
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
}

