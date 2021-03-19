part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends CartEvent {}

class RemoveProductEvent extends CartEvent {
  final int idx;

  RemoveProductEvent({@required this.idx});

  @override
  List<Object> get props => [idx];
}

class IncrementAmountEvent extends CartEvent {
  final int idx;

  IncrementAmountEvent({@required this.idx});

  @override
  List<Object> get props => [idx];
}
class DecrementAmountEvent extends CartEvent {
  final int idx;

  DecrementAmountEvent({@required this.idx});

  @override
  List<Object> get props => [idx];
}
