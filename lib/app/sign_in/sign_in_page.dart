import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_button.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatelessWidget {
  final Function(User) onSignIn;
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  SignInPage({this.onSignIn});

  Future<void> _anoumousSignIn() async {
    try {
      final authResult = await FirebaseAuth.instance.signInAnonymously();
      onSignIn(authResult.user);

      // print('${authResult.user.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return

        // FutureBuilder(
        //   future: _initialization,
        //   builder: (ctx, snapshot) {
        //     if (snapshot.hasError) {
        //       return Center(child: Text('Something went wrong'));
        //     }
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return

        Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        title: Text('Time Tracker '),
      ),
      body: _buildContent(),
    );
  }
  // return Center(child: CircularProgressIndicator());

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 48.0),
          SocialSignInButton(
            text: 'Sign in with Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: () {},
            imageUrl: 'images/google-logo.png',
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xff334d92),
            onPressed: () {},
            imageUrl: 'images/facebook-logo.png',
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'SignIn with Email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Go Anonymous',
            textColor: Colors.black,
            color: Colors.lime[300],
            onPressed: _anoumousSignIn,
          ),
        ],
      ),
    );
  }
}
