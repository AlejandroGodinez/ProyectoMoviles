import 'dart:async';

import 'package:ProyectoMoviles/auth/user_auth_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  // auth provider
  UserAuthProvider _authProvider = UserAuthProvider();
  Box _cartBox = Hive.box("Carrito");

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SplashScreenEvent) {
      yield AuthInitial();
    }
    if (event is ShowRegisterEvent) {
      yield RegisterState();
    }
    if (event is ShowLoginEvent) {
      yield UnAuthState();
    }
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
      //borrado de la lista de hive
      await _cartBox.put("bebidas", []);
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
