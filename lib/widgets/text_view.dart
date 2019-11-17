import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

TextStyle _textStyle = TextStyle(fontSize: 16);

class TextView extends StatelessWidget {
  TextView({
    this.label = '请输入',
    this.maxLines = 1,
    this.enabled = true,
    this.warn,
    this.hintText = '',
    this.autofocus = false,
    this.padding,
  });

  final String label;

  final int maxLines;

  final bool enabled;

  final String warn;

  final String hintText;

  final bool autofocus;

  final FocusNode focus = FocusNode();

  final TextEditingController controller = TextEditingController();

  final EdgeInsetsGeometry padding;

  get text {
    return isNull(controller.text) ? null : controller.text;
  }

  set text(val) {
    controller.text = val;
  }

  /// 文本框边框
  boxBorder(double width, Color color) {
    InputBorder border =
        OutlineInputBorder(borderSide: BorderSide(width: width, color: color));
    return border;
  }

  @override
  Widget build(context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label:",
            style: _textStyle,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
            child: TextFormField(
              // autovalidate: true,
              focusNode: focus,
              autofocus: autofocus,
              controller: controller,
              decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: EdgeInsets.all(16),
                  border: boxBorder(0.5, Colors.black26),
                  focusedBorder: boxBorder(0.5, Colors.orange)),
              style: _textStyle,
              maxLines: maxLines,
              enabled: enabled,
              validator: (val) {
                if (val.isEmpty) {
                  return warn;
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }
}
