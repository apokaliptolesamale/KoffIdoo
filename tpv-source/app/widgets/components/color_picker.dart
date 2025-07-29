// ignore_for_file: unnecessary_this, prefer_initializing_formals

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final Color pickerColor;

  final ValueChanged<Color> onColorChanged;
  final bool enableAlpha;
  final double colorPickerWidth;
  final double pickerAreaHeightPercent;
  final bool displayThumbColor;
  final bool showLabel;
  final TextStyle? labelTextStyle;
  final BorderRadiusGeometry pickerAreaBorderRadius;
  final PaletteType paletteType;
  const ColorPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.enableAlpha = true,
    this.colorPickerWidth = 300.0,
    this.pickerAreaHeightPercent = 1.0,
    this.displayThumbColor = false,
    this.showLabel = true,
    this.labelTextStyle,
    this.pickerAreaBorderRadius = const BorderRadius.all(Radius.zero),
    this.paletteType = PaletteType.hsv,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColorPickerState();
}

//
class HslPickerPainter extends CustomPainter {
  final double hue;
  final double saturation;
  final double value;
  final double alpha;

  HslPickerPainter({
    required this.hue,
    required this.saturation,
    required this.value,
    double alpha = 0.0,
  })  : assert(alpha >= 0 && alpha <= 1),
        this.alpha = alpha;

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final double centerX = width * saturation;
    final double centerY = height * (1 - value);
    final double radius = min(width, height) / 2;

    for (double y = 0; y < height; y++) {
      for (double x = 0; x < width; x++) {
        double dx = x - centerX;
        double dy = y - centerY;
        double distance = sqrt(dx * dx + dy * dy);
        if (distance <= radius) {
          double angle = atan2(dy, dx);
          if (angle < 0) {
            angle += 2 * pi;
          }
          double percent = angle / (2 * pi);
          Color color = HSLColor.fromAHSL(alpha, hue, percent, 0.5).toColor();
          canvas.drawPoints(
              PointMode.points, [Offset(x, y)], Paint()..color = color);
        }
      }
    }
  }

  @override
  bool shouldRepaint(HslPickerPainter oldDelegate) {
    return oldDelegate.hue != hue ||
        oldDelegate.saturation != saturation ||
        oldDelegate.value != value ||
        oldDelegate.alpha != alpha;
  }
}

//
class HsvPickerPainter extends CustomPainter {
  final double hue;
  final double saturation;
  final double value;
  final double alpha;

  HsvPickerPainter({
    required this.hue,
    required this.saturation,
    required this.value,
    double alpha = 0.0,
  })  : assert(alpha >= 0 && alpha <= 1),
        this.alpha = alpha;

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final double centerX = width * saturation;
    final double centerY = height * (1 - value);
    final double radius = min(width, height) / 2;

    for (double y = 0; y < height; y++) {
      for (double x = 0; x < width; x++) {
        double dx = x - centerX;
        double dy = y - centerY;
        double distance = sqrt(dx * dx + dy * dy);
        if (distance <= radius) {
          double angle = atan2(dy, dx);
          if (angle < 0) {
            angle += 2 * pi;
          }
          double percent = distance / radius;
          Color color = HSVColor.fromAHSV(alpha, hue, percent, 1).toColor();
          canvas.drawPoints(
              PointMode.points, [Offset(x, y)], Paint()..color = color);
        }
      }
    }
  }

  @override
  bool shouldRepaint(HsvPickerPainter oldDelegate) {
    return oldDelegate.hue != hue ||
        oldDelegate.saturation != saturation ||
        oldDelegate.value != value ||
        oldDelegate.alpha != alpha;
  }
}

enum PaletteType {
  rgb,
  hsl,
  hsv,
}

class _ColorPickerState extends State<ColorPicker> {
  Color _color = Colors.white;
  double _alpha = 1.0;
  double _hue = 0.0;
  double _saturation = 0.0;
  double _value = 1.0;
  final bool _hsv = true;
  HSVColor hsvColor = HSVColor.fromColor(Colors.white);

  double _red = 0.0;
  double _green = 0.0;
  double _blue = 0.0;

  late double _pickerWidth;
  late double _pickerHeight;
  final GlobalKey _pickerKey = GlobalKey();

  late DragUpdateDetails dragUpdateDetails;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: widget.showLabel ? 460.0 : 430.0,
        width: widget.colorPickerWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildPickerArea(),
            widget.enableAlpha ? _buildOpacitySlider() : Container(),
            widget.showLabel ? _buildColorLabel() : Container(),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            widget.onColorChanged(_color);
            Navigator.of(context).pop();
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }

  Offset getLocalPosition(DragEndDetails details) {
    RenderBox box = _pickerKey.currentContext!.findRenderObject() as RenderBox;
    Offset globalPosition = dragUpdateDetails.globalPosition;
    Offset localPosition = box.globalToLocal(globalPosition);
    double dx = localPosition.dx / _pickerWidth;
    double dy = localPosition.dy / _pickerHeight;
    setState(() {
      if (_hsv) {
        HSVColor hsvColor = HSVColor.fromAHSV(_alpha, _hue,
            (_saturation + dx).clamp(0.0, 1.0), (_value + dy).clamp(0.0, 1.0));
        _color = hsvColor.toColor();
        _hue = hsvColor.hue;
        _saturation = hsvColor.saturation;
        _value = hsvColor.value;
      } else {
        HSLColor hslColor = HSLColor.fromAHSL(_alpha, (_hue + dx * 360) % 360,
            (_saturation + dy).clamp(0.0, 1.0), _value);
        _color = hslColor.toColor();
        _hue = hslColor.hue;
        _saturation = hslColor.saturation;
      }
      widget.onColorChanged.call(_color);
    });
    return localPosition;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox box =
          _pickerKey.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        _pickerWidth = box.size.width;
        _pickerHeight = box.size.height;
        _color = widget.pickerColor;
        hsvColor = HSVColor.fromColor(_color);
        _red = _color.red.toDouble();
        _green = _color.green.toDouble();
        _blue = _color.blue.toDouble();
      });
    });
    _color = widget.pickerColor;
    _updateColorValues();
  }

  // Crea una fila de texto que muestra los valores de los componentes de color RGB y HSV/HSL del color seleccionado.
  Widget _buildColorLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              'RGB: (${(_red * 255).round()}, ${(_green * 255).round()}, ${(_blue * 255).round()})'),
          Text(
              '${_hsv ? 'HSV' : 'HSL'}: (${(_hue * 360).round()}, ${(_saturation * 100).round()}%, ${(_value * 100).round()}%)'),
        ],
      ),
    );
  }

  // Crea un área de selección de color HSL.
  Widget _buildHslPickerArea() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: CustomPaint(
              painter: HslPickerPainter(
                hue: _hue,
                saturation: _saturation,
                value: _value,
              ),
            ),
          );
        },
      ),
    );
  }

// Crea un área de selección de color HSV.
  Widget _buildHsvPickerArea() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: CustomPaint(
              painter: HsvPickerPainter(
                hue: _hue,
                saturation: _saturation,
                value: _value,
              ),
            ),
          );
        },
      ),
    );
  }

// Crea un slider para el valor de opacidad (alfa) del color seleccionado.
  Widget _buildOpacitySlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Opacidad'),
          Slider(
            value: _alpha,
            onChanged: (value) {
              setState(() {
                _alpha = value;
                _color = Color.fromARGB(
                  (_alpha * 255).round(),
                  (_red * 255).round(),
                  (_green * 255).round(),
                  (_blue * 255).round(),
                );
              });
            },
            min: 0.0,
            max: 1.0,
            activeColor: _color,
            inactiveColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

// Crea el área de selección de color
  Widget _buildPickerArea() {
    switch (widget.paletteType) {
      case PaletteType.rgb:
        return _buildRgbPickerArea();
      case PaletteType.hsl:
        return _buildHslPickerArea();
      case PaletteType.hsv:
      default:
        return _buildHsvPickerArea();
    }
  }

  // Crea el área de selección de color para el espacio de color RGB
  Widget _buildRgbPickerArea() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ColorPicker(
            pickerColor: _color,
            onColorChanged: (color) {
              setState(() {
                _color = color;
                _updateColorValues();
              });
            },
            colorPickerWidth: 240.0,
            pickerAreaHeightPercent: 0.7,
            enableAlpha: widget.enableAlpha,
            displayThumbColor: true,
            showLabel: false,
            paletteType: PaletteType.rgb,
            pickerAreaBorderRadius: const BorderRadius.vertical(
              top: Radius.circular(10.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildRgbSlider('R', _red, (value) {
                setState(() {
                  _red = value;
                  _color = Color.fromARGB(
                    (_alpha * 255).round(),
                    (_red * 255).round(),
                    (_green * 255).round(),
                    (_blue * 255).round(),
                  );
                  _updateColorValues();
                });
              }),
              _buildRgbSlider('G', _green, (value) {
                setState(() {
                  _green = value;
                  _color = Color.fromARGB(
                    (_alpha * 255).round(),
                    (_red * 255).round(),
                    (_green * 255).round(),
                    (_blue * 255).round(),
                  );
                  _updateColorValues();
                });
              }),
              _buildRgbSlider('B', _blue, (value) {
                setState(() {
                  _blue = value;
                  _color = Color.fromARGB(
                    (_alpha * 255).round(),
                    (_red * 255).round(),
                    (_green * 255).round(),
                    (_blue * 255).round(),
                  );
                  _updateColorValues();
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

// Crea un slider para el componente de color RGB especificado.
// El parámetro 'label' es una cadena que representa la etiqueta del slider (R, G o B).
// El parámetro 'value' es un valor de doble precisión que representa el valor actual del componente RGB.
// El parámetro 'onChanged' es una función de devolución de llamada que se llamará cuando se ajuste el valor del slider.
  Widget _buildRgbSlider(
      String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(label),
        Slider(
          value: value,
          onChanged: onChanged,
          min: 0.0,
          max: 1.0,
          activeColor: _color,
          inactiveColor: Colors.grey[300],
        ),
      ],
    );
  }

// Se llama cuando el usuario deja de tocar el área de selección de color.
// Actualiza los valores de los componentes de color HSL/HSV según la última posición del toque.
  void _onPanEnd(DragEndDetails details) {
    _updateColor(getLocalPosition(details));
  }

// Se llama cuando el usuario comienza a tocar el área de selección de color.
// Actualiza los valores de los componentes de color HSL/HSV según la posición del toque.
  void _onPanStart(DragStartDetails details) {
    _updateColor(details.localPosition);
  }

// Se llama cuando el usuario arrastra el dedo sobre el área de selección de color.
// Actualiza los valores de los componentes de color HSL/HSV según la posición del toque.
  void _onPanUpdate(DragUpdateDetails details) {
    dragUpdateDetails = details;
    _updateColor(details.localPosition);
  }

  // Actualiza los valores de los componentes de color HSL/HSV según la posición del toque.
  void _updateColor(Offset position) {
    setState(() {
      // Calcula los valores de los componentes de color HSL/HSV según la posición del toque.

      double hue = _hue;
      double saturation = _saturation;
      double value = _value;
      if (_hsv) {
        hue = 360.0 * position.dx / _pickerWidth;
        saturation = 1.0 - position.dy / _pickerHeight;
      } else {
        hue = 360.0 * position.dx / _pickerWidth;
        value = 1.0 - position.dy / _pickerHeight;
      }

      // Limita los valores de los componentes de color HSL/HSV a sus rangos válidos.
      hue = hue.clamp(0.0, 360.0);
      saturation = saturation.clamp(0.0, 1.0);
      value = value.clamp(0.0, 1.0);

      // Actualiza los valores de los componentes de color HSL/HSV y el color seleccionado.
      _hue = hue;
      _saturation = saturation;
      _value = value;
      _color = _hsv
          ? HSVColor.fromAHSV(_alpha, hue, saturation, value).toColor()
          : HSLColor.fromAHSL(_alpha, hue, saturation, value).toColor();
      hsvColor = HSVColor.fromColor(Colors.white);
    });
  }

  // Actualiza los valores de los componentes RGBA y HSV/HSL a partir del color seleccionado
  void _updateColorValues() {
    HSVColor hsv = HSVColor.fromColor(_color);
    _hue = hsv.hue;
    _saturation = hsv.saturation;
    _value = _color.value.toDouble();
    _red = _color.red / 255.0;
    _green = _color.green / 255.0;
    _blue = _color.blue / 255.0;
    _alpha = _color.alpha.toDouble();
  }
}
