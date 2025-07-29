// ignore_for_file: must_be_immutable, unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/widgets/utils/size_constraints.dart';

class CustomMenuItem extends StatefulWidget implements MenuItem {
  State<StatefulWidget>? _state;
  final String text;
  final IconData icon;
  final bool isActive;
  VoidCallback onPressed;
  VoidCallback? onOpenAction;
  VoidCallback? onCloseAction;
  List<MenuItem> children = [];
  List<MenuItem> _members = [];
  List<MenuItem> _menus = [];
  Intent? _intent;
  MenuSerializableShortcut? _shortcut;

  Color color;

  CustomMenuItem(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed,
      List<MenuItem> members = const [],
      List<MenuItem> menus = const [],
      MenuSerializableShortcut? shortcut,
      Intent? intent,
      this.onCloseAction,
      this.onOpenAction,
      this.children = const [],
      this.isActive = false,
      this.color = Colors.transparent})
      : super(key: key) {
    _state = getState;
    _members = members;
    _menus = menus;
    _intent = intent;
    _shortcut = shortcut;
    MenuItemSingleList.instance.add(this);
  }

  List<MenuItem> get descendants => children;

  State<StatefulWidget> get getState => _state ?? createState();

  List<MenuItem> get members => _members;

  List<MenuItem> get menus => _menus;

  VoidCallback? get onClose => onCloseAction;

  VoidCallback? get onOpen => onOpenAction;

  VoidCallback? get onSelected => onPressed;

  Intent? get onSelectedIntent => _intent;

  MenuSerializableShortcut? get shortcut => throw UnimplementedError();

  @override
  State<StatefulWidget> createState() => _MenuItemState();

  Iterable<Map<String, Object?>> toChannelRepresentation(
    PlatformMenuDelegate delegate, {
    required MenuItemSerializableIdGenerator getId,
  }) {
    // TODO: implement toChannelRepresentation
    throw UnimplementedError();
  }
  /*
  
   @override
  Iterable<Map<String, Object?>> toChannelRepresentation(
    PlatformMenuDelegate delegate, {
    required int index,
    required int count,
    required MenuItemSerializableIdGenerator getId,
  }) {
    // TODO: implement toChannelRepresentation
    throw UnimplementedError();
  }
  
   */
}

abstract class MenuItem {}

class MenuItemSingleList {
  static final MenuItemSingleList instance = MenuItemSingleList._internal([]);

  List<CustomMenuItem> items = const [];

  MenuItemSingleList({
    Key? key,
    this.items = const [],
  });

  MenuItemSingleList._internal(this.items);

  MenuItemSingleList add(CustomMenuItem newItem) {
    CustomMenuItem? item = getByText(newItem);
    if (item == null) {
      items.add(newItem);
    }
    return this;
  }

  bool exists(CustomMenuItem newItem) {
    return getByText(newItem) != null;
  }

  CustomMenuItem? getByText(CustomMenuItem newItem) {
    for (var element in items) {
      if (element.text == newItem.text) return newItem;
    }
    return null;
  }
}

class _MenuItemState extends State<CustomMenuItem> {
  bool isHovered = false;
  bool isActive = false;
  Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    final constraint = SizeConstraints(context: context);
    color = isHovered
        ? Colors.white.withOpacity(0.1)
        : widget.isActive
            ? Colors.white.withOpacity(0.1)
            : Colors.transparent;
    return AnimatedContainer(
      width: double.infinity,
      duration: Duration(milliseconds: 150),
      color: color,
      child: InkWell(
        onTap: widget.isActive
            ? () {
                isHovered = true;
              }
            : () => widget.onPressed(),
        child: Padding(
          padding: EdgeInsets.only(left: constraint.getWidthByPercent(2)),
          child: MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = widget.isActive),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: Colors.white.withOpacity(0.3),
                  size: constraint.getWidthByPercent(2),
                ),
                SizedBox(width: 10),
                FittedBox(
                  child: Text(
                    widget.text,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.roboto(
                      fontSize: constraint.getWidthByPercent(1),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textScaleFactor: 1,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    widget._state = this;
    super.initState();
    color = isHovered
        ? Colors.white.withOpacity(0.1)
        : widget.isActive
            ? Colors.white.withOpacity(0.1)
            : Colors.transparent;
  }
}
