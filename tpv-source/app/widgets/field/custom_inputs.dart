// ignore_for_file: avoid_function_literals_in_foreach_calls, must_be_immutable

import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration Inputdecoration(
      {required Widget icon,
      String? hint,
      InputBorder? border,
      InputBorder? focusedBorder,
      InputBorder? enabledBorder}) {
    return InputDecoration(
      border: border ?? InputBorder.none,
      focusedBorder: focusedBorder ?? InputBorder.none,
      enabledBorder: enabledBorder ?? InputBorder.none,
      hintText: hint,
      prefixIcon: icon,
      labelStyle: TextStyle(color: Colors.grey),
      hintStyle: TextStyle(color: Colors.grey),
    );
  }
}

class CustomStyledInput extends StatefulWidget {
  String? hintText, _text;
  Widget? icon;
  List<void Function(CustomStyledInput input)> listeners;
  String? Function(String?)? validator;

  CustomStyledInput(
      {Key? key,
      this.listeners = const [],
      this.hintText,
      this.icon,
      this.validator})
      : super(key: key);

  String? get getValue => _text;

  set setText(String newText) {
    _text = newText;
  }

  @override
  State<CustomStyledInput> createState() => _CustomStyledInputState();
}

class _CustomStyledInputState extends State<CustomStyledInput>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black26, offset: Offset(0, 2))
        ],
      ),
      height: 50,
      child: GestureDetector(
        child: TextFormField(
          controller: editingController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          validator: widget.validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            errorMaxLines: 2,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Color(0xFF307DF1), fontSize: 16),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: widget.icon ??
                  Icon(
                    Icons.pin,
                    color: Color(0xFF00b1a4),
                  ),
            ),
          ),
          style: TextStyle(
            color: Color(0xFF307DF1),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    editingController.addListener(_handleChange);
    widget.listeners.forEach((element) {
      editingController.addListener(() {
        setState(() {
          widget.setText = editingController.text;
          element.call(widget);
        });
      });
    });
  }

  _handleChange() {
    setState(() {
      widget.setText = editingController.text;
    });
  }
}
