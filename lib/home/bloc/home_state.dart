part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class ProductAddedState extends HomeState {
  @override
  List<Object> get props => [];
}

class FavoriteAddedState extends HomeState {
  final List<Product> favorites;
  FavoriteAddedState({@required this.favorites});
  @override
  List<Object> get props => [];
}

class FavoriteDeletedState extends HomeState {
  @override
  List<Object> get props => [];
}

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

class DrinksState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadedProductsState extends HomeState {
  // final List<Product> bebidas;
  // final List<Product> concentrados;

  //LoadedProductsState({@required this.bebidas,@required this.concentrados,});

  @override
  List<Object> get props => [];
}
