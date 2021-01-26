import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onSignOut;

  HomePage({this.onSignOut});

  void _signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      onSignOut();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: _signOutUser,
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
