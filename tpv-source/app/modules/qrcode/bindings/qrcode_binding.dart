import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '/app/modules/qrcode/views/pages/qr_info_order_page.dart';
import '/app/modules/qrcode/views/pages/qr_scan_page.dart';
import '/app/routes/app_pages.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../data/providers/qrcode_provider.dart';
import '../domain/models/qrcode_model.dart';
import '../domain/usecases/add_qrcode_usecase.dart';
import '../domain/usecases/delete_qrcode_usecase.dart';
import '../domain/usecases/filter_qrcode_usecase.dart';
import '../domain/usecases/get_qrcode_usecase.dart';
import '../domain/usecases/getby_qrcode_usecase.dart';
import '../domain/usecases/list_qrcode_usecase.dart';
import '../domain/usecases/update_qrcode_usecase.dart';
import '../qrcode_exporting.dart';

class QrCodeBinding extends Bindings {
  QrCodeBinding() : super() {
    if (!Get.isRegistered<QrCodeBinding>()) {
      Get.lazyPut<QrCodeBinding>(
        () => this,
      );
      loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<QrCodeController>(
      () => QrCodeController(),
    );
    Get.lazyPut<home_app.HomeController>(
      () => home_app.HomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
    Get.lazyPut<QrCodeProvider>(
      () => QrCodeProvider(),
    );
    Get.lazyPut<RemoteQrCodeDataSourceImpl>(
      () => RemoteQrCodeDataSourceImpl(),
    );
    Get.lazyPut<LocalQrCodeDataSourceImpl>(
      () => LocalQrCodeDataSourceImpl(),
    );
    Get.lazyPut<Repository<QrCodeModel>>(
      () => QrCodeRepositoryImpl<QrCodeModel>(),
    );
    Get.lazyPut<QrCodeRepository<QrCodeModel>>(
      () => QrCodeRepositoryImpl<QrCodeModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddQrCodeUseCase<QrCodeModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteQrCodeUseCase<QrCodeModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetQrCodeUseCase<QrCodeModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetQrCodeByFieldUseCase<QrCodeModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateQrCodeUseCase<QrCodeModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListQrCodeUseCase<QrCodeModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterQrCodeUseCase<QrCodeModel>(Get.find()),
    );
  }

  loadPages() {
    AppPages.addAllRouteIfAbsent([
      QrInfoOrderPageImpl.builder(),
      QrScanPageImpl.builder(),
    ]);
  }
}
