import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/widgets/utils/loading.dart';
import '../../../core/config/errors/errors.dart';
import '../controllers/card_controller.dart';
import '../domain/models/card_model.dart';
import '../domain/usecases/delete_card_usecase.dart';
import 'consultar_saldo.dart';
import 'detalles_card.dart';
import 'last_operations.dart';

class BankCard extends StatelessWidget {
  final CardModel card;
  final int totalListCard;
  BankCard({
    Key? key,
    required this.card,
    required this.totalListCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CardController>();
    final captureArguments = ModalRoute.of(context)!.settings.arguments;
    log(captureArguments.toString());
    Size size = MediaQuery.of(context).size;
    String image = "";
    log(card.bankName);
    switch (card.bankName) {
      case "Banco Popular de Ahorro (BPA)":
        image = "assets/images/backgrounds/enzona/bpa.png";
        break;
      case "Banco Metropolitano S.A":
        image = "assets/images/backgrounds/enzona/banmet.png";
        break;
      case "Banco Internacional de Comercio S.A.(BICSA)":
        image = "assets/images/backgrounds/enzona/bicsa.png";
        break;
      case "Banco de Crédito y Comercio (BANDEC)":
        image = "assets/images/backgrounds/enzona/bandec.png";
        break;
      default:
    }
    return GetBuilder<CardController>(
      builder: (controller) => GestureDetector(
        onTap: () async {
          if (captureArguments.toString() == 'Saldo') {
            await Future.delayed(Duration(milliseconds: 200), () {
              return showDialog(
                  barrierColor: Color.fromARGB(188, 0, 0, 0),
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return ConsultarSaldo(
                      card: card,
                    );
                  });
            });
          } else if (captureArguments.toString() == 'Operaciones') {
            await Future.delayed(Duration(milliseconds: 200), () {
              return showModalBottomSheet(
                  barrierColor: Colors.blue,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                        expand: false,
                        minChildSize: 0.1,
                        maxChildSize: 1,
                        initialChildSize: 0.95,
                        builder: (context, _) {
                          return LastOperations(
                            card: card,
                          );
                        });
                  });
            });
          } else if (captureArguments.toString() != 'Operaciones' &&
              captureArguments.toString() != 'Saldo') {
            await Future.delayed(Duration(milliseconds: 100), () {
              return showDialog(
                  barrierColor: Color.fromARGB(188, 0, 0, 0),
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return DetailsCard(
                      card: card,
                    );
                  });
            });
          }
        },
        child: Container(
          height: size.height / 4,
          decoration:
              BoxDecoration(image: DecorationImage(image: AssetImage(image))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: size.width / 40,
                  bottom: size.height / 7,
                  child: PopupMenuButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 35,
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Text('Consultar saldo'),
                            Expanded(child: Container()),
                            Image.asset(
                              'assets/images/icons/app/enzona/saldo.png',
                              height: size.height * 0.03,
                            ),
                          ],
                        ),
                        onTap: () async {
                          //controller.errorText = '';
                          await Future.delayed(Duration(milliseconds: 200), () {
                            return showDialog(
                                barrierColor: Color.fromARGB(188, 0, 0, 0),
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return ConsultarSaldo(
                                    card: card,
                                  );
                                });
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Text('Últimas operaciones'),
                            Expanded(child: Container()),
                            Image.asset(
                              'assets/images/icons/app/enzona/operaciones.png',
                              height: size.height * 0.03,
                            ),
                          ],
                        ),
                        onTap: () async {
                          //controller.errorText = '';
                          await Future.delayed(Duration(milliseconds: 200), () {
                            return showModalBottomSheet(
                                barrierColor: Colors.blue,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40))),
                                context: context,
                                builder: (context) {
                                  return DraggableScrollableSheet(
                                      expand: false,
                                      minChildSize: 0.1,
                                      maxChildSize: 1,
                                      initialChildSize: 0.95,
                                      builder: (context, _) {
                                        return LastOperations(
                                          card: card,
                                        );
                                      });
                                });
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Text('Predeterminada'),
                            Expanded(child: Container()),
                            Icon(Icons.check),
                          ],
                        ),
                        onTap: () async {
                          log('Este es el primary Source==> ${card.primarySource}');
                          //SetAsDefaultCardModel defaultCardModel;
                          if (card.primarySource == 'false') {
                            return Future.delayed(Duration(milliseconds: 200),
                                () {
                              showDialog(
                                  barrierColor: Color.fromARGB(188, 0, 0, 0),
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Text(
                                          '¿Desea seleccionar esta tarjeta como predeterminada?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return Loading(
                                                      text: "Actualizando...",
                                                      backgroundColor: Colors
                                                          .lightBlue.shade700,
                                                      animationColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.lightBlue
                                                                  .withOpacity(
                                                                      0.8)),
                                                      containerColor: Colors
                                                          .lightBlueAccent
                                                          .withOpacity(0.2),
                                                    );
                                                  });
                                              await controller.asDefaultCard(
                                                  card.fundingSourceUuid);
                                              Navigator.pop(context);

                                              controller.update(['CardView']);
                                            },
                                            child: Text('Sí')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('No'))
                                      ],
                                    );
                                  });
                            });
                          } else {
                            return Future.delayed(Duration(milliseconds: 200),
                                () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Text(
                                          'Esta es su tarjeta predeterminada'),
                                    );
                                  });
                            });
                          }
                        },
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Text('Eliminar'),
                            Expanded(child: Container()),
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            )
                          ],
                        ),
                        onTap: () async {
                          if (card.primarySource == "true" &&
                              totalListCard == 1) {
                            await Future.delayed(Duration(milliseconds: 100),
                                () {
                              return showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Alerta',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(Icons.warning_amber_rounded,
                                              color: Colors.red)
                                        ],
                                      ),
                                      content: Text(
                                          'Usted posee una sola tarjeta, añada una nueva tarjeta después de eliminar esta.'),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'CANCELAR',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5))),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return FutureBuilder(
                                                      future: controller.deleteCard(
                                                          DeleteUseCaseCardParams(
                                                              id: card
                                                                  .fundingSourceUuid)),
                                                      builder: ((context,
                                                          AsyncSnapshot<
                                                                  Either<
                                                                      Failure,
                                                                      CardModel>>
                                                              snapshot) {
                                                        if (!snapshot.hasData) {
                                                          return Loading(
                                                            text:
                                                                "Eliminando Tarjeta...",
                                                            backgroundColor:
                                                                Colors.lightBlue
                                                                    .shade700,
                                                            animationColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors
                                                                        .lightBlue
                                                                        .withOpacity(
                                                                            0.8)),
                                                            containerColor: Colors
                                                                .lightBlueAccent
                                                                .withOpacity(
                                                                    0.2),
                                                          );
                                                        } else {
                                                          late String
                                                              textDelete;
                                                          if (snapshot.data!
                                                              .isRight()) {
                                                            textDelete =
                                                                'Tarjeta eliminada';
                                                          } else {
                                                            textDelete =
                                                                'No se pudo eliminar la tarjeta';
                                                          }
                                                          /* final textAddCard =
                                                              snapshot.data
                                                                  as String; */
                                                          return AlertDialog(
                                                            title: textDelete !=
                                                                    'Tarjeta eliminada'
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Alerta',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                      Icon(
                                                                          Icons
                                                                              .warning_amber_rounded,
                                                                          color:
                                                                              Colors.red)
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            backgroundColor:
                                                                textDelete ==
                                                                        'Tarjeta eliminada'
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .black,
                                                            content: Text(
                                                              textDelete,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        }
                                                      }));
                                                });
                                            controller.update(['CardView']);
                                          },
                                          child: Text(
                                            'ACEPTAR',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue),
                                        ),
                                      ],
                                    );
                                  });
                            });
                          } else if (card.primarySource == "true" &&
                              totalListCard > 1) {
                            await Future.delayed(Duration(milliseconds: 100),
                                () {
                              return showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Alerta',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(Icons.warning_amber_rounded,
                                              color: Colors.red)
                                        ],
                                      ),
                                      content: Text(
                                          'Esta tarjeta es su predeterminada, establezca otra de sus tarjetas como predeterminada para eliminar esta tarjeta'),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK'),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue),
                                        ),
                                      ],
                                    );
                                  });
                            });
                          } else {
                            await Future.delayed(Duration(milliseconds: 100),
                                () {
                              return showDialog(
                                  barrierColor: Color.fromARGB(188, 0, 0, 0),
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content:
                                          Text('¿Desea eliminar esta tarjeta?'),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('CANCELAR')),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return FutureBuilder(
                                                        future: controller.deleteCard(
                                                            DeleteUseCaseCardParams(
                                                                id: card
                                                                    .fundingSourceUuid)),
                                                        builder: ((context,
                                                            AsyncSnapshot<
                                                                    Either<
                                                                        Failure,
                                                                        CardModel>>
                                                                snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Loading(
                                                              text:
                                                                  "Eliminando Tarjeta...",
                                                              backgroundColor:
                                                                  Colors
                                                                      .lightBlue
                                                                      .shade700,
                                                              animationColor: AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors
                                                                      .lightBlue
                                                                      .withOpacity(
                                                                          0.8)),
                                                              containerColor: Colors
                                                                  .lightBlueAccent
                                                                  .withOpacity(
                                                                      0.2),
                                                            );
                                                          } else {
                                                            late String
                                                                textDelete;
                                                            if (snapshot.data!
                                                                .isRight()) {
                                                              textDelete =
                                                                  'Tarjeta eliminada';
                                                            } else {
                                                              textDelete =
                                                                  'No se pudo eliminar la tarjeta';
                                                            }
                                                            /* final textAddCard =
                                                              snapshot.data
                                                                  as String; */
                                                            return AlertDialog(
                                                              title: textDelete !=
                                                                      'Tarjeta eliminada'
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Alerta',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        Icon(
                                                                            Icons
                                                                                .warning_amber_rounded,
                                                                            color:
                                                                                Colors.red)
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              backgroundColor:
                                                                  textDelete ==
                                                                          'Tarjeta eliminada'
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .black,
                                                              content: Text(
                                                                textDelete,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            );
                                                          }
                                                        }));
                                                  });
                                              controller.update(['CardView']);
                                            },
                                            child: Text('ACEPTAR')),
                                      ],
                                    ) /* DetailsCard(
                                    card: card,
                                  ) */
                                        ;
                                  });
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: size.width / 35,
                  bottom: size.height / 35,
                  child: Icon(
                    Icons.check,
                    size: size.width / 10,
                    color: (card.primarySource == 'true')
                        ? Color.fromARGB(255, 40, 73, 40)
                        : Colors.transparent,
                  ),
                ),
                Positioned(
                  left: size.width / 6,
                  top: size.height / 10,
                  child: Text(
                    "**** **** **** ${card.last4}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: size.width / 16),
                  ),
                ),
                Positioned(
                  bottom: size.height / 25,
                  left: size.width / 18,
                  child: Text(
                    card.currency.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: size.width / 28, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  bottom: size.height / 25,
                  left: size.width / 5.5,
                  child: Text(
                    card.cardholder.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: size.width / 28, fontFamily: "Roboto"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
