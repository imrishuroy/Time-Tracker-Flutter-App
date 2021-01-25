import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/custom_raised_button.dart';

class SignInButton extends CustomRaisedButon {
  SignInButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15.0,
              color: textColor,
            ),
          ),
          color: color,
          onPressed: onPressed,
          borderRadius: 5.0,
        );
}
