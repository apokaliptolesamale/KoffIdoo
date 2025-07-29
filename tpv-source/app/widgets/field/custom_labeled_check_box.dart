// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';

class GroupLabeledCheckbox extends StatelessWidget {
  final List<LabeledCheckbox> list;
  TextStyle? textStyle;

  GroupLabeledCheckbox({Key? key, required this.list, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listElements = list.map((e) {
      e.setTextStyle(textStyle);
      return e;
    }).toList();
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: listElements,
      ),
    );
  }
}

class LabeledCheckbox extends StatefulWidget {
  final bool? value;
  final String label;
  final bool leadingCheckbox;
  final ValueChanged<bool?>? onChanged;
  TextStyle? textStyle;
  _LabeledCheckboxState? _state;

  LabeledCheckbox({
    Key? key,
    this.value,
    this.onChanged,
    this.label = '',
    this.leadingCheckbox = true,
    this.textStyle,
  }) : super(key: key) {
    _state = getState;
  }

  void setTextStyle(TextStyle? textStyle) {
    this.textStyle = textStyle;
    if (getState.mounted) getState.setTextStyle(textStyle);
  }

  _LabeledCheckboxState get getState => _state ?? createState();

  @override
  _LabeledCheckboxState createState() => _LabeledCheckboxState();
}

class _LabeledCheckboxState extends State<LabeledCheckbox> {
  var value = false;
  TextStyle? textStyle;
  @override
  void initState() {
    super.initState();
    value = widget.value == true;
    textStyle = widget.textStyle;
  }

  void setTextStyle(TextStyle? newTextStyle) {
    setState(() {
      textStyle = newTextStyle;
    });
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[
      _buildCheckbox(context),
    ];
    if (widget.label.isNotEmpty) {
      if (widget.leadingCheckbox) {
        widgets.add(_buildLabel(context));
      } else {
        widgets.insert(0, _buildLabel(context));
      }
    }
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () => _onCheckedChanged(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    );
  }

  Widget _buildCheckbox(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) => _onCheckedChanged(),
    );
  }

  Widget _buildLabel(BuildContext context) {
    var padding = widget.leadingCheckbox
        ? const EdgeInsets.only(right: 8)
        : const EdgeInsets.only(left: 8);

    return Padding(
      padding: padding,
      child: Text(
        widget.label,
        style: textStyle,
      ),
    );
  }

  void _onCheckedChanged() {
    setState(() {
      value = !value;
    });
    if (widget.onChanged != null) {
      widget.onChanged!.call(value);
    }
  }
}
