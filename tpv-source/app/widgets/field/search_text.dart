// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';

import '../components/custom_widget.dart';
import 'custom_inputs.dart';

typedef onChangedCallBack = void Function(
    BuildContext context, SearchText textField, String text);
typedef onTapCallBack = void Function(
    BuildContext context, SearchText textField, String text);

class SearchText extends StatelessWidget implements CustomWidgetInterface {
  Widget? textField;
  InputDecoration? decoration;
  Decoration? containerDecoration;
  onChangedCallBack? onChanged;
  onTapCallBack? onTap;
  double width, height;
  EdgeInsetsGeometry? margin;

  final TextEditingController controller = TextEditingController();

  @override
  CustomWidgetInterface? container;

  SearchText({
    Key? key,
    this.textField,
    this.decoration,
    this.containerDecoration,
    this.onChanged,
    this.onTap,
    this.width = 150,
    this.height = 50,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(5),
      height: height,
      width: width,
      decoration: buildBoxDecoration(),
      child: textField ??
          TextField(
            controller: controller,
            enabled: true,
            autofocus: true,
            onChanged: (text) {
              onChanged != null ? onChanged!(context, this, text) : false;
            },
            onTap: () {
              onTap != null ? onTap!(context, this, controller.text) : false;
            },
            decoration: decoration ??
                CustomInputs.Inputdecoration(
                  icon: Icon(Icons.search),
                ),
          ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.1),
      );

  @override
  CustomWidgetInterface setContainer(CustomWidgetInterface container) {
    this.container = container;
    return this;
  }
}
