import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../core/services/store_service.dart';
import '../../../../widgets/utils/loading.dart';
import '../../controllers/gift_controller.dart';
import '../../domain/models/cardGift_model.dart';
import '../../widgets/gift_widgets/carousel_category_widget.dart';

class SelectPostcard extends GetView<GiftController> {
  final String uuid;
  const SelectPostcard(this.uuid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    /*final argumentsCardUuid =
        ModalRoute.of(context)!.settings.arguments as String;*/
    return GetBuilder<GiftController>(
      builder: (controller) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: TextButton(
            style:
                TextButton.styleFrom(elevation: 4, backgroundColor: Colors.red),
            onPressed: () {},
            child: Text(
              'Seleccionar',
              style: TextStyle(color: Colors.amber, fontSize: size.width / 20),
            )),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Colors.black87,
          title: Text('Seleccione la postal'),
        ),
        body: FutureBuilder(
          future: getListCardGift(),
          builder: (BuildContext context,
              AsyncSnapshot<Either<Failure, EntityModelList<CardGiftModel>>>
                  snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            } else {
              return snapshot.data!.fold(
                  (l) => Container(
                        child: Text(l.toString()),
                      ), (r) {
                final List<CardGiftModel> list = r.getList();
                return CarouselCategoryWidget(
                  listCardGiftModel: list,
                );
                /* for (var i = 0; i < list.getTotal; i++) {
                  var cardReference =
                      list.cardGiftList[i].cardReference;

                } */
              });
              /* var listCardGift = snapshot.data as ListGift;
              for (var i = 0; i < listCardGift.listGift.length; i++) {
                /* print(
                    'Este el avatar del account==> ${Constants.mediaHost}${controller.accountModel.avatar}') */
                cardReference = listCardGift.listGift[i].cardReference;
              }
              return Stack(alignment: Alignment.center, children: [
                Container(
                    child: FadeInImage(
                        placeholder: AssetImage('assets/images/postales.png'),
                        image: NetworkImageSSL(
                            '${Constants.mediaHost}$cardReference'))),
                Padding(
                  padding: EdgeInsets.only(top: size.height / 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height / 10,
                        //color: Colors.blue,
                        alignment: Alignment.center,
                        //padding: EdgeInsetsDirectional.only(bottom: size.height / 12),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: Text(
                                'data') /* controller.accountModel != null
                                ? FadeInImage(
                                    width: size.width / 5,
                                    fit: BoxFit.cover,
                                    placeholder: AssetImage(
                                        'assets/images/im_foto_usuario.png'),
                                    image: NetworkImageSSL(
                                        '${Constants.mediaHost}${controller.accountModel.avatar}') /* NetworkImage(
                                          '${Constants.mediaHost}images/user/avatar/ez_56651781.png') */

                                    )
                                : Image(
                                    image: AssetImage(
                                        'assets/images/im_foto_usuario.png'),
                                  ) */
                            ),
                      ),
                      SizedBox(
                        height: size.height / 90,
                      ),
                      Text(
                        '', //controller.entireName,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Text(
                        '', //controller.descriptionController.text,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Text(
                        '',
                        /*  controller.importeController.text.isNotEmpty
                            ? controller.importeController.text +
                                ' ' +
                                controller.currencyPrimarySource
                            : '', */
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ]); */
            }
          },
        ),
      ),
    );
  }

  Future<Either<Failure, EntityModelList<CardGiftModel>>>
      getListCardGift() async {
    var list = await controller.filterCategoryGifts(uuid);
    return list;
  }

  getUUid() {
    Store store = StoreService().getStore("giftCard");
    if (store.hasKey("uuidCardGift")) {
      log(store.getMapFields.entries.toString());
    } else {
      log('Esta vacio');
    }
  }
}
