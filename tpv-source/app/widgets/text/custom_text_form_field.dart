// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/app/core/patterns/publisher.dart' as pub;
import '../../core/services/logger_service.dart';
import '../../widgets/patterns/publisher_subscriber.dart';
import '../../widgets/utils/functions.dart';
import '../field/custom_form_field.dart';

class CustomTextFormField<T> extends StatefulWidget
    with WidgetsBindingObserver, SubscriberMixinImpl<T>, PublisherMixinImpl<T>
    implements CustomFormField {
  @override
  Map<String, void Function(Publisher<Subscriber<T>> event)> listeners;

  Function()? setValueFunction;

  final Function(CustomTextFormField<T>, String?)? onFieldSubmitted,
      onSaved,
      onChanged;

  InputDecoration? inputDecoration;
  Decoration? decoration;

  TextEditingController controller;
  String? Function(CustomTextFormField, String?)? validator;
  String? value;
  String labelText, name;
  _CustomTextFormFieldState<T>? _state;
  TextInputType? keyboardType;
  void Function()? onTap;
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
  FocusNode focusNode;
  Widget? icon;
  bool showBorders = true;
  CustomTextFormField({
    Key? key,
    required this.name,
    required this.controller,
    required this.focusNode,
    this.value,
    this.labelText = "",
    this.inputDecoration,
    this.enabled = true,
    this.border,
    this.disabledBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.validator,
    this.listeners = const {},
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.setValueFunction,
    this.autovalidateMode,
    this.icon,
    this.showBorders = true,
  }) : super(key: key) {
    validator = validator ??
        (textField, value) {
          return NotEmptyTextFieldValidator(value);
        };
    /* value = value ??
        getValueFromGetxArguments(name) ?? getValueFromGlobalMap(name);*/

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

  _CustomTextFormFieldState<T> get getState =>
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
  _CustomTextFormFieldState<T> createState() => _CustomTextFormFieldState<T>();

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

class _CustomTextFormFieldState<T> extends State<CustomTextFormField<T>> {
  String? value;
  TextEditingController? _controller;
  FocusNode? focusNode;
  bool isShow = false;
  bool wasDisposed = false;
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
    final decoration = widget.showBorders
        ? BoxDecoration(
            borderRadius: isShow
                ? BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                : BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            border: !isShow
                ? widget.boxBorder
                : Border.all(
                    color: Colors.blueAccent.withOpacity(0.2),
                    width: 1.0,
                  ),
          )
        : null;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: widget.showBorders && widget.decoration != null
                ? widget.decoration
                : decoration,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.icon != null) ...[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    child: widget.icon!,
                  )
                  /*SizedBox(
                    width: 10,
                  ),*/
                ],
                Expanded(
                    child: GestureDetector(
                  //onTap: () => onTap,
                  behavior: HitTestBehavior.translucent,
                  child: TextFormField(
                      key: widget.key,
                      controller: _controller,
                      initialValue: _controller != null ? null : value,
                      focusNode: focusNode,
                      keyboardType: widget.keyboardType,
                      enabled: widget.enabled, // Habilita el campo de entrada
                      style: TextStyle(
                        color: Colors
                            .black, // Establece el color del texto a negro
                      ),
                      autovalidateMode: widget.autovalidateMode,
                      //autofocus: true,
                      //autocorrect: true,
                      inputFormatters: widget.inputFormatters,
                      onTap: widget.onTap,
                      onFieldSubmitted: (newValue) {
                        if (widget.onFieldSubmitted != null) {
                          widget.onFieldSubmitted!(widget, newValue);
                        }
                        value = widget.value = newValue;
                      },
                      onSaved: (newValue) {
                        if (widget.onSaved != null) {
                          widget.onSaved!(widget, newValue);
                        }
                        value = widget.value = newValue;
                      },
                      onChanged: (newValue) {
                        if (widget.onChanged != null) {
                          widget.onChanged!(widget, newValue);
                        }
                        /*if (widget.focusNode.hasFocus) {
                          //widget.focusNode!.unfocus();
                        }*/
                        if (mounted) {
                          setState(() {
                            value = widget.value = newValue;
                          });
                        }
                      },
                      decoration: widget.inputDecoration ??
                          InputDecoration(
                            border: widget.border ?? InputBorder.none,
                            focusedBorder:
                                widget.focusedBorder ?? InputBorder.none,
                            enabledBorder:
                                widget.enabledBorder ?? InputBorder.none,
                            errorBorder: widget.errorBorder ?? InputBorder.none,
                            disabledBorder:
                                widget.disabledBorder ?? InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            labelText: widget.labelText,
                          ),
                      validator: widget.validator != null
                          ? (value) {
                              return widget.validator!(widget, value);
                            }
                          : null),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    setState(() {
      wasDisposed = true;
    });
    if (_controller != null) {
      _controller!.dispose();
      _controller = null;
    }
    super.dispose();
  }

  TextEditingController getTextEditingController() {
    wasDisposed
        ? widget.controller = TextEditingController()
        : widget.controller;
    return _controller = _controller ?? widget.controller;
  }

  initController() {
    value = widget.value;
    _controller = getTextEditingController();
    if (_controller != null) {
      _controller!.addListener(onChange);
    }
    setState(() {
      value = widget.value;
    });
  }

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode;
    initController();
  }

  onChange() {
    if (mounted && _controller != null) {
      setState(() {
        value = widget.value = getTextEditingController().text;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(widget, getTextEditingController().text);
      }
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
    }
  }

  update(String newValue, void Function() callback) {
    getTextEditingController().text = newValue;
    getTextEditingController().selection = TextSelection.fromPosition(
        TextPosition(offset: getTextEditingController().text.length));
    getTextEditingController().notifyListeners();
    callback();
    setState(() {});
  }
}
