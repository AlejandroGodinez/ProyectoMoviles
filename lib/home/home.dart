import 'package:ProyectoMoviles/home/bloc/home_bloc.dart';
import 'package:ProyectoMoviles/home_drawer.dart';
import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_listener/hive_listener.dart';

import 'item_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;
  int buttonState = 1;
  List<Product> fakeProds;
  List<Product> fakeCons;
  List<Product> favsList;
  List<Product> drinksList;
  List<Product> consList;

  @override
  void initState() {
    fakeProds = [
      Product(
          idProd: "Naranjita",
          name: "Naranjita",
          amount: 1,
          size: "Chico",
          priceCh: 5,
          priceM: 5,
          priceG: 6,
          type: 'Bebida'),
      Product(
          idProd: "Uva",
          name: "Uva",
          amount: 1,
          size: "Chico",
          priceCh: 6.5,
          priceM: 5,
          priceG: 6,
          type: 'Bebida'),
      Product(
          idProd: "Sandia",
          name: "Sandia",
          amount: 1,
          size: "Chico",
          priceCh: 7,
          priceM: 5,
          priceG: 6,
          type: 'Bebida'),
      Product(
          idProd: "Melon",
          name: "Melon",
          amount: 1,
          size: "Chico",
          priceCh: 10,
          priceM: 5,
          priceG: 6,
          type: 'Bebida'),
      Product(
          idProd: "Chile",
          name: "Chile",
          amount: 1,
          size: "Chico",
          priceCh: 10,
          priceM: 5,
          priceG: 6,
          type: 'Bebida'),
    ];
    fakeCons = [
      Product(
          idProd: "Cons",
          name: "Naranjita",
          amount: 1,
          size: "Chico",
          priceCh: 5,
          priceM: 5,
          priceG: 6,
          type: 'Concentrado'),
      Product(
          idProd: "Cons",
          name: "Uva",
          amount: 1,
          size: "Chico",
          priceCh: 6.5,
          priceM: 5,
          priceG: 6,
          type: 'Concentrado'),
      Product(
          idProd: "Cons",
          name: "Sandia",
          amount: 1,
          size: "Chico",
          priceCh: 7,
          priceM: 5,
          priceG: 6,
          type: 'Concentrado'),
      Product(
          idProd: "Cons",
          name: "Melon",
          amount: 1,
          size: "Chico",
          priceCh: 10,
          priceM: 5,
          priceG: 6,
          type: 'Concentrado'),
    ];
    // fakeFavs = [
    //   Product(
    //       idProd: "Fav",
    //       name: "Naranjita",
    //       amount: 1,
    //      size: "Chico",priceCh: 5,
    //       type: 'Bebida'),
    //   Product(
    //       idProd: "Fav",
    //       name: "Uva",
    //       amount: 1,
    //      size: "Chico",priceCh: 6.5,
    //       type: 'Concentrado'),
    //   Product(
    //       idProd: "Fav", name: "Sandia", amount: 1,size: "Chico",priceCh: 7, type: 'Bebida'),
    //   Product(
    //       idProd: "Fav",
    //       name: "Melon",
    //       amount: 1,
    //      size: "Chico",priceCh: 10,
    //       type: 'Concentrado'),
    // ];
    super.initState();
  }

  Box box = Hive.box("Favoritos");
  @override
  Widget build(BuildContext context) {
    return HiveListener(
      box: Hive.box("Favoritos"),
      keys: ["favoritos"],
      builder: (box) {
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
              child:
                  BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
                if (state is LoadedProductsState) {
                  // drinksList = state.bebidas;
                  // consList = state.concentrados;

                }
              }, builder: (context, state) {
                favsList =
                    List<Product>.from(box.get("favoritos", defaultValue: []));
                if (state is FavoritesState) {
                  return HomeMain(
                      buttonState: 3, prods: favsList, favs: favsList);
                } else if (state is ConsState) {
                  return HomeMain(
                      buttonState: 2, prods: fakeCons, favs: favsList);
                } else if (state is DrinksState) {
                  return HomeMain(
                      buttonState: 1, prods: fakeProds, favs: favsList);
                }
                return HomeMain(buttonState: 1, prods: fakeProds, favs: favsList);
              }),
            ),
          ),
        );
      },
    );
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
