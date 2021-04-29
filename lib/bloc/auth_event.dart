part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SplashScreenEvent extends AuthEvent {}

class ShowRegisterEvent extends AuthEvent {}

class ShowLoginEvent extends AuthEvent {}

class VerifyAuthenticationEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignOutAuthenticationEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
