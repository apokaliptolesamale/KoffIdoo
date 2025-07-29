// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../../../core/services/logger_service.dart';
import '../../card/controllers/card_controller.dart';
import '../../card/domain/models/card_model.dart';
import '../../security/domain/models/account_model.dart';
import '../../security/domain/usecases/get_account_usecase.dart';
import '../domain/models/cardGift_model.dart';
import '../domain/models/category_model.dart';
import '../domain/models/gift_model.dart';
import '../domain/usecases/add_gift_usecase.dart';
import '../domain/usecases/delete_gift_usecase.dart';
import '../domain/usecases/filter_card_gift_category_use_case.dart';
import '../domain/usecases/filter_gift_usecase.dart';
import '../domain/usecases/get_gift_usecase.dart';
import '../domain/usecases/getby_gift_usecase.dart';
import '../domain/usecases/list_gift_category_usecase.dart';
import '../domain/usecases/list_gift_usecase.dart';

class GiftController extends GetxController {
  AddGiftUseCase<GiftModel> addGift = AddGiftUseCase<GiftModel>(Get.find());
  DeleteGiftUseCase<GiftModel> deleteGift =
      DeleteGiftUseCase<GiftModel>(Get.find());
  GetGiftUseCase<GiftModel> getGift = GetGiftUseCase<GiftModel>(Get.find());
  GetGiftByFieldUseCase<GiftModel> getGiftByField =
      GetGiftByFieldUseCase<GiftModel>(Get.find());

  ListGiftUseCase<GiftModel> listGiftUseGift =
      ListGiftUseCase<GiftModel>(Get.find());
  FilterGiftUseCase<GiftModel> filterUseGift =
      FilterGiftUseCase<GiftModel>(Get.find());

  ListGiftCategoryUseCase<CategoryGiftModel> listCategoryGift =
      ListGiftCategoryUseCase<CategoryGiftModel>(Get.find());

  FilterCardGiftCategoryUseCase<CardGiftModel> filterGiftCategory =
      FilterCardGiftCategoryUseCase<CardGiftModel>(Get.find());

  GetAccountUseCase<AccountModel> getAccount =
      GetAccountUseCase<AccountModel>(Get.find());

  /*  Future<Either<Failure, AccountModel>> getListGiftCategory() async {
    
    var listGiftCategory =
        await _getListGiftUseCase.listGiftCategory(accessToken);
    return listGiftCategory;
  }
 */

  var imageByUser = '';

  GiftController() : super();

  /*Future<Either<Failure, EntityModelList<GiftModel>>> filterGifts(
          Map<String, dynamic> map) =>
      filterUseGift.call(FilterUseCaseGiftParams(mapGift: map));
  Future<Either<Failure, EntityModelList<CardModel>>> getCards() async {
    final cardController = Get.find<CardController>();
    final listCard = await cardController.getCards();
    log('Este es el list cardddddddd$listCard');
    return listCard;
  }*/

  Future<Either<Failure, EntityModelList<CardGiftModel>>> filterCategoryGifts(
          String uuid) =>
      filterGiftCategory.call(FilterUseCaseGiftCategoryParams(uuid: uuid));

  Future<Either<Failure, EntityModelList<GiftModel>>> filterGifts(
          Map<String, dynamic> map) =>
      filterUseGift.call(FilterUseCaseGiftParams(mapGift: map));

  Future<Either<Failure, AccountModel>> findAccount() async {
    var account = await getAccount.call(null);
    return account;
  }

  Future<Either<Failure, AccountModel>> findAccountParam(param) async {
    getAccount.setParamsFromMap({"username": param});
    return getFutureByUseCase(getAccount);
  }

  Future<Either<Failure, AccountModel>> findAccountParam2(
      GetUseCaseAccountParams? params) async {
    return getAccount.call(params);
  }

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;

    result = findAccount().then((value) => Future.value(value as T));

    return result;
  }

  Future<Either<Failure, EntityModelList<GiftModel>>> getGifts() =>
      listGiftUseGift.getAll();

  Future<Either<Failure, EntityModelList<CategoryGiftModel>>>
      getGiftsCategory() => listCategoryGift.call(null);

  Future<Either<Failure, CardModel>> getPrimarySource() async {
    final cardController = Get.find<CardController>();
    final primarySource = await cardController.getPrimarySource();
    log('Este es el primarySource$primarySource');
    return primarySource;
  }

  Future<Either<Failure, CardModel>> getPrimarySourceCard() async {
    final giftController = Get.find<GiftController>();

    final cardPrimarySource = await giftController.getPrimarySource();
    return cardPrimarySource
        .fold((l) => Left(ServerFailure(message: l.toString())), (r) {
      return Right(r);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
