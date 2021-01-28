import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/form_submit_button.dart';

class EmailSignInForm extends StatelessWidget {
  List<Widget> _buildChilderen() {
    return [
      TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@gmail.com',
        ),
      ),
      SizedBox(height: 10.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(height: 10.0),
      FormSubmitButton(
        onPressed: () {},
        text: 'Sign In',
      ),
      SizedBox(height: 8.0),
      FlatButton(
          onPressed: () {},
          child: Text(
            'Need an account? Register',
          ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChilderen(),
      ),
    );
  }
}
