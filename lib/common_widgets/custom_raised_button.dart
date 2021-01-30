import 'package:flutter/material.dart';

class CustomRaisedButon extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color color;

  final double height;

  const CustomRaisedButon({
    Key key,
    this.onPressed,
    this.borderRadius: 2.0,
    this.color,
    this.child,
    this.height: 50.0,
  })  : assert(borderRadius != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        color: color,
        disabledColor: color,
        onPressed: onPressed,
        child: child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
