import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

const double _kButtonWidth = 44.0;
const double _kCounterWidth = 85;

const Color _kDisableColor = Color(0xFFABABAB);
const Color _kActiveColor = Color(0xFF707070);

class InputNumber extends StatefulWidget {
  InputNumber({
    this.initValue = 0,
    this.maxValue = 100, // 默认值百万
    this.minValue = 0,
    this.width = _kCounterWidth,
    double height,
    this.onChanged,
  }) : this.height = height ?? Adapt.px(44);

  final TextEditingController controller = TextEditingController();

  final int initValue;

  final ValueChanged<int> onChanged;

  final int maxValue;

  final int minValue;

  final double width;

  final double height;

  @override
  _InputNumberState createState() => _InputNumberState();
}

class _InputNumberState extends State<InputNumber> {
  int _count = 0;
  bool _stopAdd = false;
  bool _stopSub = false;

  var _focusNode = FocusNode();

  Widget buildInput() {
    var border = OutlineInputBorder(
        borderSide: BorderSide(
      style: BorderStyle.solid,
      color: Colors.transparent,
    ));
    return SizedBox(
      // -2：divider width* 2
      width: (widget.width ?? _kCounterWidth) - 2 * Adapt.px(_kButtonWidth) - 2,
      child: TextField(
        focusNode: _focusNode,
        textInputAction: TextInputAction.done,
        onEditingComplete: () {
         
          _focusNode.unfocus();
        },
        onChanged: (text) {
          String _value = RegExp('^\\d*').stringMatch(text);
          _count = int.parse(_value);
          if (isNull(_value) || _count < widget.minValue) {
            _value = "${widget.minValue ?? "0"}";
          }
          if (_count > widget.maxValue) {
            _value = "${widget.maxValue ?? "100"}";
          }
          widget.controller.text = _value;
          if (widget.onChanged != null) {
            widget.onChanged(_count);
          }
        },
        keyboardAppearance: Brightness.light,
        dragStartBehavior: DragStartBehavior.down,
        keyboardType: TextInputType.numberWithOptions(signed: true),
        controller: widget.controller,
        textAlign: TextAlign.center,
        cursorColor: Color(0xFFABABAB),
        style: TextStyle(color: Color(0xFF505050), fontSize: Adapt.px(25)),
        // padding: const EdgeInsets.all(0),
        // decoration: BoxDecoration(border: Border.all(style: BorderStyle.none)),
        decoration: InputDecoration(
          focusColor: Color(0xFF505050),
          focusedErrorBorder: border,
          errorBorder: border,
          focusedBorder: border,
          disabledBorder: border,
          enabledBorder: border,
          contentPadding: const EdgeInsets.all(0),
        ),
      ),
    );
  }

  Widget buildButton({IconData icon, VoidCallback onPressed}) {
    return SizedBox(
      width: Adapt.px(_kButtonWidth),
      child: FlatButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(0),
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 10,
            color: (onPressed != null) ? _kActiveColor : _kDisableColor,
          ),
        ),
      ),
    );
  }

  bool checkIfNeetStop(int value) {
    if (value > widget.maxValue) {
      setState(() => _stopAdd = true);
      return true;
    } else if (value < widget.minValue) {
      setState(() => _stopSub = true);
      return true;
    }
    return false;
  }

  void onChange(bool isAdd) {
    if (isAdd && checkIfNeetStop(_count + 1) ||
        !isAdd && checkIfNeetStop(_count - 1)) return;

    _count = isAdd ? (_count + 1) : (_count - 1);
    widget.controller.text = "$_count";
    if (widget.onChanged != null) widget.onChanged(_count);
    // 监听值改变
    if (!(_stopSub && _stopAdd)) {
      setState(() {
        _stopSub = !(_count > widget.minValue);
        _stopAdd = !(_count < widget.maxValue);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _count = max<int>(widget.initValue, widget.minValue) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.text = "$_count";
    return Container(
      alignment: Alignment.center,
      width: widget.width ?? _kCounterWidth,
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Color(0xFFD0D0D0)),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: <Widget>[
          buildButton(
              icon: IconFonts.sub,
              onPressed: _stopSub ? null : () => onChange(false)),
          VerticalDivider(width: 0.5),
          buildInput(),
          VerticalDivider(width: 0.5),
          buildButton(
              icon: IconFonts.add,
              onPressed: _stopAdd ? null : () => onChange(true)),
        ],
      ),
    );
  }
}
