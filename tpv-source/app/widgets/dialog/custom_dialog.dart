// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../app/core/services/logger_service.dart';

class Constants {
  static double avatarRadius = 60;
  static double padding = 100;
}

class CustomDialogBox extends StatefulWidget {
  final String title;
  String? description;
  Image? logo;
  final List<Widget> actions;
  BuildContext context;
  BuildContext? _contextToClose;
  Widget? content, descriptionWidget;
  EdgeInsetsGeometry? padding;

  _CustomDialogBoxState? _state;

  CustomDialogBox({
    Key? key,
    required this.context,
    required this.title,
    this.description,
    this.descriptionWidget,
    required this.actions,
    this.logo,
    this.content,
    this.padding,
  }) : super(key: key) {
    //_state = getState;
  }

  _CustomDialogBoxState get getState => _state ?? createState();

  close() {
    if (_contextToClose != null) {
      Navigator.pop(_contextToClose!);
    }
  }

  @override
  _CustomDialogBoxState createState() => _state = _CustomDialogBoxState();

  setContent(Widget? newContent) {
    if (getState.mounted) {
      getState.setContent(newContent);
    }
  }

  show() {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        log("Construyendo diálogo...");
        _contextToClose = ctx;
        return this;
      },
    ).then((value) {
      if (value != null) {
        log(value);
      }
    });
    return this;
  }

  static showSimpleDialog({
    Key? key,
    required BuildContext context,
    required String title,
    required String description,
    required List<Widget> actions,
    Image? logo,
    Widget? content,
    EdgeInsetsGeometry? padding,
  }) {
    Widget? contenido = content;
    return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return CustomDialogBox(
          title: title,
          description: description,
          actions: actions,
          logo: logo,
          content: contenido,
          context: context,
          padding: padding,
        );
      },
    );
  }
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  Widget? content;
  late BuildContext initContext;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      insetPadding: EdgeInsets.all(10),
      child: contentBox(context),
    );
  }

  contentBox(context) {
    final descriptionWidget = widget
        .descriptionWidget; /*??
        Text(
          widget.description ?? "Sin descripción",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        );*/
    return Stack(
      children: <Widget>[
        Container(
          padding: widget.padding ??
              EdgeInsets.only(
                left: Constants.padding,
                top: Constants.avatarRadius + Constants.padding,
                right: Constants.padding,
                bottom: Constants.padding,
              ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ]),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              if (widget.title.isNotEmpty) ...[
                Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
              if (descriptionWidget != null) ...[
                descriptionWidget,
                SizedBox(
                  height: 10,
                ),
              ],
              if (content != null) ...[
                content!,
              ],
              if (widget.actions.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.actions,
                ),
            ],
          ),
        ),
        if (widget.logo != null)
          Positioned(
            left: Constants.padding,
            right: Constants.padding,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Constants.avatarRadius,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: widget.logo,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initContext = context;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    content = widget.content;
  }

  setContent(Widget? newContent) {
    setState(() {
      content = newContent;
    });
  }
}
