import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/utils/utils.dart';

class CustomDialog extends StatelessWidget {
  String? message;
  DialogType? dialogType;
  dynamic acceptFuncion;

  CustomDialog(
      {super.key,
      this.message = 'Error desconocido',
      this.dialogType = DialogType.question,
      this.acceptFuncion});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return ZoomIn(
      child: AlertDialog(
        icon: switchIcon(context, dialogType!),
        title: Text(
          switchTitle(dialogType!),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: textTheme.titleLarge!.fontSize,
          ),
          textScaler: TextScaler.noScaling,
        ),
        content: Text(
          message!,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: textTheme.titleMedium!.fontSize,
              color: textTheme.titleMedium!.color),
          textScaler: TextScaler.noScaling,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actionButtons(context)),
        ],
      ),
    );
  }

  WidgetStatePropertyAll<Color?> switchButtonColor(
      ColorScheme colors, DialogType dialogType) {
    switch (dialogType) {
      case DialogType.alert:
        return WidgetStatePropertyAll(colors.error);
      case DialogType.info:
        return WidgetStatePropertyAll(colors.primary);
      case DialogType.warning:
        return WidgetStatePropertyAll(colors.primary);
      case DialogType.question:
        return WidgetStatePropertyAll(colors.primary);
      case DialogType.error:
        return WidgetStatePropertyAll(colors.error);
    }
  }

  Icon switchIcon(BuildContext context, DialogType dialogType) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final double height = MediaQuery.of(context).size.height;

    switch (dialogType) {
      case DialogType.alert:
        return Icon(
          Icons.error_rounded,
          color: colors.error,
          size: height * 0.05,
        );
      case DialogType.info:
        return Icon(
          Icons.info_rounded,
          color: colors.primary,
          size: height * 0.05,
        );
      case DialogType.warning:
        return Icon(
          Icons.warning_rounded,
          color: colors.primary,
          size: height * 0.05,
        );
      case DialogType.question:
        return Icon(
          Icons.help_rounded,
          color: colors.primary,
          size: height * 0.05,
        );
      case DialogType.error:
        return Icon(
          Icons.error_rounded,
          color: colors.error,
          size: height * 0.05,
        );
    }
  }

  List<Widget> actionButtons(BuildContext context) {
    final List<Widget> actions = [];
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    if (acceptFuncion == null) {
      actions.add(SizedBox(
        width: width * 0.3,
        child: ElevatedButton(
          onPressed: () {
            context.pop();
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(height * 0.02))),
          ),
          child: Text(
            'ACEPTAR',
            style: textTheme.labelMedium,
            textScaler: TextScaler.noScaling,
          ),
        ),
      ));
    } else {
      actions.add(SizedBox(
        width: width * 0.3,
        child: ElevatedButton(
          onPressed: () {
            context.pop();
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(height * 0.02))),
          ),
          child: Text(
            'CANCELAR',
            style: textTheme.labelMedium,
            textScaler: TextScaler.noScaling,
          ),
        ),
      ));
      actions.add(SizedBox(
          width: width * 0.3,
          child: ElevatedButton(
              onPressed: acceptFuncion,
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(height * 0.02))),
                  backgroundColor: switchButtonColor(colors, dialogType!)),
              child: Text(
                'ACEPTAR',
                style: TextStyle(
                    fontSize: textTheme.labelMedium!.fontSize,
                    color: Colors.white),
                textScaler: TextScaler.noScaling,
              ))));
    }
    return actions;
  }

  String switchTitle(DialogType dialogType) {
    switch (dialogType) {
      case DialogType.info:
        return 'Mensaje de información';
      case DialogType.alert:
        return 'Mensaje de alerta';
      case DialogType.warning:
        return 'Mensaje de advertencia';
      case DialogType.question:
        return 'Mensaje de confirmación';
      case DialogType.error:
        return 'Mensaje de error';
    }
  }
}
