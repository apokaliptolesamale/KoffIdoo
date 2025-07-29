import 'package:flutter/material.dart';

import '../../core/config/styles.dart';
import '../screen/responsiveness.dart';
import '../text/custom_text.dart';

AppBar topNavegationBar(
  BuildContext context,
  GlobalKey<ScaffoldState> key,
) =>
    AppBar(
        leading: !ResponsiveWidget.isSmallScreen(context)
            ? Container(
                padding: const EdgeInsets.only(left: 8),
                child: Image.asset(
                  "images/logos/logo.png",
                  width: 20,
                ),
              )
            : IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  key.currentState!.openDrawer();
                }),
        elevation: 0,
        title: Row(
          children: [
            /*Visibility(
              child: CustomText(
            text: "Dash",
            color: lightGrey,
            size: 20,
            weight: FontWeight.bold,
          )),*/
            Expanded(child: Container()),
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: dark.withOpacity(0.7),
                ),
                onPressed: () {}),
            Stack(children: [
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: dark.withOpacity(0.7),
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 7,
                top: 7,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: active,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: light,
                      width: 2,
                    ),
                  ),
                ),
              )
            ]),
            Container(width: 1, height: 22, color: lightGrey),
            const SizedBox(
              width: 24,
            ),
            CustomText(
              text: "Santos Enoque",
              color: lightGrey,
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      //final SecurityController controller = Get.find();
                      // controller.logOut();
                    },
                    child: CircleAvatar(
                      backgroundColor: light,
                      child: Icon(
                        Icons.person_outline,
                        color: dark,
                      ),
                    ),
                  )),
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: dark,
        ),
        backgroundColor: Colors.transparent);
