import 'package:flutter/material.dart';
import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';

import 'package:time_tracker/services/auth.dart';

class LandingPage extends StatelessWidget {
  final AuthBase auth;

  const LandingPage({this.auth});

  //Firebase user
  // AppUser _user;

  // @override
  // void initState() {
  //   _checkCurrentUser();
  //   widget.auth.onAuthStateChanged.listen((user) {
  //     print(user?.uid);
  //   });

  //   super.initState();
  // }

  // Future<void> _checkCurrentUser() async {
  //   AppUser user = await widget.auth.currentUser();
  //   _updateUser(user);
  // }

  // void _updateUser(AppUser user) {
  //   //print('${user.uid}');
  //   setState(() {
  //     _user = user;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser>(
        stream: auth.onAuthStateChanged,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            AppUser user = snapshot.data;
            if (user == null) {
              return SignInPage(
                auth: auth,
              );
            } else {
              return HomePage(
                auth: auth,
              );
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
