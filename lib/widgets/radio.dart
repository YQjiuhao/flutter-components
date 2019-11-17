import 'package:flutter/material.dart';


class Radio<T> extends StatefulWidget {
  Radio({this.onChange, this.value});

  final ValueChanged<T> onChange;

  final T value;

  @override
  RadioState<T> createState() => RadioState<T>();
}

class RadioState<T> extends State<Radio<T>> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        check ? Icons.check_box : Icons.check_box_outline_blank,
        color: check ? Colors.red : Colors.black45,
      ),
      onTap: () {
        if (widget.onChange != null) {
          widget.onChange(widget.value);
          setState(() {
            check = !check;
          });
        }
      },
    );
  }
}
