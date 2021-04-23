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
  @override
  List<Object> get props => [];
}

class FavoritesState extends HomeState {
  final List<Product> product;

  FavoritesState({@required this.product});
  @override
  List<Object> get props => [product];
}

class ConsState extends HomeState {
  @override
  List<Object> get props => [];
}

class DrinksState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadedProductsState extends HomeState{
  // final List<Product> bebidas;
  // final List<Product> concentrados;
  final List<Product> favoritos;

  LoadedProductsState({
    @required this.favoritos
  });

  @override 
  List<Object> get props => [favoritos];
}
