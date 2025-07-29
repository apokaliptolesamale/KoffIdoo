import 'package:dartz/dartz.dart';
import '/app/core/services/logger_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/services/store_service.dart';
import '../../controllers/gift_controller.dart';
import '../../domain/models/gift_model.dart';
import '../../widgets/gift_widgets/gift_listTitle_widget.dart';
import '../../widgets/gift_widgets/load_listGift_widget.dart';

import '/app/modules/transaction/bindings/gift_binding.dart';
import '/app/modules/transaction/views/giftViews/historial_view.dart';
import 'find_account_gift_view.dart';

class GiftView extends GetView<GiftController> {
  const GiftView({Key? key}) : super(key: key);

  Future<Either<Failure, EntityModelList<GiftModel>>> gift() async {
    Map<String, dynamic> params = {
      "offset": 0.toString(),
      "limit": 5.toString(),
    };
    //controller.filterUseGift.setParamsFromMap(params);
    return await controller.filterGifts(params);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var arguments = ModalRoute.of(context)!.settings.arguments;
    Store store = StoreService().getStore("filterGifts");

    if (store.getMapFields.values.toString() != '()' &&
        arguments == 'filterGift') {
      return HistorialGiftView();
    }

    //store.getMapFields.remove(0);
    log(store.getMapFields.values.toString());
    return GetBuilder<GiftController>(
      builder: (_) => Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    Get.to(() => HistorialGiftView(), binding: GiftBinding());
                  },
                  child: Text(
                    'Historial',
                    style: TextStyle(
                        color: Colors.blue.shade200, fontSize: size.width / 20),
                  ))
            ],
            title: Text(
              'Regalos',
              style: TextStyle(fontSize: size.width / 20),
            ),
            leading: IconButton(
                iconSize: size.width / 20,
                splashRadius: 20,
                onPressed: (() => Get.back()),
                icon: const Icon(Icons.arrow_back_ios)),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                      fit: BoxFit.fill)),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height / 80,
              ),
              GiftListTitleWidget(() {
                //Get.toNamed(Routes.FRIENDSVIEW);
              }, 'assets/images/icons/app/enzona/regalo2.png', 'A un amigo'),
              Divider(
                height: 2,
                thickness: 1,
              ),
              GiftListTitleWidget(() {
                Get.to(() =>
                    FindAccountGiftView()); /* showDialog(
                    context: context,
                    builder: (context) {
                      return FindAccountGiftView();
                    }); */
              }, 'assets/images/icons/app/enzona/cuenta.png', 'A un usuario'),
              Divider(
                height: 2,
              ),
              Container(
                // ,
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey,
                          blurStyle: BlurStyle.outer,
                          blurRadius: 5)
                    ],
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5))),
                padding: EdgeInsets.only(bottom: 10, top: 10),

                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Recientes',
                    style: TextStyle(
                        fontSize: size.height / 40, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                  height: size.height / 1.55,
                  child: LoadListGift(futureGift: gift()))
            ],
          )),
    );
  }
}
