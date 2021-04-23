import 'package:ProyectoMoviles/cart/bloc/cart_bloc.dart';
import 'package:ProyectoMoviles/home/bloc/home_bloc.dart';
import 'package:ProyectoMoviles/home_drawer.dart';
import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    fakeProds = [
      Product(
          idProd: "Naranjita",
          name: "Naranjita",
          amount: 1,
          price: 5,
          type: 'Bebida'),
      Product(
          idProd: "Uva", name: "Uva", amount: 1, price: 6.5, type: 'Bebida'),
      Product(
          idProd: "Sandia",
          name: "Sandia",
          amount: 1,
          price: 7,
          type: 'Bebida'),
      Product(
          idProd: "Melon", name: "Melon", amount: 1, price: 10, type: 'Bebida'),
    ];
    fakeCons = [
      Product(
          idProd: "Cons",
          name: "Naranjita",
          amount: 1,
          price: 5,
          type: 'Concentrado'),
      Product(
          idProd: "Cons",
          name: "Uva",
          amount: 1,
          price: 6.5,
          type: 'Concentrado'),
      Product(
          idProd: "Cons",
          name: "Sandia",
          amount: 1,
          price: 7,
          type: 'Concentrado'),
      Product(
          idProd: "Cons",
          name: "Melon",
          amount: 1,
          price: 10,
          type: 'Concentrado'),
    ];
    // fakeFavs = [
    //   Product(
    //       idProd: "Fav",
    //       name: "Naranjita",
    //       amount: 1,
    //       price: 5,
    //       type: 'Bebida'),
    //   Product(
    //       idProd: "Fav",
    //       name: "Uva",
    //       amount: 1,
    //       price: 6.5,
    //       type: 'Concentrado'),
    //   Product(
    //       idProd: "Fav", name: "Sandia", amount: 1, price: 7, type: 'Bebida'),
    //   Product(
    //       idProd: "Fav",
    //       name: "Melon",
    //       amount: 1,
    //       price: 10,
    //       type: 'Concentrado'),
    // ];
    super.initState();
  }

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
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
            )
          ],
        ),
        drawer: HomeDrawer(),
        body: BlocProvider(
          create: (context) => HomeBloc()..add(InitialEvent()),
          child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
            if (state is ProductAddedState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Agregado al carrito"),
                  ),
                );
            }
            if (state is LoadedProductsState) {
              favsList = state.favoritos;
            }
          }, builder: (context, state) {
            print(favsList);
            if (state is FavoritesState) {
              return HomeMain(
                  buttonState: 3, prods: state.product, favs: favsList);
            } else if (state is ConsState) {
              return HomeMain(buttonState: 2, prods: fakeCons, favs: favsList);
            } else if (state is DrinksState) {
              return HomeMain(buttonState: 1, prods: fakeProds, favs: favsList);
            }
            return HomeMain(buttonState: 1, prods: fakeProds, favs: favsList);
          }),
        ));
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
            child: GridView.builder(
              itemCount: prods.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: MediaQuery.of(context).size.height * 0.03,
                  crossAxisSpacing: MediaQuery.of(context).size.height * 0.03,
                  childAspectRatio: 0.8),
              itemBuilder: (context, index) => ItemCard(
                prod: prods[index],
                favoritesList: favs.contains(
                  prods[index],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
