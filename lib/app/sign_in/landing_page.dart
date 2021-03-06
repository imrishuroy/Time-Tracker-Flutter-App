import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/home/home_page.dart';
import 'package:time_tracker/jobs/jobs_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';

import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/database.dart';

class LandingPage extends StatelessWidget {
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
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<AppUser>(
      stream: auth.onAuthStateChanged,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          AppUser user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          } else {
            return Provider<AppUser>.value(
              value: user,
              child: Provider<DataBase>(
                create: (_) => FirestoreDataBase(uid: user.uid),
                child: HomePage(),
              ),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
