import 'package:dartz/dartz.dart';
import '/app/core/services/logger_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/services/store_service.dart';
import '../../controllers/gift_controller.dart';
import '../../domain/models/gift_model.dart';
import '../../widgets/gift_widgets/filter_gift_widget.dart';
import '../../widgets/gift_widgets/load_listGift_widget.dart';
import 'gift_view.dart';

class HistorialGiftView extends GetView<GiftController> {
  const HistorialGiftView({Key? key}) : super(key: key);

  Future<Either<Failure, EntityModelList<GiftModel>>> giftHistory() async {
    Store store = StoreService().getStore("filterGifts");
    log(store.getMapFields.values.toString());
    if (store.getMapFields.keys.toString() != '' &&
        store.getMapFields.values.toString() != '()' &&
        store.getMapFields.keys.first.toString() == "startDate" &&
        store.getMapFields.keys.last.toString() == "endDate") {
      print(
        store.getMapFields.entries.first.value.toString(),
      );
      print(
        store.getMapFields.entries.last.value.toString(),
      );
      Map<String, dynamic> params = {
        "offset": 0.toString(),
        "limit": 20.toString(),
        "start_date": store.getMapFields.entries.first.value.toString(),
        "end_date": store.getMapFields.entries.last.value.toString(),
        //"status_code": store.getMapFields.values.toString()
      };
      return await controller.filterGifts(params);
    } else if (store.getMapFields.values.toString() != '()') {
      Map<String, dynamic> params = {
        "offset": 0.toString(),
        "limit": 20.toString(),
        "status_code": store.getMapFields.values.toString()
      };
      return await controller.filterGifts(params);
    } else {
      Map<String, dynamic> params = {
        "offset": 0.toString(),
        "limit": 20.toString(),
      };
      //controller.filterUseGift.setParamsFromMap(params);
      return await controller.filterGifts(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    /* Store store = StoreService().getStore("filterGifts");
    var storeValue = store.getMapFields.values.toString(); */
    Size size = MediaQuery.of(context).size;
    return GetBuilder<GiftController>(
      id: 'historial',
      builder: (_) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return FilterGiftWidget();
                });
          },
          child: const Icon(Icons.filter_alt_outlined),
        ),
        appBar: AppBar(
          title: Text(
            'Historial',
            style: TextStyle(fontSize: size.width / 20),
          ),
          leading: IconButton(
              iconSize: size.width / 20,
              splashRadius: 20,
              onPressed: (() {
                Store store = StoreService().getStore("filterGifts");
                if (store.getMapFields.values.toString() == '()') {
                  Get.off(() => GiftView());
                } else {
                  store.getMapFields.remove("giftStatus");
                  store.getMapFields.remove("startDate");
                  store.getMapFields.remove("endDate");
                  log(store.getMapFields.values.toString());
                  Get.back();
                  //Get.off(() => GiftView());
                  //Get.toNamed('/ezhome');
                }
              }),
              icon: const Icon(Icons.arrow_back_ios)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 10),
            child: LoadListGift(futureGift: giftHistory())),
      ),
    );
  }
}
