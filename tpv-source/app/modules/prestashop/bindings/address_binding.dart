import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../security/data/providers/token_provider.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../domain/models/address_model.dart';
import '../domain/usecases/add_address_usecase.dart';
import '../domain/usecases/delete_address_usecase.dart';
import '../domain/usecases/get_address_usecase.dart';
import '../domain/usecases/getby_address_usecase.dart';
import '../domain/usecases/update_address_usecase.dart';
import '../domain/usecases/list_address_usecase.dart';
import '../domain/usecases/filter_address_usecase.dart';
import '../address_exporting.dart';
import '../data/providers/address_provider.dart';



class AddressBinding extends Bindings 
{

  AddressBinding() : super() {
    if (!Get.isRegistered<AddressBinding>()) {
      Get.lazyPut<AddressBinding>(
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
    Get.lazyPut<AddressController>(
      () => AddressController(),
    );
    Get.lazyPut<home_app.HomeController>(() => home_app.HomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
     Get.lazyPut<AddressProvider>(
      () => AddressProvider(),
    );
    Get.lazyPut<RemoteAddressDataSourceImpl>(
      () => RemoteAddressDataSourceImpl(),
    );
    Get.lazyPut<LocalAddressDataSourceImpl>(
      () => LocalAddressDataSourceImpl(),
    );
    Get.lazyPut<Repository<AddressModel>>(
      () => AddressRepositoryImpl<AddressModel>(),
    );
    Get.lazyPut<AddressRepository<AddressModel>>(
      () => AddressRepositoryImpl<AddressModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddAddressUseCase<AddressModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteAddressUseCase<AddressModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetAddressUseCase<AddressModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetAddressByFieldUseCase<AddressModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateAddressUseCase<AddressModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListAddressUseCase<AddressModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterAddressUseCase<AddressModel>(Get.find()),
    );
    

  }
  
}
