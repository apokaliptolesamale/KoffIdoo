// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'package:flutter/services.dart' show RawKeyEvent;

/// A widget that calls a callback whenever the user presses or releases a key
/// on a keyboard.
///
/// A [CustomRawKeyBoardListener] is useful for listening to raw key events and
/// hardware buttons that are represented as keys. Typically used by games and
/// other apps that use keyboards for purposes other than text entry.
///
/// For text entry, consider using a [EditableText], which integrates with
/// on-screen keyboards and input method editors (IMEs).
///
/// The [CustomRawKeyBoardListener] is different from [KeyboardListener] in that
/// [CustomRawKeyBoardListener] uses the legacy [RawKeyboard] API. Use
/// [KeyboardListener] if possible.
///
/// See also:
///
///  * [EditableText], which should be used instead of this widget for text
///    entry.
///  * [KeyboardListener], a similar widget based on the newer
///    [HardwareKeyboard] API.
class CustomRawKeyBoardListener extends StatefulWidget {
  /// Creates a widget that receives raw keyboard events.
  ///
  /// For text entry, consider using a [EditableText], which integrates with
  /// on-screen keyboards and input method editors (IMEs).
  ///
  /// The [focusNode] and [child] arguments are required and must not be null.
  ///
  /// The [autofocus] argument must not be null.
  const CustomRawKeyBoardListener({
    Key? key,
    required this.focusNode,
    this.autofocus = false,
    this.includeSemantics = true,
    this.onKey,
    required this.child,
  }) : /*assert(focusNode != null),
        assert(autofocus != null),
        assert(includeSemantics != null),
        assert(child != null),*/
        super(key: key);

  /// Controls whether this widget has keyboard focus.
  final FocusNode focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.Focus.includeSemantics}
  final bool includeSemantics;

  /// Called whenever this widget receives a raw keyboard event.
  final ValueChanged<RawKeyEvent>? onKey;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  State<CustomRawKeyBoardListener> createState() =>
      _CustomRawKeyBoardListenerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode));
  }
}

class _CustomRawKeyBoardListenerState extends State<CustomRawKeyBoardListener> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(CustomRawKeyBoardListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode.removeListener(_handleFocusChanged);
      widget.focusNode.addListener(_handleFocusChanged);
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChanged);
    _detachKeyboardIfAttached();
    super.dispose();
  }

  void _handleFocusChanged() {
    if (widget.focusNode.hasFocus) {
      _attachKeyboardIfDetached();
    } else {
      _detachKeyboardIfAttached();
    }
  }

  bool _listening = false;

  void _attachKeyboardIfDetached() {
    if (_listening) return;
    RawKeyboard.instance.addListener(_handleRawKeyEvent);
    _listening = true;
  }

  void _detachKeyboardIfAttached() {
    if (!_listening) return;
    RawKeyboard.instance.removeListener(_handleRawKeyEvent);
    _listening = false;
  }

  void _handleRawKeyEvent(RawKeyEvent event) {
    widget.onKey?.call(event);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      includeSemantics: widget.includeSemantics,
      child: widget.child,
    );
  }
}
