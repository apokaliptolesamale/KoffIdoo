// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/interfaces/use_case.dart';
import '../../../app/modules/home/widgets/navbar.dart';
import '../botton/botton_navbar.dart';

class CustomView<T> extends GetResponsiveView<T> {
  List<Widget> actions = [];
  ResponsiveScreenSettings settings;
  CustomView(
      {Key? key,
      this.actions = const [],
      this.settings = const ResponsiveScreenSettings(
          desktopChangePoint: 800,
          tabletChangePoint: 700,
          watchChangePoint: 600)})
      : super(key: key, settings: settings);

  bool actionExists(Widget newAction) => actionPosition(newAction) != 0;

  int actionPosition(Widget newAction) {
    int position = 0;
    int c = 0;
    for (var action in actions) {
      c++;
      if (action is ButtonNavBar &&
          action.id == (newAction as ButtonNavBar).id) {
        position = c;
        break;
      }
    }
    return position;
  }

  CustomView<T> addNewAction(Widget action) {
    if (!actionExists(action)) actions.add(action);
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget? getActionById(String id) {
    for (var action in actions) {
      if (action is ButtonNavBar && action.id == id) return action;
    }
    return null;
  }

  List<Widget> getActions() {
    return actions;
  }

  AsyncWidgetBuilder<A> getBuilderByUseCase<A>(UseCase uc) {
    throw Exception("not implemented yet...");
  }

  Future<A> getFutureByUseCase<A>(UseCase uc) {
    throw Exception("not implemented yet...");
  }

  removeActionById(String id) {
    actions
        .removeWhere((action) => (action is ButtonNavBar && action.id == id));
  }

  showButtonsOnNavBar() {
    //Se utiliza para garantizar que se actualice la barra de navegación solamente cuando se ejecute la función build actual.
    _ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      NavBar.instance.getState.setActions(actions);
    });
  }

  T? _ambiguate<T>(T? value) => value;
}
