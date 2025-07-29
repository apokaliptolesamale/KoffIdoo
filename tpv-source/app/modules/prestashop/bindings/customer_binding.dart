import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../security/data/providers/token_provider.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../domain/models/customer_model.dart';
import '../domain/usecases/add_customer_usecase.dart';
import '../domain/usecases/delete_customer_usecase.dart';
import '../domain/usecases/get_customer_usecase.dart';
import '../domain/usecases/getby_customer_usecase.dart';
import '../domain/usecases/update_customer_usecase.dart';
import '../domain/usecases/list_customer_usecase.dart';
import '../domain/usecases/filter_customer_usecase.dart';
import '../customer_exporting.dart';
import '../data/providers/customer_provider.dart';



class CustomerBinding extends Bindings 
{

  CustomerBinding() : super() {
    if (!Get.isRegistered<CustomerBinding>()) {
      Get.lazyPut<CustomerBinding>(
        () => this,
      );
      dependencies();
    }
  }

  @override
  void dependencies() 
  {
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );   
    Get.lazyPut<CustomerController>(
      () => CustomerController(),
    );
    Get.lazyPut<home_app.HomeController>(() => home_app.HomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
     Get.lazyPut<CustomerProvider>(
      () => CustomerProvider(),
    );
    Get.lazyPut<RemoteCustomerDataSourceImpl>(
      () => RemoteCustomerDataSourceImpl(),
    );
    Get.lazyPut<LocalCustomerDataSourceImpl>(
      () => LocalCustomerDataSourceImpl(),
    );
    Get.lazyPut<Repository<CustomerModel>>(
      () => CustomerRepositoryImpl<CustomerModel>(),
    );
    Get.lazyPut<CustomerRepository<CustomerModel>>(
      () => CustomerRepositoryImpl<CustomerModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddCustomerUseCase<CustomerModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteCustomerUseCase<CustomerModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetCustomerUseCase<CustomerModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetCustomerByFieldUseCase<CustomerModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateCustomerUseCase<CustomerModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListCustomerUseCase<CustomerModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterCustomerUseCase<CustomerModel>(Get.find()),
    );
    

  }
  
}
