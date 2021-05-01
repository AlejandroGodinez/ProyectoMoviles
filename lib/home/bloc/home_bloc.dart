import 'dart:async';

import 'package:ProyectoMoviles/model/product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  var _cFirestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  // referencia a la box previamente abierta (en el main)
  Box _cartBox = Hive.box("Carrito");
  // Box _favBox = Hive.box("Favoritos");
  HomeBloc() : super(HomeInitial());
  List<Product> carrito = [];
  // List<Product> favoritos = [];
  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is InitialEvent) {
      yield LoadedProductsState(
          bebidas: await _getProduct("bebidas"),
          concentrados: await _getProduct("concentrados"));
    } else if (event is AddToCartEvent) {
      //carrito.add(event.product);
      var cartElements = _cartBox.get("bebidas", defaultValue: []);
      List<dynamic> newcartElements = cartElements + [event.product];
      await _cartBox.put("bebidas", newcartElements);
      print(cartElements);
      yield ProductAddedState();
      yield HomeInitial();
    } else if (event is ShowDrinksEvent) {
      yield DrinksState();
    } else if (event is ShowConsEvent) {
      yield ConsState();
    } else if (event is ShowFavsEvent) {
      yield FavoritesState();
    } else if (event is AddFavoriteEvent) {
      // var favElements = _favBox.get("favoritos", defaultValue: []);
      // List<dynamic> newFavElements = favElements + [event.product];
      // await _favBox.put("favoritos", newFavElements);
      await _saveFavorite(event.product);
      yield FavoriteAddedState();
      yield HomeInitial();
    } else if (event is DeleteFavoriteEvent) {
      // List<Product> favElements =
      // //     List<Product>.from(_favBox.get("favoritos", defaultValue: []));
      // favElements.removeWhere((item) => item.idProd == event.product.idProd);
      // List<dynamic> newFavElements = favElements;
      // await _favBox.put("favoritos", newFavElements);
      await _deleteFavorite(event.product);
      yield FavoriteDeletedState();
      yield HomeInitial();
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
