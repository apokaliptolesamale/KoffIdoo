// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/helpers/functions.dart';
import '../../core/services/store_service.dart';
import '../text/custom_text_form_field.dart';

class CustomDropListModel {
  final List<OptionItem> listOptionItems;

  CustomDropListModel(this.listOptionItems);
}

class OptionItem {
  final dynamic id;
  final String title;

  OptionItem({
    required this.id,
    required this.title,
  });
}

class SelectDropList extends StatefulWidget {
  final OptionItem? itemSelected;
  final CustomDropListModel dropListModel;
  final Function(SelectDropList list, OptionItem optionItem) onOptionSelected;
  Decoration? decoration;
  BoxBorder? border, focusedBorder, enabledBorder, errorBorder, disabledBorder;
  String? Function(CustomTextFormField, String?)? validator;
  Widget? icon;
  _SelectDropListState? _state;
  TextEditingController textController;
  final String name, storeKey;
  String? labelText;
  bool showBorders = true;
  FocusNode focus;

  final Function(SelectDropList, String?)? onFieldSubmitted, onSaved, onChanged;

  SelectDropList({
    this.itemSelected,
    required this.name,
    required this.dropListModel,
    required this.onOptionSelected,
    required this.textController,
    required this.focus,
    this.storeKey = "system",
    this.decoration,
    this.border,
    this.disabledBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.icon,
    this.labelText,
    this.validator,
    this.showBorders = true,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
  }) {
    border = border ??
        Border.all(
          color: Colors.grey.withOpacity(0.6),
          width: 1.0,
          style: BorderStyle.solid,
        );

    disabledBorder = disabledBorder ??
        Border.all(
          color: Colors.blueAccent.withOpacity(0.6),
          width: 1.0,
          style: BorderStyle.none,
        );
    enabledBorder = enabledBorder ??
        Border.all(
          color: Colors.blueAccent.withOpacity(0.6),
          width: 1.0,
          style: BorderStyle.none,
        );
    errorBorder = errorBorder ??
        Border.all(
          color: Colors.red.withOpacity(0.2),
          width: 1.0,
          style: BorderStyle.none,
        );
    focusedBorder = enabledBorder;
  }
  _SelectDropListState get getState => _state ?? _SelectDropListState();
  @override
  _SelectDropListState createState() => getState;

  updateItemSelected(OptionItem itemSelected) {
    if (getState.mounted) {
      getState.updateItemSelected(itemSelected);
    }
  }
}

class _SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  //Propiedades
  OptionItem? optionItemSelected;
  late CustomDropListModel dropListModel;
  late AnimationController expandController;
  late Animation<double> animation;
  TextEditingController? textController;
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    optionItemSelected = widget.itemSelected;
    dropListModel = widget.dropListModel;
    final StoreService mapFields = StoreService();
    final key = widget.storeKey;
    final store = mapFields.getStore<dynamic, dynamic>(key);
    String tradeName = store.get(widget.name, "");
    final boxDecoration = widget.showBorders
        ? BoxDecoration(
            borderRadius: isShow
                ? BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                : BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            border: !isShow
                ? widget.border
                : Border.all(
                    color: Colors.blueAccent.withOpacity(0.2),
                    width: 1.0,
                  ),
            /*boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black26,
                        offset: Offset(0, 2))
                  ],*/
          )
        : null;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: widget.showBorders && widget.decoration != null
                ? widget.decoration
                : boxDecoration,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.icon != null) ...[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    child: widget.icon!,
                  ),
                  /* SizedBox(
                    width: 10,
                  ),*/
                ],
                Expanded(
                    child: CustomTextFormField(
                  name: widget.name,
                  showBorders: false,
                  controller: getTextEditingController(),
                  focusNode: widget.focus,
                  onChanged: (field, value) {
                    store.set(field.name, value);
                    //field.controller.text = value ?? "";

                    /*if (field.focusNode != null) {
                      field.focusNode!.unfocus();
                    }*/
                  },
                  onTap: () {
                    onTap();
                  },
                  labelText: widget.labelText ?? "",
                  keyboardType: TextInputType.name,
                  value: tradeName,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  validator: widget.validator ??
                      (textField, value) {
                        if (value == null || value == "") {
                          return NotEmptyTextFieldValidator(
                            value,
                            text: "Vacío o incorrecto.",
                          );
                        }
                        return null;
                      },
                )),
                Align(
                  alignment: Alignment(1, 0),
                  child: Icon(
                    isShow ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: Color(0xFF307DF1),
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.black26,
                      offset: Offset(0, 4))
                ],
              ),
              child: _buildDropListOptions(
                dropListModel.listOptionItems,
                context,
              ),
            ),
          ),
//          Divider(color: Colors.grey.shade300, height: 1,)
        ],
      ),
    );
  }

  @override
  void dispose() {
    expandController.dispose();
    textController!.dispose();
    textController = null;
    super.dispose();
  }

  TextEditingController getTextEditingController() {
    return textController = textController ?? widget.textController;
  }

  @override
  void initState() {
    super.initState();
    optionItemSelected = widget.itemSelected;
    dropListModel = widget.dropListModel;
    getTextEditingController();
    if (widget.onChanged != null) {
      textController!.addListener(() {
        widget.onChanged!(widget, textController!.text);
      });
    }
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  onTap() {
    isShow = !isShow;
    _runExpandCheck();
    setState(() {});
  }

  updateItemSelected(OptionItem itemSelected) {
    if (mounted) {
      setState(() {
        optionItemSelected = itemSelected;
      });
    }
  }

  Column _buildDropListOptions(List<OptionItem> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, top: 5, bottom: 5),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: Color(0xFF307DF1),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          isShow = false;
          expandController.reverse();
          widget.onOptionSelected(widget, item);
          final StoreService mapFields = StoreService();
          final key = widget.storeKey;
          final store = mapFields.getStore<dynamic, dynamic>(key);
          store.set(widget.name, item.title);
          (textController = getTextEditingController()).text = item.title;
          setState(() {
            optionItemSelected = item;
          });
        },
      ),
    );
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }
}
