// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/config/assets.dart';
import '../../../app/core/config/styles.dart';
import '../../../app/core/constants/controllers.dart';
import '../../../app/routes/app_pages.dart';
import '../../../app/widgets/screen/responsiveness.dart';
import '../../../app/widgets/view/get_pages_ext.dart';
import 'side_menu_item.dart';

class EnZonaSideMenu extends StatelessWidget {
  EnZonaSideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 48,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(ASSETS_IMAGES_LOGOS_LOGO_PNG),
                      ),
                    ),
                    /*CustomText(
                      text: "Dash",
                      size: 20,
                      weight: FontWeight.bold,
                      color: active,
                    ),*/
                    SizedBox(
                      width: width / 48,
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(
            height: 40,
          ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: AppPages.pagesWithTitle()
                .map(
                  (page) => createMenuItemFor(context, page),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  Widget createMenuItemFor(BuildContext context, GetPage page) {
    if (page is CustomGetPage) {
      menuController.menuIcons.putIfAbsent(
          page.name, () => menuController.customIcon(page.iconPage, page.name));
    }

    return SideMenuItem(
      itemName: page.title!,
      route: page.name,
      onTap: () {
        if (!menuController.isActive(page.name)) {
          menuController.changeActiveitemTo(page.name);
          if (ResponsiveWidget.isSmallScreen(context)) {
            Get.back();
          }
          //navigationController.navidateTo(page.name);
          Get.toNamed(page.name);
        }
      },
    );
  }
}
