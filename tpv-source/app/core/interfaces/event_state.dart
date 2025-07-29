import 'package:flutter/material.dart';

import '../services/logger_service.dart';

abstract class EventStateNotifier<T extends StatefulWidget>
    extends ChangeNotifier implements State<T> {
  @override
  bool get hasListeners {
    return super.hasListeners == true;
  }

  @override
  void addListener(void Function() listener) {
    super.addListener(listener);
    log("Supper has called");
  }

  @override
  void dispose() {
    super.dispose();
    log("Supper has called");
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
    log("Supper has called");
  }

  @override
  void removeListener(void Function() listener) {
    super.removeListener(listener);
    log("Supper has called");
  }
}
