import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../app/modules/transaction/widgets/gift_widgets/transfer_gift_widget.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../widgets/utils/loading.dart';
import '../../controllers/gift_controller.dart';
import '../../domain/models/gift_model.dart';

class LoadListGift extends StatelessWidget {
  final Future<Either<Failure, EntityModelList<GiftModel>>> futureGift;
  const LoadListGift({key, required this.futureGift});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftController>(
      id: 'loadListGift',
      builder: (_) => FutureBuilder(
          future: futureGift,
          builder: ((context,
              AsyncSnapshot<Either<Failure, EntityModelList<GiftModel>>>
                  snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            } else {
              if (snapshot.data!.isRight()) {
                return snapshot.data!.fold(
                    (l) => AlertDialog(
                          title: Text(l.toString()),
                        ), (r) {
                  GiftList list = r as GiftList;
                  late GiftModel gift;

                  return ListView.builder(
                      itemCount: list.gifts.length,
                      itemBuilder: (context, index) {
                        //var imageByUser = '';
                        late String fundingRecipient;
                        for (var i = 0; i < list.gifts.length; i++) {
                          gift = list.gifts[index];

                          fundingRecipient = gift.recipient.username;
                        }
                        if (list.avatars.isNotEmpty) {
                          if (list.avatars.containsKey(fundingRecipient)) {
                            var image = list.avatars;
                            List<dynamic> sss = image.values.toList();
                            for (var i = 0; i < sss.length; i++) {
                              _.imageByUser = sss[i];

                              if (sss[i]
                                  .toString()
                                  .contains(fundingRecipient)) {
                                print(
                                    'Este es la imagen por username==>${_.imageByUser}');
                              } else {}
                            }

                            print(
                                'Este es la lista de imagenes por username==> $sss');
                          } else {}
                        }
                        /*  for (var i = 0; i < listGift.avatars.length; i++) {

                      avatar = listGift.avatars[index];
                    } */

                        return GestureDetector(
                            onTap: () {
                              //Get.toNamed(Routes.DETAILSGIFTVIEW);
                            },
                            child: TransferGiftWidget(
                              gift,
                              imageByUser: _.imageByUser,
                            ));
                      });
                });
              }
              return Container();
              //ListGift listGift = snapshot.data as ListGift;
            }
          })),
    );
  }
}
