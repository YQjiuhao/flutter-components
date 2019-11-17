import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

class PopoverView extends Dialog {
  PopoverView({
    this.width = 150.0,
    this.backgroundColor = const Color(0xDFFFFFFF),
    this.tiles,
  });

  final Color backgroundColor;

  final double width;

  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(top: kToolbarHeight - Adapt.padTopH() / 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 14,
                    child: ClipRect(
                      clipper: TriangleClipRect(),
                      child: Icon(
                        IconFonts.triangle,
                        color: backgroundColor,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, right: 2),
                    width: width - 4,
                    child: Column(children: tiles),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TriangleClipRect extends CustomClipper<Rect> {
  @override
  getClip(Size size) {
    return new Rect.fromLTRB(0, 0, size.width, size.height - 10.0);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
