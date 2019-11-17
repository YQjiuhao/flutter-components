import 'package:flutter/cupertino.dart';

typedef TextFeildTabCallback<T> = void Function(T);

enum TextFieldModelType {
  /// 常用
  input,

  /// 点击输入
  touch,

  /// 多行输入
  multiInput,

  /// 总得有点其他的View在中间隔断
  slots1,
  slots2,
  slots3,
  // 不够再加
}

class TextFieldModel {
  TextFieldModel(
      {@required this.title,
      @required this.key,
      this.child,
      this.trailing,
      this.hint,
      this.func,
      this.line = 1,
      this.must = false,
      this.type = TextFieldModelType.input,
      this.unit,
      this.value,
      this.text,
      this.enable = true,
      this.isDouble = false});

  /// 标题
  String title;

  /// 键值
  String key;

  /// 值
  var value;

  /// 是否必填
  bool must;

  /// 单位
  String unit;

  /// 行数
  int line;

  String text;

  /// 提示
  String hint;

  Widget child;

  Widget trailing;

  /// 点击回调
  TextFeildTabCallback func;

  /// 文本类型
  TextFieldModelType type;

  /// 是否可编辑
  bool enable;

  /// 是否为数字
  bool isDouble;
}
