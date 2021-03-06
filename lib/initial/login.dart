import 'package:ProyectoMoviles/bloc/auth_bloc.dart';
import 'package:ProyectoMoviles/initial/bloc/login_bloc.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  bool hidePswd = true;
  bool _showLoading = false;

  var email = TextEditingController();
  var pass = TextEditingController();

  void _googleLogIn(bool _) {
    // invocar al login de firebase con el bloc
    // recodar configurar pantallad Oauth en google Cloud
    print("google");
    _loginBloc.add(LoginWithGoogleEvent());
  }

  void _emailLogIn(bool _) {
    // invocar al login de firebase con el bloc
    // recodar configurar pantallad Oauth en google Cloud
    print("email and password");
    _loginBloc.add(LoginWithEmailEvent(email: email.text, password: pass.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _loginBloc = LoginBloc();
        return _loginBloc;
      },
      child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
        if (state is LoginErrorState) {
          _showLoading = false;
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("Error en inicio de sesion"),
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
        } else if (state is LoginLoadingState) {
          _showLoading = !_showLoading;
        }
      }, builder: (context, state) {
        if (state is LoginSuccessState) {
          //return HomePage();
          // Navigator.of(context).pushNamed('/home');
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
                    FractionallySizedBox(
                      widthFactor: 0.75,
                      child: Image.asset(
                        'assets/logo-nicetea.png',
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
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
                        obscureText: hidePswd,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            iconSize: 25,
                            icon: (hidePswd
                                ? Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.grey,
                                  )),
                            onPressed: () {
                              print(hidePswd);
                              setState(() {
                                hidePswd = !hidePswd;
                              });
                              print(hidePswd);
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
                          'Iniciar sesion',
                          style: TextStyle(color: white, fontSize: 20),
                        ),
                      ),
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/home');
                        _emailLogIn(true);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        children: [
                          Expanded(
                            child: GoogleAuthButton(
                              onPressed: () => _googleLogIn(true),
                              text: "Iniciar con Google",
                              darkMode: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(ShowRegisterEvent());
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '¿No tienes cuenta?',
                              style: TextStyle(
                                fontSize: 18,
                                color: buttonBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '\nRegistrate',
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
      }),
    );
  }
}
