import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButon {
  SocialSignInButton({
    @required String imageUrl,
    @required String text,
    VoidCallback onPressed,
    Color color,
    Color textColor,
  })  : assert(text != null),
        assert(imageUrl != null),
        super(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(imageUrl),
                Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image.asset(imageUrl),
                ),
              ],
            ),
            onPressed: onPressed,
            color: color,
            borderRadius: 5.0);
}
