import 'package:flutter/widgets.dart';

class IconTurns extends StatefulWidget {
  const IconTurns({Key key, this.turns = .0, this.speed = 200, this.child})
      : super(key: key);

  final double turns;

  final int speed;

  final Widget child;

  @override
  _TurnBoxsState createState() => new _TurnBoxsState();
}

class _TurnBoxsState extends State<IconTurns> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(IconTurns oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed ?? 200),
        curve: Curves.easeOut,
      );
    }
  }
}
