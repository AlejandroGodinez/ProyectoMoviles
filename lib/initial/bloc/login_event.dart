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

class LoginWithEmailEvent extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmailEvent({@required this.email, @required this.password});

  @override
  List<Object> get props => [];
}

class RegisterEvent extends LoginEvent {
  final String email;
  final String password;
  final String name;

  RegisterEvent({
    @required this.email,
    @required this.password,
    @required this.name,
  });

  @override
  List<Object> get props => [];
}

class ForgotPasswordEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}
