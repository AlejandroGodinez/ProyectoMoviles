import 'package:flutter/material.dart';

import '../utils/constants.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool hidePswd1 = true;
  bool hidePswd2 = true;
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
                    Navigator.of(context).pushNamed('/home');
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
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
  }
}
