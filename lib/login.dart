import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nilesh_project/main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final auth = FirebaseAuth.instance;

  String _phone;
  bool _codeSent = false;
  String _code;
  String verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('+91'),
                SizedBox(width: 20.0,),
                Expanded(
                  child: TextField(
                    enabled: (!_codeSent),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter your phone number'),
                    onChanged: (value) {
                      setState(() {
                        this._phone = value;
                      });
                    },
                  ),
                )
              ],
            ),
            _codeSent? TextField(
              enabled: (_codeSent),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter the OTP'),
              onChanged: (value) {
                setState(() {
                  this._code = value;
                });
              },
            ): Container(),
            SizedBox(height: 20.0,),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                child: (!_codeSent)?Text('Verify', style: TextStyle(fontSize: 18),):Text('OTP', style: TextStyle(fontSize: 18),),
              ),
              onPressed: () {
                if (!_codeSent) {
                  if (_phone.trim().length == 10) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('Is +91 ' + _phone.trim() + ' correct and you don\'t wish to change it'),
                          actions: [
                            TextButton(
                              child: Text('No', style: TextStyle(color: Colors.black),),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text('Yes, continue', style: TextStyle(color: Colors.green),),
                              onPressed: () {
                                print('\ncontinue pressed\n');
                                _registerUser('+91' + _phone.trim(), context);
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      }
                    );
                  } else {
                    MyHomePage().showError('Please enter a valid phone number', context);
                  }
                } else {
                  if(_code.trim().length == 6) {
                    MyHomePage().signInWithOTP(_code, verificationId, context);
                  } else {
                    MyHomePage().showError('Invalid OTP', context);
                  }
                }
              }
            ),
          ],
        ),
      )
    );
  }

  Future<void> _registerUser(String mobile, BuildContext context) async {
    await auth.verifyPhoneNumber(
      phoneNumber: mobile,

      timeout: const Duration(seconds: 30),

      verificationCompleted: (PhoneAuthCredential credential) {
        MyHomePage().signIn(credential, context);
      },

      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          MyHomePage().showError('The provided phone number is not valid.', context);
        }
      },

      codeSent: (String verificationId, int resendToken) {
        print('Code sent');
        this.verificationId = verificationId;
        setState(() {
          _codeSent = true;
        });
      },

      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }
}
