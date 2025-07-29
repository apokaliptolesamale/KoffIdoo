import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/core/config/app_config.dart';
import 'app/core/services/local_storage.dart';
import 'app/core/services/logger_service.dart';
import 'app/widgets/app/tpv_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalSecureStorage.storage.configureStorage();
  await ConfigApp.getInstance.onInit();
  log("Starting TpvApp....");
  //await NotificationConfig.getInstance.init(true);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((_) {
    runApp(TpvApp());
  });
}
