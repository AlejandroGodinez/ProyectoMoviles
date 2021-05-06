part of 'product_favorite_bloc.dart';

abstract class ProductFavoriteState extends Equatable {
  const ProductFavoriteState();

  @override
  List<Object> get props => [];
}

class ProductFavoriteInitial extends ProductFavoriteState {}

class FavoriteAddedState extends ProductFavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteDeletedState extends ProductFavoriteState {
  @override
  List<Object> get props => [];
}

class PurchaseState extends ProductFavoriteState {
  @override
  List<Object> get props => [];
}

class ProductAddedState extends ProductFavoriteState {
  @override
  List<Object> get props => [];
}

class MultipleAddToCartState extends ProductFavoriteState {
  @override
  List<Object> get props => [];
}

class PurchaseBackState extends ProductFavoriteState {
  @override
  List<Object> get props => [];
}
