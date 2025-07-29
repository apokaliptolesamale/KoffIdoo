import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../security/data/providers/token_provider.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../domain/models/payment_model.dart';
import '../domain/usecases/add_payment_usecase.dart';
import '../domain/usecases/delete_payment_usecase.dart';
import '../domain/usecases/get_payment_usecase.dart';
import '../domain/usecases/getby_payment_usecase.dart';
import '../domain/usecases/update_payment_usecase.dart';
import '../domain/usecases/list_payment_usecase.dart';
import '../domain/usecases/filter_payment_usecase.dart';
import '../payment_exporting.dart';
import '../data/providers/payment_provider.dart';



class PaymentBinding extends Bindings 
{

  PaymentBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    dependencies();
  }

  @override
  void dependencies() 
  {
    Get.lazyPut<PaymentBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );   
    Get.lazyPut<PaymentController>(
      () => PaymentController(),
    );
    Get.lazyPut<home_app.HomeController>(() => home_app.HomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
     Get.lazyPut<PaymentProvider>(
      () => PaymentProvider(),
    );
    Get.lazyPut<RemotePaymentDataSourceImpl>(
      () => RemotePaymentDataSourceImpl(),
    );
    Get.lazyPut<LocalPaymentDataSourceImpl>(
      () => LocalPaymentDataSourceImpl(),
    );
    Get.lazyPut<Repository<PaymentModel>>(
      () => PaymentRepositoryImpl<PaymentModel>(),
    );
    Get.lazyPut<PaymentRepository<PaymentModel>>(
      () => PaymentRepositoryImpl<PaymentModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddPaymentUseCase<PaymentModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeletePaymentUseCase<PaymentModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetPaymentUseCase<PaymentModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetPaymentByFieldUseCase<PaymentModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdatePaymentUseCase<PaymentModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListPaymentUseCase<PaymentModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterPaymentUseCase<PaymentModel>(Get.find()),
    );
    

  }
  
}
