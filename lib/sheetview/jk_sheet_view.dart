import 'package:flutter/material.dart';
import 'jk_modal_sheet_view.dart';
import 'dart:math';

/// 这个高是固定的
///
/// 根据ListTile(height)+Divider(height)，不能修改
const double _kItemHeight = 56.5;

class JKSheetTile<T extends Object> {
  JKSheetTile({@required String title, T value})
      : assert(title != null),
        this.title = title,
        this.value = value;

  /// 显示项标题
  String title;

  /// 对应的值
  ///
  /// 如果不给定值，则默认value为title
  T value;
}

class _JKSheetView<T extends Object> extends StatelessWidget {
  _JKSheetView({this.onClick, this.tiles});
  final List<JKSheetTile> tiles;

  final ValueChanged<T> onClick;

  Widget item({JKSheetTile<T> tile, VoidCallback onTap}) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(tile.title)],
            ),
            onTap: onTap,
          ),
          Divider(height: 0.5)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height / 2.0;
    double bottomHeight = _kItemHeight + 16;
    double actualHeight = _kItemHeight * tiles.length + bottomHeight;
    double height = min(maxHeight, actualHeight);
    double tableHeight = height - bottomHeight;

    return SizedBox(
        height: height,
        // color: Color(0xFFFFEBEE),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: tableHeight,
              child: ListView.builder(
                itemCount: tiles.length,
                itemBuilder: (ctx, index) {
                  JKSheetTile tile = tiles[index];
                  return item(
                      tile: tile,
                      onTap: () {
                        Navigator.pop(context);
                        onClick(tile.value ?? index);
                      });
                },
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                item(
                    tile: JKSheetTile(title: '取消'),
                    onTap: () {
                      Navigator.pop(context);
                    })
              ],
            )
          ],
        ));
  }
}

showJKSheetView<T extends Object>({
  @required BuildContext context,
  @required List<JKSheetTile> tiles,
  ValueChanged<T> onClick,
}) {
  assert(context != null);
  assert(tiles != null);

  showModalSheetView(
      context: context,
      builder: (ctx) {
        return _JKSheetView<T>(
          tiles: tiles,
          onClick: onClick,
        );
      });
}
