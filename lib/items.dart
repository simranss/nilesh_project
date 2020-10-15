import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nilesh_project/item.dart';

class Items extends StatelessWidget{

  final String searchQuery;
  final String category;
  Items({Key key, this.searchQuery, this.category}) : super(key: key);

  String title;

  int counter = 0;

  @override
  Widget build(BuildContext context) {

    if (category != null) {
      title = category;
    } else if (searchQuery != null) {
      title = "\"$searchQuery\"";
    }

    final double itemWidth = 0.5 * MediaQuery.of(context).size.width;
    final double itemHeight = 0.6 * MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 0.20 * MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 10.0, right: 20.0, top: 60.0),
            alignment: Alignment.topCenter,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.black,
                  onPressed: (){Navigator.pop(context);}
                ),
                Container(
                  width: (0.75 * MediaQuery.of(context).size.width),
                  padding: EdgeInsets.only(left: 30.0,),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("categories").doc(category.toLowerCase()).collection(category.toLowerCase()).snapshots(),
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
      ),
    );
  }

  Widget _buildGridViewItem(BuildContext context, DocumentSnapshot data) {

    print("New Data: $data");
    counter++;
    String name = data.data()["name"];
    int price = data.data()["price"];
    print("Item: $name");

    if(counter.isOdd) {
      return Item(title: name, price: price, left: 16.0, right: 8.0,);
    } else if(counter.isEven) {
      return Item(title: name, price: price, left: 8.0, right: 16.0,);
    } else {
      return null;
    }
  }
}