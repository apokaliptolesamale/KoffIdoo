import 'package:get/get.dart';

import '../../../app/core/interfaces/net_work_info.dart';

class NetworkManagerService {
  static final NetworkManagerService instance =
      !Get.isRegistered() ? NetworkManagerService._internal() : Get.find();

  factory NetworkManagerService() {
    return instance;
  }
  NetworkManagerService._internal() {
    Get.lazyPut<NetworkManagerService>(() => this);
    Get.lazyPut<NetworkBinding>(() => NetworkBinding());
  }

  dependencies() {
    getBinding().dependencies();
  }

  NetworkBinding getBinding() {
    return Get.find<NetworkBinding>();
  }

  Future<bool> hasConnection(String url) =>
      getBinding().networkInfo.hasConnection(url);

  Future<bool> isConnected() => getBinding().networkInfo.isConnected();
}
