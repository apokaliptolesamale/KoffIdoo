// ignore_for_file: must_be_immutable, prefer_final_fields, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/helpers/functions.dart';
import '../text/custom_list_form_field.dart';

class DropDownWithAdd extends StatefulWidget {
  final List<Map<String, String>> initialOptions;
  void Function(Object?)? onChanged;
  void Function(String id, String name) onAdd;
  String hintText;

  String? labelText;
  String? value;
  String name;
  final Function(CustomListFormField, String?)? onFieldSubmitted, onSaved;

  TextInputType? keyboardType;
  InputDecoration? decoration;
  List<TextInputFormatter>? inputFormatters;
  bool? enabled;
  AutovalidateMode? autovalidateMode;
  InputBorder? border,
      focusedBorder,
      enabledBorder,
      errorBorder,
      disabledBorder;
  FocusNode? focusNode;
  String? Function(CustomListFormField, String?)? validator;
  CustomListFormField dropDown;
  DropDownWithAdd({
    required this.initialOptions,
    required this.onChanged,
    required this.onAdd,
    required this.name,
    required this.dropDown,
    this.hintText = "Adicionar...",
    this.labelText,
    this.onFieldSubmitted,
    this.onSaved,
    this.border,
    this.disabledBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.decoration,
    this.focusNode,
    this.autovalidateMode,
    this.enabled,
    this.inputFormatters,
    this.keyboardType,
    this.validator,
    this.value,
  });

  @override
  _DropdownWithAddState createState() => _DropdownWithAddState();
}

class _DropdownWithAddState extends State<DropDownWithAdd> {
  // Variable para almacenar la opción seleccionada
  String? selectedOption;

  // Lista de opciones, que se inicializa con las opciones recibidas en el constructor
  List<Map<String, String>> _options = [];

  List<DropdownMenuItem<String>>? items = [];

  // Controlador para el TextFormField
  TextEditingController? _textController;

  String? value;

  FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    // Agrega las opciones iniciales a la lista de opciones
    _options = widget.initialOptions;
    // Establece la primera opción como la opción seleccionada inicialmente
    selectedOption =
        _options.isNotEmpty ? _options[0]["name"] : "Seleccione una opción";

    _options = List.from(_options);
    _options.sort((a, b) => a['name']!.compareTo(b['name']!));
    items = _options.map((option) {
      String uc = "${option['name']}";
      String id = "${option['id']}:$uc";
      return DropdownMenuItem(
        value: id,
        child: Text(uc),
      );
    }).toList();
    return Row(
      children: <Widget>[
        // DropdownButton para mostrar las opciones
        DropdownButton<String>(
          //value: selectedOption,

          items: items,
          onChanged: (String? newValue) {
            widget.onChanged != null ? widget.onChanged!(newValue) : null;
            setState(() {
              selectedOption = newValue;
            });
          },
        ),
        SizedBox(width: 8.0),
        // TextFormField para ingresar una nueva opción
        Expanded(
          child: TextFormField(
            key: widget.key,
            controller: _textController,
            initialValue: _textController != null ? null : value,
            focusNode: focusNode,
            keyboardType: widget.keyboardType,
            enabled: widget.enabled,
            autovalidateMode: widget.autovalidateMode,
            autofocus: true,
            autocorrect: true,
            inputFormatters: widget.inputFormatters,
            onFieldSubmitted: (newValue) {
              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted!(widget.dropDown, newValue);
              }
              value = widget.value = newValue;
            },
            onSaved: (newValue) {
              if (widget.onSaved != null) {
                widget.onSaved!(widget.dropDown, newValue);
              }
              value = widget.value = newValue;
            },
            onChanged: (newValue) {
              if (mounted) {
                setState(() {
                  value = widget.value = newValue;
                });
              }
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            },
            decoration: widget.decoration ??
                InputDecoration(
                  border: widget.border ?? InputBorder.none,
                  focusedBorder: widget.focusedBorder ?? InputBorder.none,
                  enabledBorder: widget.enabledBorder ?? InputBorder.none,
                  errorBorder: widget.errorBorder ?? InputBorder.none,
                  disabledBorder: widget.disabledBorder ?? InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  labelText: widget.labelText,
                ),
            validator: widget.validator != null
                ? (value) {
                    return widget.validator!(widget.dropDown, value);
                  }
                : null,
          ),
        ),
        // Botón para agregar la nueva opción
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              // Obtiene el valor ingresado en el TextFormField y lo limpia
              String newOption = _textController!.text.trim();
              final list = _options.map((option) {
                return option['name'];
              }).toList();
              // Si el valor no está vacío y no está en la lista de opciones, lo agrega a la lista y lo establece como la opción seleccionada
              if (newOption.isNotEmpty &&
                  !list.contains(newOption) &&
                  newOption != "Seleccione una opción") {
                final id = idGenerator();
                _options.add({
                  "id": id,
                  "name": newOption,
                });
                widget.onAdd(id, newOption);
                selectedOption = newOption;
              }
              _textController!.clear();
            });
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Libera el controlador del TextFormField
    _textController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _textController = TextEditingController();
    _options = widget.initialOptions;
    super.initState();
    // Agrega las opciones iniciales a la lista de opciones
    _options.addAll(widget.initialOptions);
    // Establece la primera opción como la opción seleccionada inicialmente
    selectedOption =
        _options.isNotEmpty ? _options[0]["name"] : "Seleccione una opción";

    items = _options.map((option) {
      return DropdownMenuItem(
        value: option['id'],
        child: Text(option['name'] ?? ""),
      );
    }).toList();
  }
}
