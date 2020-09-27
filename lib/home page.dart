import 'package:flutter/material.dart';
import 'package:nilesh_project/cart.dart';
import 'package:nilesh_project/contact.dart';
import 'package:nilesh_project/history.dart';
import 'package:nilesh_project/search.dart';
import 'package:nilesh_project/shop.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  int _currentIndex = 1;
  final List<Widget> _bottomScreens = [
    History(),
    Shop(),
    Cart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.green,
        selectedIconTheme: IconThemeData(size: 40),
        selectedItemColor: Colors.white,
        selectedFontSize: 14,
        unselectedItemColor: Colors.white.withOpacity(.60),
        unselectedFontSize: 14,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              title: Text("My Orders"),
              icon: Icon(Icons.history)
          ),
          BottomNavigationBarItem(
              title: Text("Shop"),
              icon: Icon(Icons.shopping_basket,)
          ),
          BottomNavigationBarItem(
              title: Text("Cart"),
              icon: Icon(Icons.shopping_cart)
          ),
        ],
      ),
      body: _bottomScreens[_currentIndex],
    );
  }
}