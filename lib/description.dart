import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nilesh_project/price%20tag.dart';

class Description extends StatefulWidget {

  Description({Key key, this.category, this.title}) : super(key: key);
  final String category;
  final String title;

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  String name;
  int price;
  int newPrice;
  double quantity = 1;

  @override
  Widget build(BuildContext context) {
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
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("categories").doc(widget.category.toLowerCase())
                      .collection(widget.category.toLowerCase()).doc(widget.title.toLowerCase()).snapshots(),
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
                    print(snapshot);
                    print(snapshot.data);
                    print(snapshot.data.data());
                    name = snapshot.data.data()["name"];
                    price = snapshot.data.data()["price"];
                    newPrice = (price * quantity).round();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Image(
                            image: AssetImage("assets/fruits.jpg"),
                          ),
                        ),
                        PriceTag(price: price,),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Text(
                                "₹" + newPrice.toString(), style: TextStyle(color: Colors.black, fontSize: 20,),
                              ),
                              Spacer(),
                              IconButton(icon: Icon(Icons.remove), onPressed: _decrement),
                              Text(quantity.toString() + " kg", style: TextStyle(color: Colors.black, fontSize: 20,),),
                              IconButton(icon: Icon(Icons.add), onPressed: _increment,),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ]
      ),
      bottomSheet: Row(
        children: <Expanded>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                onPressed: _wishlist,
                icon: Icon(Icons.favorite, color: Colors.green,),
                label: Text("Wishlist", style: TextStyle(color: Colors.green),),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: _addCart,
                icon: Icon(Icons.add_shopping_cart, color: Colors.white,),
                label: Text("Add to cart", style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
              ),
            ),
          ),
        ],
      )
    );
  }

  void _increment() {
    setState(() {
      quantity = quantity + 0.5;
      newPrice = (price * quantity).round();
    });
  }
  
  void _decrement() {
    setState(() {
      if (quantity > 0.5) {
        quantity = quantity - 0.5;
      }
      newPrice = (price * quantity).round();
    });
  }

  void _wishlist() {

  }

  void _addCart() {

  }
}