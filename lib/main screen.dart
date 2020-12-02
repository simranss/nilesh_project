import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nilesh_project/contact.dart';
import 'package:nilesh_project/main.dart';
import 'package:nilesh_project/wishlist.dart';

import 'home page.dart';

class MainScreen extends StatefulWidget {

  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  int _currentScreen = 0;
  final List<Widget> _drawerScreens = [
    MainPage(),
    Wishlist(),
    Contact(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key, //In case you want to change the icon of drawer icon

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: (auth.currentUser.displayName == null)? null : Text(auth.currentUser.displayName), //Text(auth.currentUser.displayName),
              accountEmail: Text(auth.currentUser.phoneNumber),
              decoration: BoxDecoration(color: Colors.green),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                if (_currentScreen != 0) {
                  setState(() {
                    _currentScreen = 0;
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Wish list"),
              onTap: () {
                Navigator.pop(context);
                if (_currentScreen != 1) {
                  setState(() {
                    _currentScreen = 1;
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
                if (_currentScreen != 2) {
                  setState(() {
                    _currentScreen = 2;
                  });
                }
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                MyHomePage().signOut();
              },
            )
          ],
        ),
      ),

      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 0.20 * MediaQuery
                .of(context)
                .size
                .height,
            padding: EdgeInsets.only(left: 10.0, right: 20.0, top: 60.0),
            alignment: Alignment.topCenter,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.menu),
                    color: Colors.black,
                    onPressed: () {
                      _key.currentState.openDrawer();
                    }
                ),
                Container(
                  width: (0.75 * MediaQuery
                      .of(context)
                      .size
                      .width),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search here",
                      contentPadding: EdgeInsets.only(
                        bottom: 0.0, left: 12.0, right: 12.0,),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey,
                          width: 0.5,),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey,
                          width: 0.5,),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 18,),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: EdgeInsets.zero,
              child: _drawerScreens[_currentScreen],
            ),
          )
        ],
      )
    );
  }
}
