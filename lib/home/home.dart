import 'package:ProyectoMoviles/home_drawer.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

import 'item_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int buttonState = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: white,
        // automaticallyImplyLeading: false,
        centerTitle: true,

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          )
        ],
      ),
      drawer: HomeDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        buttonState = 1;
                      });
                    },
                    child: Text(
                      'Bebidas',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: buttonState == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    height: 2.0,
                    width: 40.0,
                    color: buttonState == 1 ? Colors.grey : Colors.white,
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        buttonState = 2;
                      });
                    },
                    child: Text(
                      'Concentrados',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: buttonState == 2
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    height: 2.0,
                    width: 40.0,
                    color: buttonState == 2 ? Colors.grey : Colors.white,
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        buttonState = 3;
                      });
                    },
                    child: Text(
                      'Favoritos',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: buttonState == 3
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    height: 2.0,
                    width: 40.0,
                    color: buttonState == 3 ? Colors.grey : Colors.white,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: MediaQuery.of(context).size.height * 0.03,
                    crossAxisSpacing: MediaQuery.of(context).size.height * 0.03,
                    childAspectRatio: 0.8),
                itemBuilder: (context, index) => ItemCard(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
