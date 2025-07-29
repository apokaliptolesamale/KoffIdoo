import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static final MenuController instance =
      !Get.isRegistered() ? MenuController._createInstance() : Get.find();

  final activeItem = "/dashboard".obs;
  final hoverItem = "".obs;

  Color isHoveringColor = Colors.blue;
  Color isNotHoveringColor = Colors.blue.withOpacity(0.2);
  final Map<String, dynamic> menuIcons = {};
  factory MenuController() {
    return Get.find();
  }
  MenuController._createInstance();

  changeActiveitemTo(String itemName) {
    activeItem.value = itemName;
  }

  Widget customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: 22,
        color: isHoveringColor,
      );
    }
    return Icon(
      icon,
      color: isHovering(itemName) ? isHoveringColor : isNotHoveringColor,
    );
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  Widget returnIconFor(String itemName) {
    return menuIcons.containsKey(itemName)
        ? menuIcons[itemName] is IconData
            ? customIcon(menuIcons[itemName], itemName)
            : menuIcons[itemName]
        : customIcon(Icons.exit_to_app, itemName);
  }

  setHoveringColor(Color color) {
    isHoveringColor = color;
  }

  setNotHoveringColor(Color color) {
    isNotHoveringColor = color;
  }
}
