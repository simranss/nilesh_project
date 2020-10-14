import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {

  PriceTag({Key key, this.price}) : super(key: key);
  final int price;

  @override
  Widget build(BuildContext context) {

    if (price != null) {
      return Column(
        children: [
          SizedBox(height: 32,),
          Text("₹$price")
        ],
      );
    } else {
      return SizedBox(height: 0,);
    }
  }
}