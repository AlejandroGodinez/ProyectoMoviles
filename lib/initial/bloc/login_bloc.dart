import 'dart:async';

import 'package:ProyectoMoviles/auth/user_auth_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  // auth provider
  UserAuthProvider _authProvider = UserAuthProvider();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGoogleEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.signInWithGoogle();
        yield LoginSuccessState();
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(error: 'Error al hacer login: ${e.toString()}');
      }
    } else if (event is LoginAnonymousEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.anonymousSignIn();
        yield LoginSuccessState();
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(error: 'Error al hacer login: ${e.toString()}');
      }
    } else if (event is RegisterEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.registerNewUser(
            event.email, event.password, event.name);
        yield RegisterSuccessState();
        try {
          yield LoginLoadingState();
          await _authProvider.loginEmailUser(event.email, event.password);
          yield LoginSuccessState();
        } catch (e) {
          print(e.toString());
          yield LoginErrorState(error: '${e.message}');
        }
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(error: 'Error al hacer login: ${e.message}');
      }
    } else if (event is LoginWithEmailEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.loginEmailUser(event.email, event.password);
        yield LoginSuccessState();
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(error: '${e.message}');
      }
    }
  }
}
