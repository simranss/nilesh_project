import 'package:flutter/material.dart';
import 'package:nilesh_project/home%20page.dart';
import 'contact.dart';
import 'wishlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String name = "Simran", email = "simran@gmail.com";
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

      appBar: AppBar(
        title: Text(widget.title),
        actions: <IconButton>[
          IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: null)
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(accountName: Text(name), accountEmail: Text(email),
              decoration: BoxDecoration(color: Colors.green),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                if(_currentScreen != 0) {
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
                if(_currentScreen != 1) {
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
                if(_currentScreen != 2) {
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
              },
            )
          ],
        ),
      ),

      body: _drawerScreens[_currentScreen]
    );
  }
}
