// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'color_picker.dart';

class ColorSelectorWidget extends StatefulWidget {
  final Function(Color)? onColorSelected;

  ColorSelectorWidget({Key? key, this.onColorSelected}) : super(key: key);

  @override
  _ColorSelectorWidgetState createState() => _ColorSelectorWidgetState();
}

class _ColorSelectorWidgetState extends State<ColorSelectorWidget> {
  late Color _selectedColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Seleccionar color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: _selectedColor,
          onColorChanged: (newColor) {
            setState(() => _selectedColor = newColor);
          },
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Aceptar'),
          onPressed: () {
            if (widget.onColorSelected != null) {
              widget.onColorSelected!(_selectedColor);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Color getSelectedColor() {
    return _selectedColor;
  }

  @override
  void initState() {
    super.initState();
    _selectedColor = Colors.red;
  }
}
