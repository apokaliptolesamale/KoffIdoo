/*
 * QR.Flutter
 * Copyright (c) 2019 the QR.Flutter authors.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/widgets.dart';

import 'types.dart';

///
class PaintCache {
  final List<Paint> _pixelPaints = <Paint>[];
  final Map<String, Paint> _keyedPaints = <String, Paint>{};

  /// Save a [Paint] for the provided element and position into the cache.
  void cache(Paint paint, QrCodeElement element,
      {FinderPatternPosition? position}) {
    if (element == QrCodeElement.codePixel) {
      _pixelPaints.add(paint);
    } else {
      _keyedPaints[_cacheKey(element, position: position)] = paint;
    }
  }

  /// Retrieve the first [Paint] object from the paint cache for the provided
  /// element and position.
  Paint? firstPaint(QrCodeElement element, {FinderPatternPosition? position}) {
    if (element == QrCodeElement.codePixel) {
      return _pixelPaints.first;
    } else {
      return _keyedPaints[_cacheKey(element, position: position)];
    }
  }

  /// Retrieve all [Paint] objects from the paint cache for the provided
  /// element and position. Note: Finder pattern elements can only have a max
  /// one [Paint] object per position. As such they will always return a [List]
  /// with a fixed size of `1`.
  List<Paint?> paints(QrCodeElement element,
      {FinderPatternPosition? position}) {
    if (element == QrCodeElement.codePixel) {
      return _pixelPaints;
    } else {
      return <Paint?>[_keyedPaints[_cacheKey(element, position: position)]];
    }
  }

  String _cacheKey(QrCodeElement element, {FinderPatternPosition? position}) {
    final posKey = position != null ? position.toString() : 'any';
    return '${element.toString()}:$posKey';
  }
}
