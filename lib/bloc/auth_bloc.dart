import 'dart:async';

import 'package:ProyectoMoviles/auth/user_auth_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  // auth provider
  UserAuthProvider _authProvider = UserAuthProvider();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is VerifyAuthenticationEvent) {
      // requests a APIs
      // acceso a BD locales
      // revisar acceso a internet
      // lo que debamos hacer para inicializar datos de la app
      //Future.delayed(Duration(seconds: 3));
      if (_authProvider.isAlreadyLogged())
        yield AlreadyAuthState();
      else
        yield UnAuthState();
    }
    if (event is SignOutAuthenticationEvent) {
      if (FirebaseAuth.instance.currentUser.isAnonymous) {
        await _authProvider.signOutFirebase();
      } else {
        await _authProvider.signOutFirebase();
        await _authProvider.signOutGoogle();
      }
      yield UnAuthState();
    }
  }
}
