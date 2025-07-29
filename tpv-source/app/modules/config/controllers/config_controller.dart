import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/secure_getx_controller.dart';
import '../domain/models/nomenclador_model.dart';
import '../domain/usecases/filter_nomenclador_usecase.dart';
import '../domain/usecases/list_nomenclador_usecase.dart';

class ConfigController extends SecureGetxController {
  final ListNomencladorUseCase<NomencladorModel> _nomencladorList =
      Get.isRegistered<ListNomencladorUseCase<NomencladorModel>>()
          ? Get.find()
          : ListNomencladorUseCase<NomencladorModel>(Get.find());

  final FilterNomencladorUseCase<NomencladorList> _nomencladorFilter =
      Get.isRegistered<FilterNomencladorUseCase<NomencladorList>>()
          ? Get.find()
          : FilterNomencladorUseCase<NomencladorList>(Get.find());
  //
  ConfigController() : super();

  FilterNomencladorUseCase<NomencladorList> get getFilterUseCase =>
      _nomencladorFilter;

  ListNomencladorUseCase<NomencladorModel> get getListUseCase =>
      _nomencladorList;

  Future<Either<Failure, EntityModelList<NomencladorList<NomencladorModel>>>>
      filter(String clientId, String name) =>
          getFilterUseCase.setParamsFromMap({
            "name": name,
            "clientId": clientId,
          }).call(null);

  Future<Either<Failure, EntityModelList<NomencladorList<NomencladorModel>>>>
      getComercialUnits(String clientId, String name) async {
    final response = await filter(clientId, name);
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, EntityModelList<NomencladorList<NomencladorModel>>>>
      getDpa(String clientId, String name) async {
    final response = await filter(clientId, name);
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, EntityModelList<NomencladorList<NomencladorModel>>>>
      getNomencladoresByClientId(String clientId) =>
          getFilterUseCase.getNomencladoresByClientId(clientId);
  //
  Future<Either<Failure, EntityModelList<NomencladorList<NomencladorModel>>>>
      getPaymentTypes(String clientId, String name) async {
    final response = await filter(clientId, name);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
