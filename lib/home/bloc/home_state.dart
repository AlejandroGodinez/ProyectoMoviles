part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}


class FavoritesState extends HomeState {
  // final List<Product> product;

  // FavoritesState({@required this.product});
  @override
  List<Object> get props => [];
}

class ConsState extends HomeState {
  @override
  List<Object> get props => [];
}

class HelpState extends HomeState {
  @override
  List<Object> get props => [];
}

class OrderState extends HomeState {
  @override
  List<Object> get props => [];
}

class DrinksState extends HomeState {
  @override
  List<Object> get props => [];
}

class ShowCartState extends HomeState {
  @override
  List<Object> get props => [];
}

class ShowCartItemState extends HomeState {
  final Product product;
  final bool isfavorite;

  ShowCartItemState({
    @required this.product,
    @required this.isfavorite
  });
  
  @override
  List<Object> get props => [product, isfavorite];
}

class LoadedProductsState extends HomeState {
  final List<Product> bebidas;
  final List<Product> concentrados;

  LoadedProductsState({
    @required this.bebidas,
    @required this.concentrados,
  });

  @override
  List<Object> get props => [bebidas, concentrados];
}
