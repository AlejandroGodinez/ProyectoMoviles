part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
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

class InitialEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class ShowCartEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HelpEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class OrderEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class ShowCartItemEvent extends HomeEvent {
  final Product product;
  final bool isfavorite;

  ShowCartItemEvent({
    @required this.product, 
    @required this.isfavorite
  });

  @override
  List<Object> get props => [product, isfavorite];
}
