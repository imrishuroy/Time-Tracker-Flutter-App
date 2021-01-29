import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_button.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_button.dart';

import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatelessWidget {
  final AuthBase auth;
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  SignInPage({this.auth});

  Future<void> _anoumousSignIn() async {
    try {
      await auth.signInAnounmously();

      // print('${authResult.user.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();

      // print('${authResult.user.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();

      // print('${authResult.user.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        //fullscreenDialog: true,
        builder: (context) => EmailSignInPage(
          auth: auth,
        ),
      ),
    );
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
      body: _buildContent(context),
    );
  }
  // return Center(child: CircularProgressIndicator());

  Widget _buildContent(BuildContext context) {
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
            onPressed: _signInWithGoogle,
            imageUrl: 'images/google-logo.png',
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xff334d92),
            onPressed: _signInWithFacebook,
            imageUrl: 'images/facebook-logo.png',
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'SignIn with Email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () => _signInWithEmail(context),
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
