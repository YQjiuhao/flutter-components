import 'package:flutter/material.dart';
import 'dart:async';

class CupertinoSwipeBackObserver extends NavigatorObserver {
  static Completer promise;
  @override
  void didStartUserGesture(Route route, Route previousRoute) {
    promise = Completer();
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    promise.complete();
  }
}
