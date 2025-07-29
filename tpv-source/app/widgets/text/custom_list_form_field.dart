// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/app/core/patterns/publisher.dart' as pub;
import '../../core/services/logger_service.dart';
import '../../widgets/patterns/publisher_subscriber.dart';
import '../../widgets/utils/functions.dart';
import '../field/custom_drop_down.dart';
import '../field/custom_form_field.dart';
import 'custom_text_form_field.dart';

class CustomListFormField<T> extends StatefulWidget
    with WidgetsBindingObserver, SubscriberMixinImpl<T>, PublisherMixinImpl<T>
    implements CustomFormField {
  @override
  Map<String, void Function(Publisher<Subscriber<T>> event)> listeners;

  Function()? setValueFunction;

  final Function(CustomListFormField<T>, String?)? onFieldSubmitted,
      onSaved,
      onChanged;

  InputDecoration? decoration;

  TextEditingController controller;
  String? Function(CustomTextFormField, String?)? validator;
  /* validator: (textField, value) {
          return NotEmptyTextFieldValidator(
            value,
            text: "Tiempo de garantía",
          );
        }, */
  String? value;
  String labelText, name;
  _CustomListFormFieldState<T>? _state;
  TextInputType? keyboardType;

  List<TextInputFormatter>? inputFormatters;
  bool? enabled;
  AutovalidateMode? autovalidateMode;
  InputBorder? border,
      focusedBorder,
      enabledBorder,
      errorBorder,
      disabledBorder;
  BoxBorder? boxBorder,
      boxFocusedBorder,
      boxEnabledBorder,
      boxErrorBorder,
      boxDisabledBorder;
  FocusNode? focusNode;
  final List<Map<String, String>> options;
  bool showBorders = true;
  Widget? icon;

  CustomListFormField({
    Key? key,
    required this.name,
    required this.options,
    required this.controller,
    this.value,
    this.labelText = "",
    this.decoration,
    this.enabled = true,
    this.border,
    this.disabledBorder,
    this.enabledBorder,
    this.errorBorder,
    this.boxBorder,
    this.boxDisabledBorder,
    this.boxEnabledBorder,
    this.boxErrorBorder,
    this.focusedBorder,
    this.validator,
    this.listeners = const {},
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.setValueFunction,
    this.autovalidateMode,
    this.focusNode,
    this.icon,
    this.showBorders = true,
  }) : super(key: key) {
    validator = validator ??
        (textField, value) {
          return NotEmptyTextFieldValidator(value);
        };
    border = border ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.6),
            width: 1.0,
          ),
        );
    disabledBorder = disabledBorder ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blueAccent.withOpacity(0.2),
            width: 1.0,
          ),
        );
    enabledBorder = enabledBorder ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blueAccent.withOpacity(0.2),
            width: 1.0,
          ),
        );
    errorBorder = errorBorder ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.2),
            width: 1.0,
          ),
        );
    boxBorder = boxBorder ??
        Border.all(
          color: Colors.grey.withOpacity(0.6),
          width: 1.0,
          style: BorderStyle.solid,
        );

    boxDisabledBorder = boxDisabledBorder ??
        Border.all(
          color: Colors.blueAccent.withOpacity(0.6),
          width: 1.0,
          style: BorderStyle.none,
        );
    boxEnabledBorder = boxEnabledBorder ??
        Border.all(
          color: Colors.blueAccent.withOpacity(0.6),
          width: 1.0,
          style: BorderStyle.none,
        );
    boxErrorBorder = boxErrorBorder ??
        Border.all(
          color: Colors.red.withOpacity(0.2),
          width: 1.0,
          style: BorderStyle.none,
        );
    focusedBorder = enabledBorder;
    applyListeners();
  }

  _CustomListFormFieldState<T> get getState =>
      _state != null ? _state! : _state = createState();

  @override
  Map<String, List<void Function(Publisher<Subscriber<T>> event)>>
      get getSubscriptionsFunction => subscriptionsFunction;

  @override
  String? get getValue {
    return value;
  }

  applyValueFunction(Function()? valueFunction) {
    if (getState.mounted) {
      getState.applyValueFunction(setValueFunction = valueFunction);
    }
  }

  @override
  _CustomListFormFieldState<T> createState() => _CustomListFormFieldState<T>();

  @override
  void receiveMessage(pub.Message message) {
    log('Ha recibido el mensaje: ${message.content}');
  }

  setValue(String newValue) {
    if (getState.mounted) {
      getState.setValue(value = newValue);
    }
  }

  @override
  update(String newValue, void Function() callback) {
    if (getState.mounted) {
      getState.update(value = newValue, callback);
    }
  }
}

class _CustomListFormFieldState<T> extends State<CustomListFormField<T>> {
  String? value;
  TextEditingController? _controller;
  FocusNode? focusNode;
  List<Map<String, String>> options = [];
  List<Map<String, String>> _filteredOptions = [];
  OptionItem? selectedOption;
  String filterValue = '';
  FocusNode myFocusNode = FocusNode();
  applyValueFunction(Function()? valueFunction) {
    if (mounted) {
      setState(() {
        widget.setValueFunction = valueFunction;
        value = widget.value = valueFunction != null ? valueFunction() : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> targets = [];
    List<OptionItem> items = [];
    options = widget.options;
    _filteredOptions = _filteredOptions.isEmpty ? options : _filteredOptions;
    //value = widget.controller.text;
    _filteredOptions.map((option) {
      String name = "${option['name']}";
      String id = "${option['id']}:$name";
      targets.add(name);
      items.add(OptionItem(
        id: id,
        title: name,
      ));
      return DropdownMenuItem<String>(
        value: name,
        child: Text(name),
      );
    }).toList();
    CustomDropListModel dropListModel = CustomDropListModel(items);
    selectedOption = items.isNotEmpty ? items.elementAt(0) : null;

    return SelectDropList(
      name: widget.name,
      dropListModel: dropListModel,
      itemSelected: selectedOption,
      focus: myFocusNode,
      labelText: widget.labelText,
      textController: getTextEditingController(),
      icon: widget.icon,
      showBorders: widget.showBorders,
      border: widget.boxBorder,
      disabledBorder: widget.boxDisabledBorder,
      enabledBorder: widget.boxEnabledBorder,
      errorBorder: widget.boxErrorBorder,
      focusedBorder: widget.boxFocusedBorder,
      onChanged: (sdl, value) {
        onChange();
      },
      onOptionSelected: (objectList, optionItem) {
        selectedOption = optionItem;
        widget.onChanged!(widget, selectedOption!.title);
        setState(() {
          selectedOption = optionItem;
          _filteredOptions = options;
        });
        objectList.updateItemSelected(optionItem);
        objectList.textController.text = optionItem.title;
        /*if (objectList.focus != null) {
          objectList.focus!.unfocus();
        }*/
      },
      validator: widget.validator,
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    if (_controller != null) {
      _controller!.dispose();
      _controller = null;
    }
    super.dispose();
  }

  List<Map<String, String>> filterList({
    bool update = false,
  }) {
    List<Map<String, String>> filtered = List.empty(growable: true);
    if (mounted && _controller != null) {
      String filterText = _controller!.text;
      filtered = widget.options.where((option) {
        String value = "${option['name']}";
        return value.toLowerCase().contains(filterText.toLowerCase());
      }).toList();
      if (update) {
        setState(() {
          filterValue = filterText;
          _filteredOptions = filtered;
        });
      }
    }
    return filtered;
  }

  TextEditingController getTextEditingController() {
    return _controller = _controller ?? widget.controller;
  }

  initController() {
    value = widget.value;
    _controller = getTextEditingController();
    _controller!.addListener(onChange);
    //_controller!.text = value ?? "";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode;
    options = widget.options;
    _filteredOptions = options;
    value = widget.value;
    initController();
  }

  onChange() {
    if (mounted && _controller != null) {
      if (widget.onChanged != null) {
        widget.onChanged!(widget, _controller!.text);
      }
      setState(() {
        value = widget.value = _controller!.text;
        filterValue = value!;
        _filteredOptions = filterList();
      });
    }
  }

  setTextToEditingController(String text) {
    if (_controller != null) {
      _controller!.text = text;
    }
    return this;
  }

  setValue(String newValue) {
    if (_controller != null) {
      _controller!.text = newValue;
      setState(() {
        value = widget.value = _controller!.text;
      });
    }
  }

  update(String newValue, void Function() callback) {
    if (mounted) {
      callback();
      setState(() {});
    }
  }
}
