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

  HomeBloc() : super(HomeInitial());
  List<Product> carrito = [];
  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is AddToCartEvent) {
      //carrito.add(event.product);
      var cartElements = _cartBox.get("bebidas", defaultValue: []);
      List<dynamic> newcartElements = cartElements + [event.product];
      await _cartBox.put("bebidas", newcartElements);
      print(cartElements);
      yield ProductAddedState();
      yield HomeInitial();
    }
  }
}
