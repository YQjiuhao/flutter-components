import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

const double _kDefaultPrefixWidth = 90.0;
const double _kDefaultSuffixWidth = 25.0;
const double _kDetaultFieldHeight = 30.0;
const double _kFontSize = 16.0;

class TextFieldItem<T> extends StatelessWidget {
  TextFieldItem({
    Key key,
    String prefixText,
    this.suffixText,
    this.hint,
    this.child,
    this.padding = const EdgeInsets.all(10),
    // this.prefix,
    // this.suffix,
    this.style = const TextStyle(fontSize: 14, color: Color(0xFF404040)),
    this.prefixStyle = const TextStyle(fontSize: 14, color: Color(0xFF404040)),
    this.suffixStyle = const TextStyle(fontSize: 14, color: Color(0xFF404040)),
    this.prefixWidth = _kDefaultPrefixWidth,
    this.suffixWidth = _kDefaultSuffixWidth,
    this.onTap,
    bool notNull,
    bool isDouble,
    bool enable,
    int maxLines = 1,
    TextInputType keyboardType,
  })  : assert(prefixText != null),
        this.prefixText = prefixText,
        this.enable = enable ?? true,
        this.notNull = notNull ?? false,
        this.isDouble = isDouble ?? false,
        this.keyboardType = keyboardType,
        this.maxLines = maxLines ?? 1,
        super(key: key);

  /// 是否必填
  final bool notNull;

  /// 是否可以编辑
  final bool enable;

  /// 值是否为 double 类型
  final bool isDouble;

  /// 行数
  final int maxLines;

  final String hint;

  /// 左端文字
  final String prefixText;

  /// 右端文字
  final String suffixText;

  /// 输入键盘类型
  final TextInputType keyboardType;

  // /// 左边控件
  // final Widget prefix;

  // /// 右边控件
  // final Widget suffix;

  /// 控件文本
  final TextStyle style;

  final TextStyle prefixStyle;

  final TextStyle suffixStyle;

  final EdgeInsetsGeometry padding;

  final double prefixWidth;

  final double suffixWidth;

  final VoidCallback onTap;

  final Widget child;

  /// 文本编辑控制器
  final TextEditingController controller = TextEditingController();

  /// 当onTap！=null时有效
  // final T selectedValue;

  final Map<String, T> _valueMap = {};

  T get value => _valueMap['value'];

  set value(T val) => _valueMap['value'] = val;

  String get text {
    return isNull(controller.text) ? null : controller.text;
  }

  /// 光标
  final FocusNode focusNode = FocusNode();

  Widget buildTextField() {
    var border = OutlineInputBorder(
        borderSide: BorderSide(
      style: BorderStyle.solid,
      color: Colors.transparent,
    ));
    return SizedBox(
      height: maxLines == 1 ? _kDetaultFieldHeight : null,
      width: Adapt.screenW() -
          (isNull(prefixText) ? 0 : prefixWidth) -
          (isNull(suffixText) && isNull(onTap) ? 0 : suffixWidth) -
          (padding?.horizontal ?? 0),
      child: TextFormField(
        enabled: enable ? isNull(onTap) : enable,
        maxLines: maxLines,
        validator: notNull
            ? (value) {
                if (value.isEmpty) return '(必填)';
                if (isDouble && value.isNotEmpty) {
                  // 校验值是否为数字
                  bool flag = RegExp('^\\d*(\\.\\d)?\$').hasMatch(value);
                  if (!flag) {
                    return '(值应为整数或小数)';
                  }
                }
                return null;
              }
            : null,
        focusNode: focusNode,
        controller: controller,
        keyboardType: keyboardType,
        textAlign: TextAlign.start,
        style: style ?? TextStyle(fontSize: _kFontSize),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Color(0xFFFF0000)),
          focusedErrorBorder: border,
          errorBorder: border,
          focusedBorder: border,
          disabledBorder: border,
          enabledBorder: border,
          // border: border,
          contentPadding: const EdgeInsets.only(top: 0,bottom: 0),
          hintText: hint ?? '请输入',
        ),
        // decoration: InputDecoration.collapsed(hintText: hint ?? '请输入'),
      ),
    );
  }

  Widget buildPrefix() {
    return SizedBox(
      width: prefixWidth,
      child: RichText(
        text: TextSpan(
          style: prefixStyle?.merge(TextStyle(color: Colors.red)) ??
              TextStyle(color: Colors.red),
          text: notNull ? '*' : '',
          children: [
            TextSpan(
              text: prefixText,
              style: prefixStyle?.merge(TextStyle(color: Color(0xFF404040))) ??
                  TextStyle(color: Color(0xFF404040), fontSize: _kFontSize),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSuffix() {
    return SizedBox(
      width: suffixWidth,
      // child: Icon(UIIcons.arrow_right),
      child: isNull(onTap)
          ? Text(
              suffixText ?? '',
              style: suffixStyle,
            )
          : (enable
              ? Icon(
                  IconFonts.arrow_right,
                  color: Color(0xFF707070),
                )
              : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? onTap : null,
      enableFeedback: false,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border(bottom: Divider.createBorderSide(context)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: maxLines > 1
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: <Widget>[
                Offstage(
                  offstage: isNull(prefixText),
                  child: buildPrefix(),
                ),
                buildTextField(),
                Offstage(
                  offstage: isNull(suffixText) && isNull(onTap),
                  child: buildSuffix(),
                ),
              ],
            ),
            Offstage(
              offstage: isNull(child),
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
