import 'package:ProyectoMoviles/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orange,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: orange,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Column(
                  children: [
                    Text('data'),
                    Text('data'),
                    Text('data'),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: MediaQuery.of(context).size.width * 0.01),
              child: Image.network(
                "https://cdn.shopify.com/s/files/1/0087/6065/5938/products/green-tea-15-5oz-can_2000x.png?v=1581728927",
                height: 200,
                width: 200,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.4,
                left: MediaQuery.of(context).size.width * 0.05,
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '¿Necesitas ayuda?\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: 'Envíanos un mensaje',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.5,
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
              ),
              child: TextField(
                maxLines: 6,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.72,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.height * 0.35,
                height: MediaQuery.of(context).size.height * 0.06,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: orange,
                  ),
                  child: Text(
                    'Enviar mensaje',
                    style: TextStyle(
                      color: white,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.8,
              ),
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Tienes alguna duda? Llamanos',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Icon(
                      Icons.phone,
                      color: orange,
                    )
                  ],
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
