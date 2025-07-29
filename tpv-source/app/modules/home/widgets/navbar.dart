// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'navbar_avatar.dart';
import 'notification_indicator.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  List<Widget>? actions = const [];
  double height = 35;
  _NavBarState? _state;

  static final NavBar instance = NavBar._internal([]);

  NavBar({
    Key? key,
    this.actions,
    this.height = 35,
  }) : super(key: key);

  NavBar._internal(this.actions);

  _NavBarState get getState => _state ?? createState();

  @override
  _NavBarState createState() => _state = _NavBarState();

  T? _ambiguate<T>(T? value) => value;

  setActions(List<Widget>? newactions) {
    _ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      if (getState.mounted) {
        getState.setActions(newactions ?? []);
      }
    });
  }

  setHeight(double newHeight) {
    if (getState.mounted) {
      getState.setHeight(newHeight);
    }
  }

  clearExtraButtons() {
    if (getState.mounted) {
      setActions([]);
    }
  }

  @override
  Size get preferredSize => Size(double.infinity, 40);
}

class _NavBarState extends State<NavBar> {
  List<Widget>? localActions = const [];
  double height = 40;

  @override
  void initState() {
    super.initState();
    height = widget.height;
    widget._state = this;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: height,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          Spacer(),
          ...getViewActions(),
          SizedBox(width: 10),
          NotificationIndicator(),
          SizedBox(width: 10),
          NavBarAvatar(),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  setActions(List<Widget> newactions) {
    setState(() => localActions = widget.actions = newactions);
  }

  setHeight(double newHeight) {
    setState(() => height = widget.height = newHeight);
  }

  List<Widget> getViewActions() {
    return localActions ?? [];
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        //border: Border.all(color: Color(0xff092044)),
        backgroundBlendMode: BlendMode.overlay,
        //borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      );
}
