import 'package:dartz/dartz.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/interfaces/entity_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../domain/models/card_model.dart';
import '/app/widgets/utils/loading.dart';
import '../controllers/card_controller.dart';
import '../domain/models/cordenate_model.dart';
import 'add_card_button.dart';
//import 'add_card_window.dart';
import 'bank_card.dart';
import '/app/modules/card/views/add_card_view.dart';

class CardList extends GetView<CardController> {
  const CardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CardController>();
    return FutureBuilder(
        future: controller.getCards(),
        builder: (context,
            AsyncSnapshot<Either<Failure, EntityModelList<CardModel>>>
                snapshot) {
          if (!snapshot.hasData) {
            return AddCardButton(press: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return FutureBuilder(
                        future: controller.getCordenate(),
                        builder: ((context,
                            AsyncSnapshot<Either<Failure, CordenateModel>>
                                snapshot) {
                          if (!snapshot.hasData) {
                            return Loading(
                              text: "Cargando...",
                              backgroundColor: Colors.lightBlue.shade700,
                              animationColor: AlwaysStoppedAnimation<Color>(
                                  Colors.lightBlue.withOpacity(0.8)),
                              containerColor:
                                  Colors.lightBlueAccent.withOpacity(0.2),
                            );
                          } else {
                            if (snapshot.data!.isRight()) {
                              return snapshot.data!.fold(
                                (l) {
                                  return AlertDialog(
                                    content: Text(l.toString()),
                                  );
                                },
                                (cordenateModel) {
                                  return AddCardView(
                                      cordenate:
                                          cordenateModel); /* AddCardWindow(
                                      cordenate: cordenateModel); */
                                },
                              );
                            }
                          }
                          return Container();
                        }));
                  });
            }) //const Loading(txt: "Cargando tarjetas... ")
                ;
          } else {
            Widget cargarData() {
              late int total = 0;
              List<CardModel> list = [];
              if (snapshot.data!.isRight()) {
                return snapshot.data!.fold((l) {
                  l.toString();
                  return AlertDialog();
                }, (r) {
                  total = r.getTotal;
                  list = r.getList();
                  return ListView.builder(
                    itemCount: total,
                    padding: const EdgeInsets.all(5.0),
                    itemBuilder: (context, index) {
                      return BankCard(
                        card: list[index],
                        totalListCard: total,
                      );
                    },
                  );
                });
              } else {
                return AlertDialog();
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AddCardButton(press: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return FutureBuilder(
                            future: controller.getCordenate(),
                            builder: ((context,
                                AsyncSnapshot<Either<Failure, CordenateModel>>
                                    snapshot) {
                              if (!snapshot.hasData) {
                                return Loading(
                                  text: "Cargando...",
                                  backgroundColor: Colors.lightBlue.shade700,
                                  animationColor: AlwaysStoppedAnimation<Color>(
                                      Colors.lightBlue.withOpacity(0.8)),
                                  containerColor:
                                      Colors.lightBlueAccent.withOpacity(0.2),
                                );
                              } else {
                                if (snapshot.data!.isRight()) {
                                  return snapshot.data!.fold(
                                    (l) {
                                      return AlertDialog(
                                        content: Text(l.toString()),
                                      );
                                    },
                                    (cordenateModel) {
                                      log('Coordenadas => ${cordenateModel.c1 + cordenateModel.c2 + cordenateModel.p1 + cordenateModel.p2} ');
                                      return AddCardView(
                                          cordenate: cordenateModel);
                                    },
                                  );
                                }
                              }
                              return Container();
                            }));
                      });

                  /* showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return FutureBuilder(
                            future: controller.getCordenate(),
                            builder: ((context, snapshot) {
                              if (!snapshot.hasData) {
                                return Loading(
                                  text: "Cargando...",
                                  style: TextStyle(color: Colors.white),
                                );
                              } else {
                                return AddCardWindow(
                                    cordenate: snapshot.data as CordenateModel);
                              }
                            }));
                      }); */
                }),
                Expanded(
                  child: cargarData(),
                )
              ],
            );

            //var listCard = snapshots.data as ListCard;
          }
        });
  }
}
