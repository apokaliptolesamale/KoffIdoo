// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../../../core/services/logger_service.dart';
import '../../card/controllers/card_controller.dart';
import '../../card/domain/models/card_model.dart';
import '../domain/models/donation_model.dart';
import '../domain/usecases/add_donation_usecase.dart';
import '../domain/usecases/delete_donation_usecase.dart';
import '../domain/usecases/filter_donation_usecase.dart';
import '../domain/usecases/get_donation_usecase.dart';
import '../domain/usecases/getby_donation_usecase.dart';
import '../domain/usecases/list_donation_usecase.dart';

class DonationController extends GetxController {
  AddDonationUseCase<DonationModel> addDonation =
      AddDonationUseCase<DonationModel>(Get.find());
  DeleteDonationUseCase<DonationModel> deleteDonation =
      DeleteDonationUseCase<DonationModel>(Get.find());
  GetDonationUseCase<DonationModel> getDonation =
      GetDonationUseCase<DonationModel>(Get.find());
  GetDonationByFieldUseCase<DonationModel> getDonationByField =
      GetDonationByFieldUseCase<DonationModel>(Get.find());

  ListDonationUseCase<DonationModel> listDonationUseCase =
      ListDonationUseCase<DonationModel>(Get.find());
  FilterDonationUseCase<DonationModel> filterUseDonation =
      FilterDonationUseCase<DonationModel>(Get.find());

  DonationController() : super();

  Future<Either<Failure, EntityModelList<DonationModel>>> getDonations() =>
      listDonationUseCase.call(null);

  Future<Either<Failure, EntityModelList<DonationModel>>> filterDonations() =>
      filterUseDonation.filter();

  Future<Either<Failure, DonationModel>> createDonation(
          AddUseCaseDonationParams model) =>
      addDonation.call(model);

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterDonationUseCase) {
      result = filterDonations().then((value) => Future.value(value as T));
    } else {
      result = getDonations().then((value) => Future.value(value as T));
    }
    return result;
  }

  String fundingSourceUUID = '';
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Either<Failure, EntityModelList<CardModel>>> getCards() async {
    final cardController = Get.find<CardController>();
    final listCard = await cardController.getCards();
    log('Este es el list cardddddddd$listCard');
    return listCard;
  }

  /* getFundingSourceUUid() async {
    if (funding.isNotEmpty) {
      return funding;
    } else {
      late List<CardModel> list;
      var cards = await getCards();
      cards.fold((l) => l, (r) {
        list = r.getList();
      });
      var fundingFirst = list[0].fundingSourceUuid;
      return fundingFirst;
    }
  } */
}
