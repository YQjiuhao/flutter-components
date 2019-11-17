import 'package:flutter/cupertino.dart';

class ListCellModel {
  ListCellModel({
    this.title,
    this.icon,
    this.routePath,
    this.subStyle,
    this.subTitle,
    this.widget,
    this.hidden = true,
    this.args,
  });

  String title;

  String subTitle;

  TextStyle subStyle;

  Widget trailing;

  String routePath;

  Icon icon;

  Widget widget;

  bool hidden;

  /// 界面传值参数
  var args;
}
