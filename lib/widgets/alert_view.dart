import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AlertView {
  AlertView({
    this.title,
    this.content,
    this.actions,
    this.cancel = '取消',
  });

  final String title;

  final String content;

  final String cancel;

  final List<String> actions;

  androidDialod(List<Widget> buttons) {
    //
    return AlertDialog(
      title: Text(title ?? ''),
      content: Text(content ?? ''),
      actions: buttons,
    );
  }

  iOSDiaload(List<Widget> buttons) {
    return CupertinoAlertDialog(
      title: Text(title ?? ''),
      content: Text(content ?? ''),
      actions: buttons,
    );
  }

  dismiss(context) {
    Navigator.pop(context);
  }

  show(context, {ValueChanged<int> onClick}) {
    // init button
    List<String> buttonTitles = [this.cancel];

    if (this.actions != null && this.actions.isNotEmpty) {
      buttonTitles.insertAll(0, actions);
    }
    List<Widget> buttons = List<Widget>.generate(buttonTitles.length, (index) {
      return CupertinoButton(
        child: Text(buttonTitles[index]),
        onPressed: () {
          // if (index == (buttonTitles.length - 1)) {
          //   Navigator.pop(context);
          // }
          Navigator.pop(context);
          if (onClick != null) onClick(index);
        },
      );
    });

    // 显示弹窗
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          switch (defaultTargetPlatform) {
            case TargetPlatform.iOS:
              return iOSDiaload(buttons);
              break;
            default:
              return androidDialod(buttons);
          }
        });
  }
}
