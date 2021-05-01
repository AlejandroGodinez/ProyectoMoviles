import 'package:ProyectoMoviles/home/bloc/home_bloc.dart';
import 'package:ProyectoMoviles/home_drawer.dart';
import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int buttonState = 1;
  List<Product> favsList;
  List<Product> drinksList;
  List<Product> consList;

  @override
  void initState() {
    super.initState();
  }

  var user = FirebaseAuth.instance.currentUser;
  // Box box = Hive.box("Favoritos");
  @override
  Widget build(BuildContext context) {
    Stream misFavoritos = FirebaseFirestore.instance
        .collection('favoritos')
        .doc(user.email)
        .snapshots();
    // return
    // HiveListener(
    //   box: Hive.box("Favoritos"),
    //   keys: ["favoritos"],
    //   builder: (box) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: white,
          // automaticallyImplyLeading: false,
          centerTitle: true,

          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
            )
          ],
        ),
        drawer: HomeDrawer(),
        body: BlocProvider(
          create: (context) => HomeBloc()..add(InitialEvent()),
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is LoadedProductsState) {
                drinksList = state.bebidas;
                consList = state.concentrados;
              }
            },
            builder: (context, state) {
              return StreamBuilder<DocumentSnapshot>(
                  stream: misFavoritos,
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.data != null) {
                      Map<String, dynamic> firestorefavs = snapshot.data.data();
                      if (firestorefavs != null) {
                        favsList = snapshot.data
                            .data()
                            .values
                            .map(
                              (element) => Product(
                                  idProd: element['idProd'],
                                  name: element['name'],
                                  amount: 1,
                                  size: "Chico",
                                  priceCh: element['priceCh'].toDouble(),
                                  priceM: element['priceM'].toDouble(),
                                  priceG: element['priceG'].toDouble(),
                                  type: element['type'],
                                  description: element['description'],
                                  urlToImage: element['urlToImage']),
                            )
                            .toList();
                      } else {
                        favsList = [];
                      }
                    }
                    if (state is FavoritesState) {
                      return HomeMain(
                        buttonState: 3,
                        prods: favsList,
                        favs: favsList,
                      );
                    } else if (state is ConsState) {
                      return HomeMain(
                        buttonState: 2,
                        prods: consList,
                        favs: favsList,
                      );
                    } else if (state is DrinksState) {
                      return HomeMain(
                        buttonState: 1,
                        prods: drinksList,
                        favs: favsList,
                      );
                    } else if (state is LoadedProductsState) {
                      return HomeMain(
                        buttonState: 1,
                        prods: drinksList,
                        favs: favsList,
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
            },
          ),
        ),
      ),
    );
    //   },
    // );
  }
}

class HomeMain extends StatelessWidget {
  const HomeMain({
    Key key,
    @required this.buttonState,
    @required this.prods,
    @required this.favs,
  }) : super(key: key);

  final int buttonState;
  final List<Product> prods;
  final List<Product> favs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
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
                        BlocProvider.of<HomeBloc>(context)
                            .add(ShowDrinksEvent());
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
                        BlocProvider.of<HomeBloc>(context).add(ShowConsEvent());
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
                        BlocProvider.of<HomeBloc>(context).add(ShowFavsEvent());
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
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: prods.length != 0
                ? GridView.builder(
                    itemCount: prods.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing:
                            MediaQuery.of(context).size.height * 0.03,
                        crossAxisSpacing:
                            MediaQuery.of(context).size.height * 0.03,
                        childAspectRatio: 0.8),
                    itemBuilder: (context, index) => ItemCard(
                        prod: prods[index],
                        isfavorite: alreadyFavorite(favs, prods[index])),
                  )
                : Center(
                    child: Text("Todavía no tienes favoritos"),
                  ),
          ),
        ),
      ],
    );
  }

  bool alreadyFavorite(List<Product> list, Product product) {
    Product found = list.firstWhere(
        (element) => element.idProd == product.idProd,
        orElse: () => null);
    if (found != null) return true;
    return false;
  }
}
