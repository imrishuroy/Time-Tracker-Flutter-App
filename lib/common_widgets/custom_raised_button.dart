import 'package:flutter/material.dart';

class CustomRaisedButon extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color color;

  const CustomRaisedButon(
      {Key key, this.onPressed, this.borderRadius: 2.0, this.color, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      onPressed: onPressed,
      child: child,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
    );
  }
}
