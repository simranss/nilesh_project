import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {

  PriceTag({Key key, this.price}) : super(key: key);
  final int price;

  @override
  Widget build(BuildContext context) {

    if (price != null) {
      return Column(
        children: [
          SizedBox(height: 20,),
          Text(
            "₹$price/kg",
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      );
    } else {
      return SizedBox(height: 0,);
    }
  }
}