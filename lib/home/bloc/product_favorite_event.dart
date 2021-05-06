part of 'product_favorite_bloc.dart';

abstract class ProductFavoriteEvent extends Equatable {
  const ProductFavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavoriteEvent extends ProductFavoriteEvent {
  final Product product;
  AddFavoriteEvent({@required this.product});
  @override
  List<Object> get props => [product];
}

class DeleteFavoriteEvent extends ProductFavoriteEvent {
  final Product product;

  DeleteFavoriteEvent({@required this.product});
  @override
  List<Object> get props => [product];
}

class AddToCartEvent extends ProductFavoriteEvent {
  final Product product;

  AddToCartEvent({@required this.product});
  @override
  List<Object> get props => [product];
}

class MultipleAddToCartEvent extends ProductFavoriteEvent {
  final List<Product> products;

  MultipleAddToCartEvent({@required this.products});
  @override
  List<Object> get props => [products];
}

class PurchaseEvent extends ProductFavoriteEvent {
  @override
  List<Object> get props => [];
}

class GetCatalogEvent extends ProductFavoriteEvent {
  @override
  List<Object> get props => [];
}

class PurchaseBackEvent extends ProductFavoriteEvent {
  @override
  List<Object> get props => [];
}
