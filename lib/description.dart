import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool wishlisted;
  bool addedToCart;

  final user = FirebaseAuth.instance.currentUser;
  final users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {

    final item = FirebaseFirestore.instance.collection("categories").doc(widget.category.toLowerCase()).collection(widget.category.toLowerCase()).doc(widget.title.toLowerCase());

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
                  stream: item.snapshots(),
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
              child: StreamBuilder(
                stream: users.doc(user.phoneNumber).collection("wishlist").doc(widget.title).snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    wishlisted = false;
                  } else {
                    print("Wishlist data: " + snapshot.data.data().toString());
                    wishlisted = true;
                  }
                  return TextButton.icon(
                    onPressed: _wishlist,
                    icon: wishlisted?Icon(Icons.favorite, color: Colors.green,):Icon(Icons.favorite_border, color: Colors.green,),
                    label: wishlisted?Text("Wishlisted", style: TextStyle(color: Colors.grey),):Text("Wishlist", style: TextStyle(color: Colors.green),),
                  );
                }
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: users.doc(user.phoneNumber).collection("cart").snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    print("No data");
                    addedToCart = false;
                  } else {
                    print("Cart data: " +  snapshot.toString());
                    addedToCart = true;
                  }
                  return ElevatedButton.icon(
                    onPressed: _addCart,
                    icon: addedToCart?Icon(Icons.remove_shopping_cart, color: Colors.white,):Icon(Icons.add_shopping_cart, color: Colors.white,),
                    label: addedToCart?Text("Remove", style: TextStyle(color: Colors.white),):Text("Add to cart", style: TextStyle(color: Colors.white),),
                    style: addedToCart?ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey)):ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                  );
                }
              )
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
    final i = FirebaseFirestore.instance.collection("categories").doc(widget.category.toLowerCase()).collection(widget.category.toLowerCase()).doc(widget.title.toLowerCase());
    final w = users.doc(user.phoneNumber).collection("wishlist");
    if (wishlisted) {
      w.doc(widget.title).delete();
      setState(() {
        wishlisted = false;
      });
    } else {
      w.doc(widget.title).set({
        "item": i,
      });
      setState(() {
        wishlisted = true;
      });
    }
  }

  void _addCart() {
    final c = users.doc(user.phoneNumber).collection("cart");
    final i = FirebaseFirestore.instance.collection("categories").doc(widget.category.toLowerCase()).collection(widget.category.toLowerCase()).doc(widget.title.toLowerCase());
    if (addedToCart) {
      c.doc(widget.title).delete();
      setState(() {
        addedToCart = false;
      });
    } else {
      c.doc(widget.title).set({
        "item": i,
      });
      setState(() {
        addedToCart = true;
      });
    }
  }
}