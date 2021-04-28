part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitialEvent extends LoginEvent {}

class LoginWithFacebookEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginWithGoogleEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginAnonymousEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class ForgotPasswordEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}
