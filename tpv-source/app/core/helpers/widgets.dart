import 'package:flutter/material.dart';

Widget? defaultSplash;

GlobalKey<NavigatorState>? _myAppKey;

GlobalKey<NavigatorState> genAppKey() {
  return _myAppKey = _myAppKey ?? GlobalKey<NavigatorState>();
}
