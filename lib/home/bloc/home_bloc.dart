import 'dart:async';

import 'package:ProyectoMoviles/model/product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // referencia a la box previamente abierta (en el main)
  Box _cartBox = Hive.box("Carrito");
  Box _favBox = Hive.box("Favoritos");
  HomeBloc() : super(HomeInitial());
  List<Product> carrito = [];
  List<Product> favoritos = [];
  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is InitialEvent) {
      List<Product> favoritos =
          List<Product>.from(_favBox.get("favoritos", defaultValue: []));
      yield LoadedProductsState(favoritos: favoritos);
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
      favoritos =
          List<Product>.from(_favBox.get("favoritos", defaultValue: []));
      print(favoritos);
      yield FavoritesState(product: favoritos);
    } else if (event is AddFavoriteEvent) {
      var favElements = _favBox.get("favoritos", defaultValue: []);
      List<dynamic> newFavElements = favElements + [event.product];
      await _favBox.put("favoritos", newFavElements);
      yield FavoriteAddedState(favorites: favoritos);
      yield HomeInitial();
    } else if (event is DeleteFavoriteEvent) {
      List<Product> favElements =
          List<Product>.from(_favBox.get("favoritos", defaultValue: []));
      favElements.remove(event.product);
      List<dynamic> newFavElements = favElements;
      await _favBox.put("favoritos", newFavElements);
      yield FavoriteDeletedState();
      yield HomeInitial();
    }
  }
}
