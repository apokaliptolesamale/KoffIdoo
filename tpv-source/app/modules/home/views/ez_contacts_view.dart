import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/utils/size_constraints.dart';
import '../../security/widgets/main_app_bar.dart';

class EzContactsView extends GetView {
  const EzContactsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    return Container(
      color: Colors.white,
      height: size.getHeight,
      child: Column(
        children: [
          MainAppBar(
            size: size,
            widgets: [
              LogoEZ(size: size),
            ],
          ),
          Expanded(
            flex: 5,
            child: Container(),
          )
        ],
      ),
    );
  }
}
