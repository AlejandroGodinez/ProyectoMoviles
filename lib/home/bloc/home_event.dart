part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends HomeEvent {
  final Product product;

  AddToCartEvent({@required this.product});
  @override
  List<Object> get props => [product];
}

class ShowFavsEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class ShowConsEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class ShowDrinksEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}