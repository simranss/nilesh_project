import 'package:flutter/material.dart';

class Shop extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "SHOP BY CATEGORY",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Container(

          ),
        ],
      ),
    );
  }
}