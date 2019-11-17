import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

typedef CustomRender = Widget Function(String tag, List<Widget> children);

class HTMLContainer extends StatefulWidget {
  HTMLContainer({
    @required this.data,
    this.onLinkTap,
    this.onImageTap,
    this.backgroundColor,
    this.padding,
    this.style,
    this.h1Style,
    this.customRender,
  });
  final String data;

  final ValueChanged<String> onLinkTap;

  final ValueChanged<String> onImageTap;

  final Color backgroundColor;

  final EdgeInsetsGeometry padding;

  final TextStyle style;

  final TextStyle h1Style;

  final CustomRender customRender;

  @override
  _HTMLContainerState createState() => _HTMLContainerState();
}

class _HTMLContainerState extends State<HTMLContainer> {
  @override
  Widget build(BuildContext context) {
    return Html(
      backgroundColor: widget.backgroundColor ?? Colors.white,
      data: widget.data, //Optional parameters:
      padding: widget.padding,
      linkStyle: const TextStyle(
        color: Colors.blue,
        decorationColor: Colors.blue,
        decoration: TextDecoration.none,
      ),
      onLinkTap: (url) {
        if (widget.onLinkTap != null) widget.onLinkTap(url);
      },
      onImageTap: (src) {
        if (widget.onImageTap != null) widget.onImageTap(src);
      },
      //Must have useRichText set to false for this to work
      customRender: (node, children) {
        if (widget.customRender != null && (node is dom.Element)) {
          return widget.customRender(node.localName, children);
        }
        return null;
      },
      // customRender: (node, children) {
      //   if (node is dom.Element) {
      //     switch (node.localName) {
      //       case "custom_tag":
      //         return Column(children: children);
      //     }
      //   }
      //   return null;
      // },
      customTextAlign: (dom.Node node) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "p":
              return TextAlign.justify;
          }
        }
        return null;
      },
      customTextStyle: (dom.Node node, TextStyle baseStyle) {
        if (node is dom.Element) {
          // print(node.localName);
          switch (node.localName) {
            case "p":
            case 'body':
              return baseStyle.merge(widget.style ??
                  TextStyle(height: 1.2, fontSize: 15, letterSpacing: 0.6));
            case "h1":
              return baseStyle.merge(
                  widget.h1Style ?? TextStyle(height: 1.2, fontSize: 18));
          }
        }
        return baseStyle;
      },
    );
  }
}
