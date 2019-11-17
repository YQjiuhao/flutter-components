import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:utilities/utilities.dart';

class ListCell extends StatelessWidget {
  ListCell({
    @required this.title,
    this.icon,
    this.subTitle,
    this.trailing,
    this.onTap,
    this.padding,
    this.divierColor = const Color(0xFFEAEAEA),
    this.backgroundColor = const Color(0xFFFFFFFF),
  });

  final Widget icon;

  final Widget title;

  final Widget trailing;

  final Widget subTitle;

  final VoidCallback onTap;

  final EdgeInsetsGeometry padding;

  final Color divierColor;

  final Color backgroundColor;

  Widget buildCell(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
          color: backgroundColor ?? Color(0xFFFFFFFF),
          border: Border(
              bottom: Divider.createBorderSide(context, color: divierColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Offstage(
                offstage: isNull(icon),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: icon,
                ),
              ),
              Flex(
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: Axis.vertical,
                children: <Widget>[
                  title,
                  Offstage(
                    offstage: isNull(subTitle),
                    child: subTitle,
                  ),
                ],
              )
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Offstage(
                offstage: isNull(trailing),
                child: trailing,
              ),
              Offstage(
                offstage: isNull(onTap),
                child: Icon(
                  IconFonts.arrow_right,
                  color: Color(0xFF909090),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      enableFeedback: false,
      child: buildCell(context),
    );
  }
}
