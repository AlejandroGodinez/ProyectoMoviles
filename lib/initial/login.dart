import 'package:flutter/material.dart';
import 'package:ProyectoMoviles/utils/constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePswd = true;
  @override
  Widget build(BuildContext context) {
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
                    'assets/logo-nicetea.jpg',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
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
                    Navigator.of(context).pushNamed('/home');
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
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
  }
}
