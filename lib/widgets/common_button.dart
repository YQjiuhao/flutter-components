import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonButton extends StatelessWidget {
  CommonButton(
      {@required this.title,
      @required this.onPressed,
      this.margin,
      this.color});

  final String title;

  final VoidCallback onPressed;

  final EdgeInsetsGeometry margin;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: margin,
      child: CupertinoButton(
        color: color ?? Colors.redAccent,
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(title)],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
