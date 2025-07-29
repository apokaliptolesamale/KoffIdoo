import 'package:flutter/material.dart';

abstract class UiUtil {
  /// get the screen height
  static double getMediaQueryHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  /// get the screen width
  static double getMediaQueryWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  /// show a snackbar
  static SnackBar getSnackBar(message) {
    return SnackBar(content: Text(message));
  }
}
