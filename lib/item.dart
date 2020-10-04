import 'package:flutter/material.dart';
import 'items.dart';

class Item extends StatelessWidget {

  Item({Key key, this.title, this.left, this.right, this.price}) : super(key: key);
  final String title;
  final double left;
  final double right;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: left, top: 16.0, right: right,),
      child: Center(
        child: Card(
          color: Colors.green.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          elevation: 2,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 60.0,),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32,),
                  Image(image: AssetImage("assets/fruits.jpg"))
                ],
              ),
            ),
            splashColor: Colors.green.withOpacity(0.5),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Items()));
            },
          ),
        ),
      )
    );
  }
}