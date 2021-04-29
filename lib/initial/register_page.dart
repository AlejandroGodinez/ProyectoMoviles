import 'package:ProyectoMoviles/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/constants.dart';
import 'bloc/login_bloc.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool hidePswd1 = true;
  bool hidePswd2 = true;

  LoginBloc _loginBloc = LoginBloc();

  var email = TextEditingController();
  var name = TextEditingController();
  var pass = TextEditingController();
  var confirmPass = TextEditingController();

  void _emailRegister(bool _) {
    // invocar al login de firebase con el bloc
    // recodar configurar pantallad Oauth en google Cloud
    print("email and password");
    _loginBloc.add(
        RegisterEvent(email: email.text, password: pass.text, name: name.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return _loginBloc;
      },
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Error al registrar"),
                  content: Text(
                    state.error,
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    MaterialButton(
                      color: buttonBlue,
                      textColor: white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    )
                  ],
                );
              },
            );
          } else if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Usuario registrado con éxito"),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is LoginSuccessState) {
            BlocProvider.of<AuthBloc>(context).add(VerifyAuthenticationEvent());
          }
          return Scaffold(
            backgroundColor: orange,
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Text("Ingresa tus datos ",
                          style: TextStyle(
                              color: white,
                              fontSize: 30,
                              fontWeight: FontWeight.w900)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: name,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: email,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Correo',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: pass,
                          obscureText: hidePswd1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              iconSize: 25,
                              icon: (hidePswd1
                                  ? Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.grey,
                                    )),
                              onPressed: () {
                                setState(() {
                                  hidePswd1 = !hidePswd1;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          //TODO implementar comparacion de contraseñas
                          controller: confirmPass,
                          obscureText: hidePswd2,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Confirmar Contraseña',
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              iconSize: 25,
                              icon: (hidePswd2
                                  ? Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.grey,
                                    )),
                              onPressed: () {
                                print(hidePswd2);
                                setState(() {
                                  hidePswd2 = !hidePswd2;
                                });
                                print(hidePswd2);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: buttonBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Registrar',
                            style: TextStyle(color: white, fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          //Navigator.of(context).pushNamed('/home');
                          if (pass.text == confirmPass.text) {
                            _emailRegister(true);
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text("Error al registrar"),
                                  content: Text(
                                    "Las contraseñas no coinciden",
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    MaterialButton(
                                      color: buttonBlue,
                                      textColor: white,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(ShowLoginEvent());
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '¿Ya tienes cuenta?',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: buttonBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '\nInicia Sesión',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: buttonBlue,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
