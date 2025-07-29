// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/services/store_service.dart';
import '../../../card/controllers/card_controller.dart';
import '../../../card/domain/models/card_model.dart';
import '../../controllers/donation_controller.dart';
import '../../domain/models/donation_model.dart';
import '../../widgets/donation_widgets/accept_button_donation.dart';
import '../../widgets/donation_widgets/carousel_widget.dart';
import '../../widgets/donation_widgets/importe_widget.dart';
import '../../widgets/donation_widgets/select_card_widget.dart';

class DonarView extends GetResponsiveView<DonationController> {
  String fundingSourceUUID = '';
  DonarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argumentsDonation =
        ModalRoute.of(context)!.settings.arguments as DonationModel;
    CardController cardController = Get.find<CardController>();
    GlobalKey<FormState> formKeyImporte = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    /*TextStyle styleSelect =
        TextStyle(color: Color.fromARGB(255, 129, 129, 129));*/
    final donationCtr = argumentsDonation;
    TextEditingController importe = TextEditingController();
    //String fundingSourceUUID = '';
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
          leading: IconButton(
              iconSize: size.width / 20,
              splashRadius: 25,
              onPressed: () {
                final storeDonation = StoreService().getStore("donation");
                storeDonation.remove('fundingSourceUuid');
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          automaticallyImplyLeading: false,
          leadingWidth: size.width / 20,
          title: Text(
            argumentsDonation.title.toString(),
            style: TextStyle(fontSize: size.width / 25),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CarouselWidget(donationModel: argumentsDonation),
                SizedBox(
                  height: size.height / 40,
                ),
                ImporteWidget(
                  formKeyImporte: formKeyImporte,
                  controllerImp: importe,
                ),
                /* SizedBox(
                  height: size.height / 80,
                ), */
                FutureBuilder(
                    future: cardController.getCards(),
                    builder: (context,
                        AsyncSnapshot<
                                Either<Failure, EntityModelList<CardModel>>>
                            snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(); //Loading(containerColor: Colors.transparent,);
                      } else {
                        List<CardModel> list = [];
                        snapshot.data!.fold((l) => l.toString(), (r) {
                          list = r.getList();
                        });
                        //var cardList = snapshot.data ;
                        /* fundingSourceUUID = SelectCardWidget(
                          listCard: list,
                        ).funding;
                        log('Este es el fondunfinUUid del selectCard==> ${fundingSourceUUID}'); */

                        if (list.isEmpty) {
                          return Container(
                            child: Center(
                              child: Text('No tiene tarjetas asociadas'),
                            ),
                          );
                        }

                        return SelectCardWidget(
                          listCard: list,
                        );
                      }
                    }),
                SizedBox(
                  height: size.height / 40,
                ),
                GetBuilder<DonationController>(
                    id: 'Button',
                    builder: (controller) {
                      return ButtonAccept(
                        formKeyImporte: formKeyImporte,
                        fundingSourceUuid: fundingSourceUUID,
                        donationCtr: donationCtr,
                        importe: importe,
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
