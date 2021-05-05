import 'dart:async';

import 'package:ProyectoMoviles/model/product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  var _cFirestore = FirebaseFirestore.instance;
  // referencia a la box previamente abierta (en el main)

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
    } else if (event is ShowDrinksEvent) {
      yield DrinksState();
    } else if (event is ShowConsEvent) {
      yield ConsState();
    } else if (event is ShowFavsEvent) {
      yield FavoritesState();
    }else if (event is ShowCartEvent) {
      yield ShowCartState();
    } else if (event is ShowCartItemEvent) {
      yield ShowCartItemState(
          product: event.product, isfavorite: event.isfavorite);
    } else if (event is HelpEvent){
      yield HelpState();
    } else if (event is OrderEvent){
      yield OrderState();
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
