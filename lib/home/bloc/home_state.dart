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

class FavoritesState extends HomeState {
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
