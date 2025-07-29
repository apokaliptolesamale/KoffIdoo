import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '/app/core/helpers/idp.dart';
import '/app/core/helpers/snapshot.dart';
import '/app/modules/security/controllers/security_controller.dart';
import '/app/widgets/panel/custom_empty_data_search.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/utils/loading.dart';
import '../../core/services/store_service.dart';

class EnzonaLoginWidget extends StatelessWidget {
  final SecurityController controller;
  const EnzonaLoginWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller.update,
    );
    final params = Get.parameters;
    final builder = CustomFutureBuilder(
      future: isAuthenticated(),
      builder: getBuilder(),
      context: context,
    );
    return builder;
  }

  AsyncWidgetBuilder<A> getBuilder<A>() {
    builder(BuildContext context, AsyncSnapshot<A> snapshot) {
      if (isWaiting(snapshot)) {
        return EmptyDataSearcherResult(
            child:
                // Loading.fromText(key: key, text: "Autenticando..."),
                Loading(
          text: "Autenticando...",
          backgroundColor: Colors.lightBlue.shade700,
          animationColor:
              AlwaysStoppedAnimation<Color>(Colors.lightBlue.withOpacity(0.8)),
          containerColor: Colors.lightBlueAccent.withOpacity(0.2),
        ));
      } else if (isDone(snapshot)) {
        //Se busca el store del sistema
        final sysStore = StoreService().getStore("system");
        final homePageRoute = sysStore.get("homePageRoute", "/");
        return Routes.getInstance.getByRoute(homePageRoute).page();
      } else if (isError(snapshot)) {}
      return Loading.fromText(key: key, text: "Autenticando...");
      //     Loading(
      //   text: "Autenticando...",
      //   backgroundColor: Colors.lightBlue.shade700,
      //   animationColor:
      //       AlwaysStoppedAnimation<Color>(Colors.lightBlue.withOpacity(0.8)),
      //   containerColor: Colors.lightBlueAccent.withOpacity(0.2),
      // );
    }

    return builder;
  }
}
