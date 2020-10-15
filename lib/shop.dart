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

  int counter = 0;

  @override
  Widget build(BuildContext context) {

    final double itemWidth = 0.5 * MediaQuery.of(context).size.width;
    final double itemHeight = 0.6 * MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Center(
          child: Text(
            "SHOP BY CATEGORY",
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0),
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("categories").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Container(
                      width: 0.33333333333333 * MediaQuery.of(context).size.width,
                      height: 0.33333333333333 * MediaQuery.of(context).size.width,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                List<DocumentSnapshot> snapshots = snapshot.data.docs;
                print("Data: $snapshots");
                return GridView.count(
                  childAspectRatio: (itemWidth / itemHeight),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: snapshots.map((data) => _buildGridViewItem(context, data)).toList()
                );
              }
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridViewItem(BuildContext context, DocumentSnapshot data) {

    print("New Data: $data");
    counter++;
    String name = data.data()["name"];
    print("Category: $name");

    if(counter.isOdd) {
      return Item(title: name, left: 16.0, right: 8.0,);
    } else if(counter.isEven) {
      return Item(title: name, left: 8.0, right: 16.0,);
    } else {
      return null;
    }
  }
}
