// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';

import '../../../app/widgets/promise/custom_future_builder.dart';
import '../../../app/widgets/utils/functions.dart';

class InformationMessage extends StatelessWidget {
  final Widget title;
  final Widget content;
  final String acceptButtonText;
  final String cancelButtonText;
  final VoidCallback onPressed;
  const InformationMessage({
    Key? key,
    required this.title,
    required this.content,
    this.acceptButtonText = "Aceptar",
    this.cancelButtonText = "Cancelar",
    this.onPressed = emptyFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dialog = AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(cancelButtonText),
        ),
        TextButton(
          onPressed: () async {
            onPressed();
            Navigator.pop(context);
          },
          child: Text(acceptButtonText),
        )
      ],
    );
    return CustomFutureBuilder(
      context: context,
      future: showDialog(
        context: context,
        builder: (_) => dialog,
      ),
      builder: getBuilder(dialog),
    );
  }

  AsyncWidgetBuilder<dynamic> getBuilder(Widget widget) {
    var builder = (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      return widget;
    };
    return builder;
  }
}
