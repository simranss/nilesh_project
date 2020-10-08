import 'package:flutter/material.dart';
import 'item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Shop extends StatelessWidget {

  final List<String> _categories = [
    "Fruits",
    "Vegetables",
    "Spices",
    "Pulses",
    "Grains",
  ];

  @override
  Widget build(BuildContext context) {

    final double itemWidth = 0.5 * MediaQuery.of(context).size.width;
    final double itemHeight = 0.6 * MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 0,
          child: Center(
            child: Text(
              "SHOP BY CATEGORY",
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 16,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: null,
              builder: (context, snapshot) {
                return GridView.count(
                    childAspectRatio: (itemWidth / itemHeight),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(_categories.length, (index) {
                      if(index.isEven) {
                        return Item(title: _categories[index], left: 16.0, right: 8.0,);
                      } else if(index.isOdd) {
                        return Item(title: _categories[index], left: 8.0, right: 16.0,);
                      } else {
                        return null;
                      }
                    })
                );
              }
            ),
          ),
        ),
      ],
    );
  }
}
