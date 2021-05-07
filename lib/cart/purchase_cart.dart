import 'package:ProyectoMoviles/cart/bloc/cart_bloc.dart';
import 'package:ProyectoMoviles/home/bloc/home_bloc.dart';
import 'package:ProyectoMoviles/model/order.dart';
import 'package:ProyectoMoviles/model/product.dart';
import 'package:ProyectoMoviles/utils/secrets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PurchaseCart extends StatefulWidget {
  final List<Product> prodlist;
  String payment = "Efectivo";
  PurchaseCart({Key key, @required this.prodlist}) : super(key: key);

  @override
  _PurchaseCartState createState() => _PurchaseCartState();
}

class _PurchaseCartState extends State<PurchaseCart> {
  var user = FirebaseAuth.instance.currentUser;
  double _total = 0;
  double _totalProductos = 0;
  double _envio = 50;

  //Google maps stuff bruh
  var id;
  String _currentAddress;
  TextEditingController searchController = TextEditingController();
  Set<Marker> _mapMarkers = Set();
  GoogleMapController _mapController;
  Position _currentPosition;
  Position _defaultPosition = Position(
    speed: 0.0,
    heading: 0.0,
    accuracy: 0.0,
    longitude: 20.608148,
    latitude: -103.417576,
  );

  Future<void> _onMapCreated(controller) {
    _mapController = controller;
    _getCurrentPosition();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    for (var item in widget.prodlist) {
      double selectedPrice = item.size == "Chico"
          ? item.priceCh
          : item.size == "Mediano"
          ? item.priceM
          : item.priceG;
      _totalProductos += (item.amount * selectedPrice);
    }

    _total += _totalProductos + _envio;
  }

  String messageToSend(String nonce) {
    String products = "";
    for (var item in widget.prodlist) {
      products +=
          "${item.amount} ${item.type}${item.amount > 1 ? 's' : ''} ${item.type == 'Bebida' && item.size == 'Chico' ? 'Chica' : item.type == 'Bebida' && item.size == 'Mediano' ? 'Mediana' : item.size}${item.amount > 1 ? 's' : ''} de ${item.name} \n";
    }
    String msg =
        '''Hola buen dia. He hecho un pedido por la aplicacion N-ICE Tea.\nMi pedido lleva lo siguiente:\n$products\nTotal del pedido: $_total\nMétodo de pago:${widget.payment}\nMi direccion es:\n${searchController.text}\n''';
    msg = nonce != "" ? msg + "Codigo Paypal: $nonce\n": msg;
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) _currentPosition = _defaultPosition;
    return BlocProvider(
      create: (context) => CartBloc(),
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            color: white,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Text('Elige un método de pago',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.payment = "Efectivo";
                                    });
                                  },
                                  icon: Icon(Icons.payments_rounded),
                                  iconSize: 40,
                                  color: widget.payment == "Efectivo"
                                      ? orange
                                      : Colors.grey),
                              Text("Efectivo")
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.payment = "PayPal";
                                    });
                                  },
                                  icon: Icon(Icons.payment),
                                  iconSize: 40,
                                  color: widget.payment == "PayPal"
                                      ? orange
                                      : Colors.grey),
                              Text("PayPal")
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Row(
                        children: [
                          Text('Elige la dirección de envío:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: searchController,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              var pos = await _getAddressFromText();
                              _setMarker(pos);
                            },
                            icon: Icon(Icons.search),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Center(
                            child: GoogleMap(
                          markers: _mapMarkers,
                          onMapCreated: _onMapCreated,
                          onLongPress: _setMarker,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              _currentPosition.latitude,
                              _currentPosition.longitude,
                            ),
                            zoom: 10,
                          ),
                        )),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Productos",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Envio",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    "TOTAL",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$$_totalProductos",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "\$$_envio",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    "\$$_total",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45.0),
                              ),
                              backgroundColor: orange,
                            ),
                            child: Text(
                              'Comprar',
                              style: TextStyle(
                                color: white,
                              ),
                            ),
                            onPressed: () async{
                              String strNonce = "";
                              if(widget.payment == 'PayPal'){
                                var request = BraintreeDropInRequest(
                                  tokenizationKey: sandBoxKey,
                                  collectDeviceData: true,
                                  paypalRequest: BraintreePayPalRequest(
                                    // amount: '1.0', 
                                    amount: _total.toString(), 
                                    displayName: 'NICE',
                                    
                                  ),
                                  cardEnabled: false,
                                );

                                BraintreeDropInResult result;
                                try {
                                  result =  await BraintreeDropIn.start(request);  
                                } catch (e) {
                                  print(e);
                                }
                                
                                if(result != null){
                                  print(result.paymentMethodNonce.description);
                                  print(result.paymentMethodNonce.nonce);
                                  strNonce = result.paymentMethodNonce.nonce + "\nDe: " + result.paymentMethodNonce.description;
                                }
                              }
                              
                              BlocProvider.of<CartBloc>(context).add(
                                SaveOrderEvent(
                                  orden: Order(
                                      client: user.email,
                                      date: DateTime.now().toString(),
                                      prodList: widget.prodlist,
                                      total: _total),
                                ),
                              );
                              
                              FlutterOpenWhatsapp.sendSingleMessage(
                                  "523310907312", messageToSend(strNonce));
                              BlocProvider.of<HomeBloc>(context).add(
                                GetOrdersEvent(),
                              );
                              strNonce = "";
                              
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    // verify permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    // get current position
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // get address
    _currentAddress = await _getGeocodingAddress(_currentPosition);

    searchController.text = _currentAddress;
    //MarkerID
    id = MarkerId(_currentPosition.toString());

    // add marker
    _mapMarkers.add(
      Marker(
        markerId: id,
        position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        infoWindow: InfoWindow(
          title: _currentPosition.toString(),
          snippet: _currentAddress,
        ),
      ),
    );

    //mover camara
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
          zoom: 15.0,
        ),
      ),
    );
  }

  void _setMarker(LatLng coord) async {
    // get address
    String _markerAddress = await _getGeocodingAddress(
      Position(
        latitude: coord.latitude,
        longitude: coord.longitude,
      ),
    );

    _currentPosition = Position(
      latitude: coord.latitude,
      longitude: coord.longitude,
    );

    _currentAddress = await _getGeocodingAddress(_currentPosition);

    searchController.text = _currentAddress;

    // add marker
    setState(() {
      _mapMarkers = Set();
      _mapMarkers.add(
        Marker(
          markerId: MarkerId(coord.toString()),
          position: coord,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: coord.toString(),
            snippet: _markerAddress,
          ),
        ),
      );
    });

    //mover camara
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
          zoom: 15.0,
        ),
      ),
    );
  }

  Future<String> _getGeocodingAddress(Position position) async {
    // geocoding
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places != null && places.isNotEmpty) {
      final Placemark place = places.first;
      return "${place.street}, ${place.locality}";
    }
    return "No address available";
  }

  Future<LatLng> _getAddressFromText() async {
    // geocoding
    var places = await locationFromAddress(searchController.text);
    if (places != null && places.isNotEmpty) {
      final Location place = places.first;
      return LatLng(place.latitude, place.longitude);
    }
    return LatLng(_currentPosition.latitude, _currentPosition.longitude);
  }
}
