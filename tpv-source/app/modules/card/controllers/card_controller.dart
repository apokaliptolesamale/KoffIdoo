// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../security/controllers/security_controller.dart';
import '../../security/domain/models/profile_model.dart';
import '../../transaction/controllers/bank_controller.dart';
import '../../transaction/domain/models/bank_model.dart';
import '../domain/models/balance_model.dart';
import '../domain/models/cordenate_model.dart';
import '../domain/models/operation_model.dart';
import '../domain/usecases/filter_operation_use_case.dart';
import '../domain/usecases/get_balance_use_case.dart';
import '../domain/usecases/get_cordenate_use_case.dart';
import '../domain/usecases/get_first_card_use_case.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/card_model.dart';
import '../domain/usecases/add_card_usecase.dart';
import '../domain/usecases/delete_card_usecase.dart';
import '../domain/usecases/filter_card_usecase.dart';
import '../domain/usecases/get_card_usecase.dart';
import '../domain/usecases/getby_card_usecase.dart';
import '../domain/usecases/list_card_usecase.dart';
import '../domain/usecases/set_as_default_usecase.dart';

class CardController extends GetxController {
  AddCardUseCase<CardModel> addCardUseCase =
      AddCardUseCase<CardModel>(Get.find());
  DeleteCardUseCase<CardModel> deleteCard =
      DeleteCardUseCase<CardModel>(Get.find());
  GetCardUseCase<CardModel> getCard = GetCardUseCase<CardModel>(Get.find());
  GetCardByFieldUseCase<CardModel> getCardByField =
      GetCardByFieldUseCase<CardModel>(Get.find());
  ListCardUseCase<CardModel> listCardUseCard =
      ListCardUseCase<CardModel>(Get.find());
  FilterCardUseCase<CardModel> filterUseCard =
      FilterCardUseCase<CardModel>(Get.find());
  GetSetAsDefaultUseCase<CardModel> getSetAsDefaultUseCase =
      GetSetAsDefaultUseCase<CardModel>(Get.find());
  GetCordenateUseCase<CordenateModel> getCordenateUseCase =
      GetCordenateUseCase<CordenateModel>(Get.find());

  GetFirstCardUseCase<CardModel> getFirstCardUseCase =
      GetFirstCardUseCase<CardModel>(Get.find());

  GetBalanceUseCase<BalanceModel> getBalanceUseCase =
      GetBalanceUseCase<BalanceModel>(Get.find());

  FilterOperationUseCase<OperationModel> filterOperationUseCase =
      FilterOperationUseCase<OperationModel>(Get.find());

  CardController() : super();

  Future<Either<Failure, EntityModelList<CardModel>>> filterCards() =>
      filterUseCard.filter();

  Future<Either<Failure, CardModel>> addCard(AddUseCaseCardParams model) {
    /*  var a = addcardModel.pan;
    var en = base64Decode(a);
    var k = String.fromCharCodes(en); */

    /* log('ESte es el cardholder de addcardModel ==> ${addcardModel.cardholder}');
    log('ESte es el expdate de addcardModel ==> ${addcardModel.expdate}');
    log('ESte es el pan de addcardModel ==> ${k}');
    log('ESte es la cadenaEncript de addcardModel ==> ${addcardModel.cadenaEncript}');
    log('ESte es el cm de addcardModel ==> ${addcardModel.cm}'); */
    return addCardUseCase.call(model);
  }

  // Future<Either<Failure, EntityModelList<CardModel>>> getCards() =>
  //     listCardUseCard.getAll();
  Future<Either<Failure, EntityModelList<CardModel>>> getCards() {
    var cards = listCardUseCard.getAll();
    return cards;
  }

  Future<Either<Failure, CardModel>> getFirstCard() {
    return getFirstCardUseCase.call(null);
  }

  Future<Either<Failure, CardModel>> deleteCards(DeleteUseCaseCardParams id) =>
      deleteCard.call(id);

  Future<Either<Failure, CordenateModel>> getCordenate() =>
      getCordenateUseCase.call(null);

  Future<Either<Failure, BalanceModel>> getBalance(String id) =>
      getBalanceUseCase.call(GetBalanceUseCaseCardParams(id: id));

  Future<Either<Failure, EntityModelList<OperationModel>>> getOperations(
          String id) =>
      filterOperationUseCase.call(FilterOperationUseCaseCardParams(idcard: id));

  Future<Either<Failure, CardModel>> asDefaultCard(String fundingSourceUuid) =>
      getSetAsDefaultUseCase
          .call(GetUseCaseSetAsDefaultParams(entity: fundingSourceUuid));

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterCardUseCase) {
      result = filterCards().then((value) => Future.value(value as T));
    } else {
      result = getCards().then((value) => Future.value(value as T));
    }
    return result;
  }

  //////// MEtodos para adicionar tarjeta//////////////////

  final bankController = Get.find<BankController>();

  Future<Either<Failure, EntityModelList<BankModel>>> getBanks() {
    final getBanks = bankController.getBanks();
    return getBanks;
  }

  final securityController = Get.find<SecurityController>();

  Future<ProfileModel> getProfile() async {
    var idToken = await securityController.getIdToken();
    final getprof = securityController.getProfile(idToken!);
    return getprof;
  }

  Future<Either<Failure, CardModel>> getPrimarySource() async {
    final defaultCardModel = CardModel(
        cardUuid: '',
        last4: '',
        cardholder: '',
        expdate: '',
        createdAt: '',
        updatedAt: '',
        status: '',
        currency: '',
        fundingSourceId: '',
        fundingSourceUuid: '',
        primarySource: '',
        bankName: '',
        bankCode: '',
        verified: '',
        bankCertificate: '');
    final listCard = await getCards();
    return listCard.fold((l) => Left(ServerFailure(message: l.toString())),
        (r) {
      final list = r.getList();
      for (var i = 0; i < list.length; i++) {
        if (list[i].primarySource == 'true') {
          final cardPrimarySource = list[i];
          log('Este es el `primarySource==> $cardPrimarySource');
          return Right(cardPrimarySource);
        }
      }
      return Right(defaultCardModel);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    log('Iniciando CardController');
    log('MOstrando respuesta del api...');

    getCards();
    getBanks();
    log('Cargando la primera tarjeta');
    getFirstCard();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
