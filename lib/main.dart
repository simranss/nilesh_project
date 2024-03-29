import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:nilesh_project/login.dart';
import 'package:nilesh_project/main%20screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: MyHomePage().handleAuth(),
    );
  }
}

class MyHomePage {

  final auth = FirebaseAuth.instance;
  final users = FirebaseFirestore.instance.collection('users');

  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return MainScreen();
        } else {
          return Login();
        }
      }
    );
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds, BuildContext context, String name) {
    print("Logging in");
    FirebaseAuth.instance.signInWithCredential(authCreds).catchError((e) {
      showError(e.toString(), context);
    }).then((result) {
      print("Logged in");
      result.user.updateProfile(displayName: name);
      users.doc(result.user.phoneNumber).get().then((documentSnapshot) {
        if(!documentSnapshot.exists) {
          users.doc(result.user.phoneNumber).set({
            "name" : name,
            "number" : result.user.phoneNumber,
          });
        }
      });
    });
  }

  signInWithOTP(smsCode, verId, context, name) {
    print("Logging in with OTP");
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds, context, name);
  }

  showError (String errorMessage, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Okay'),
              )
            ],
          );
        }
    );
  }
}
