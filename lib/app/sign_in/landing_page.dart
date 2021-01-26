import 'package:flutter/material.dart';
import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //Firebase user
  User _user;

  @override
  void initState() {
    _checkCurrentUser();
    super.initState();
  }

  Future<void> _checkCurrentUser() async {
    User user = await FirebaseAuth.instance.currentUser;
    _updateUser(user);
  }

  void _updateUser(User user) {
    //print('${user.uid}');
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        onSignIn: _updateUser,
      );
    } else {
      return HomePage(
        onSignOut: () => _updateUser(null),
      );
    }
  }
}
