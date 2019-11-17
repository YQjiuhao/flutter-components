import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:utilities/utilities.dart';
import 'text_view.dart';

class TextViewPage extends StatefulWidget {
  TextViewPage({
    Key key,
    this.finished,
    this.content,
    this.label,
    String title,
  })  : this.title = title ?? '填写信息',
        super(key: key);

  final String title;

  final String label;

  final String content;

  /// 编辑完成回调
  final ValueChanged<String> finished;

  @override
  _TextViewPageState createState() => _TextViewPageState();
}

class _TextViewPageState extends State<TextViewPage> {
  TextView inputView;

  final Toast toast = Toast();

  button() {
    return Container(
      height: 44,
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("提交")],
        ),
        onPressed: () {
          if (isNull(inputView.text)) {
            toast.show(context, text: '内容不能为空');
            return;
          }
          if (widget.finished != null) widget.finished(inputView.text);
          Navigator.pop(context, inputView.text);
        },
        color: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    inputView = TextView(
      maxLines: 5,
      hintText: '请填写内容',
      label: widget.label,
    );
    inputView.text = widget.content;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[inputView, button()],
        ),
      ),
    );
  }

  @override
  void dispose() {
    toast.dismiss();
    super.dispose();
  }
}
