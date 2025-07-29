// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';

import '/app/core/services/logger_service.dart';
import 'custom_widget.dart';

class SwithcWidget extends StatefulWidget implements CustomWidgetInterface {
  bool _toggle = false;
  CustomWidgetInterface primary, secundary;
  @override
  CustomWidgetInterface? container;
  _SwithcWidgetState? _state;
  SwithcWidget({
    Key? key,
    required this.primary,
    required this.secundary,
    bool isToggled = false,
  }) {
    _toggle = isToggled;
    primary.setContainer(this);
    secundary.setContainer(this);
  }
  _SwithcWidgetState get getState => _state ?? createState();

  @override
  _SwithcWidgetState createState() => _state = _SwithcWidgetState();

  @override
  CustomWidgetInterface setContainer(CustomWidgetInterface container) {
    this.container = container;
    return this;
  }

  toggle() {
    if (getState.mounted) {
      getState.toggle();
    }
  }
}

class _SwithcWidgetState extends State<SwithcWidget> {
  bool _toggle = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          log("message");
        },
        child: MouseRegion(
          child: !_toggle ? widget.primary : widget.secundary,
          onHover: (event) {},
          onEnter: (event) {},
          onExit: (event) {},
          cursor: SystemMouseCursors.click,
          opaque: false,
          hitTestBehavior: HitTestBehavior.translucent,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _toggle = widget._toggle;
  }

  toggle() {
    setState(() {
      _toggle = !_toggle;
    });
  }
}
