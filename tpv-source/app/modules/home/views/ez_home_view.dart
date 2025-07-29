import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../widgets/bar/customs_button_navigation_bar.dart';
import '../../security/views/ez_profile_view.dart';
import '../bindings/home_binding.dart';

import '../controllers/ez_home_controller.dart';
import 'ez_contacts_view.dart';
import 'ez_dashboard_view.dart';
import 'ez_notifications_view.dart';

class EzHomeView extends GetView<EzHomeController> {
  const EzHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeBinding homeBinding = Get.put(HomeBinding());
    homeBinding.dependencies();
    return Scaffold(body: GetBuilder<EzHomeController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: IndexedStack(
              index: controller.currentindex,
              children: [
                EzDashboardView(),
                EzNotificationsView(),
                EzContactsView(),
                EzProfileView()
              ],
            ),
          ),
        ],
      );
    }), bottomNavigationBar:
        GetBuilder<EzHomeController>(builder: (controller) {
      return CustomButtonNavigationBar(
          index: controller.currentindex,
          onIndexSelected: (index) {
            controller.setCurrentIndex(index);
            // controller.update();
          });
    }));
  }
}
