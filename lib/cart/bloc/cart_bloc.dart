import 'dart:async';

import 'package:ProyectoMoviles/model/product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  // referencia a la box previamente abierta (en el main)
  Box _cartBox = Hive.box("Carrito");
  List<Product> _prodsList = [];
  List<Product> get prodsList => _prodsList;
  CartBloc() : super(CartInitial());
  List<Product> carrito = [];
  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is LoadProductsEvent) {
      // cargar
      _prodsList =
          List<Product>.from(_cartBox.get("bebidas", defaultValue: []));
      if (_prodsList.length != 0) {
        yield ElementsLoadedState(prodsList: _prodsList);
      }
    } else if (event is RemoveProductEvent) {
      _prodsList.removeAt(event.idx);
      yield RemoveProductState();
      await _cartBox.put("bebidas", _prodsList);
      if (_prodsList.length != 0) {
        yield ElementsLoadedState(prodsList: _prodsList);
      }
    } else if (event is IncrementAmountEvent) {
      _prodsList[event.idx].amount++;
      await _cartBox.put("bebidas", _prodsList);
      yield CartInitial();
      yield ElementsLoadedState(prodsList: _prodsList);
    } else if (event is DecrementAmountEvent) {
      _prodsList[event.idx].amount--;
      await _cartBox.put("bebidas", _prodsList);
      yield CartInitial();
      yield ElementsLoadedState(prodsList: _prodsList);
    }else if(event is ShowPurchaseEvent){
      yield ShowPurchaseState();
    }
  }
}
