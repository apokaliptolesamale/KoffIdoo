import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/services/logger_service.dart';
import '/app/widgets/utils/loading.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../controllers/card_controller.dart';
import '../domain/models/card_model.dart';
import '../domain/models/operation_model.dart';
// ignore: library_prefixes

class LastOperations extends StatelessWidget {
  final CardModel card;

  LastOperations({
    Key? key,
    required this.card,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CardController controller = Get.find();
    return FutureBuilder(
        future: controller.getOperations(card.fundingSourceUuid),
        builder: ((context,
            AsyncSnapshot<Either<Failure, EntityModelList<OperationModel>>>
                snapshot) {
          if (!snapshot.hasData) {
            return Loading(
              text: "Cargando Operaciones...",
              backgroundColor: Colors.lightBlue.shade700,
              animationColor: AlwaysStoppedAnimation<Color>(
                  Colors.lightBlue.withOpacity(0.8)),
              containerColor: Colors.lightBlueAccent.withOpacity(0.2),
            );
          } else {
            //int total = 0;
            List<OperationModel> list = [];
            if (snapshot.data!.isRight()) {
              return snapshot.data!.fold((l) {
                l.toString();
                return AlertDialog(
                  title: Text(l.toString()),
                );
              }, (r) {
                //int total = r.getTotal;
                list = r.getList();
                log('Esta es la lista que viene del provider==> $list');
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cerrar')),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'Operación',
                              style: TextStyle(
                                  fontSize: size.height / 30,
                                  color: Colors.grey),
                            ),
                            Expanded(child: Container()),
                            Text('Fecha',
                                style: TextStyle(
                                    fontSize: size.height / 30,
                                    color: Colors.grey)),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white38,
                        margin: EdgeInsets.only(bottom: size.height / 70),
                        height: size.height / 1.4,
                        child: ListView.builder(
                            padding: EdgeInsets.only(top: size.height / 40),
                            itemCount: list.length,
                            itemBuilder: ((context, index) {
                              debitoDefine(list[index]);
                              return Column(
                                children: [
                                  ListTile(
                                    title:
                                        Text(_descriptionDefine(list[index])),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          debitoDefine(list[index]) +
                                              list[index].amount +
                                              ' ' +
                                              card.currency,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        debitoDefine(list[index]) == '-'
                                            ? Text('Débito')
                                            : Text('Crédito'),
                                      ],
                                    ),
                                    trailing: Text(list[index].operationDate),
                                    leading: _loadImage(list[index]),
                                  ),
                                  Divider(
                                    color: Colors.black26,
                                  ),
                                ],
                              );
                            })),
                      ),
                      //Icon(Icons.delete)
                    ],
                  ),
                );
              });
            } else {
              return Container(
                child: Center(child: Text('No hay Operaciones')),
              );
            }

            //var operation = snapshot.data as OperationList;
          }
          //return AlertDialog();
        }));
  }

  debitoDefine(OperationModel operation) {
    String db = operation.action;
    if (db == 'DB') {
      return '-';
    } else {
      return '+';
    }
  }

  String _descriptionDefine(OperationModel operation) {
    String description = operation.description;
    String channel = operation.channel;
    String codigo = operation.codigo;
    String action = operation.action;
    String alias = operation.alias;
    if (description.isNotEmpty) {
      if (description == 'TRF' || description == 'TRAN') {
        return 'Transferencia';
      } else if (channel == 'ENZ' && description.contains('TR EZ')) {
        return 'Activación de Tarjeta';
      } else if (description.contains('CEL C') && !_isPayEtecsa(description)) {
        if (alias != '') {
          return alias;
        } else {
          return 'Pago a comercio';
        }
      } else if (description == 'CAD') {
        switch (channel) {
          case 'POS':
            'Compra en POS';
            break;
          case 'REV':
            'Devolución con cambio de CADECA';
            break;
          case 'ENZ':
            'Transferencia con cambio de CADECA';
            break;

          default:
            'Extracción con cambio de CADECA';
        }
      } else if (description == 'GAS') {
        return 'Pago al servicio de Gas';
      } else if (description.contains('ONAT') || description.contains('IMP')) {
        return 'Pago de impuesto';
      } else if (description.contains('TEL')) {
        return 'Pago de servicio a ETECSA';
      } else if (description.contains('MREC') || description.contains('MRG')) {
        return 'Micro Recarga Móvil';
      } else if (description.contains('RECA') ||
          description.contains('RMV') ||
          description == 'MOVI') {
        return 'Recarga Móvil';
      } else if (description.contains('NAU') || description.contains('RNT')) {
        return 'Recarga Nauta';
      } else if (description.contains('PCU') ||
          description.contains('RPP') ||
          description.contains('PROP')) {
        return 'Recarga Propia';
      } else if (description.contains('LUZ') || (codigo == 'ELE')) {
        return 'Pago al servicio de Electricidad';
      } else if (description.contains('AGU')) {
        return 'Pago al servicio de Agua';
      } else if (description.contains('MULT')) {
        return 'Pago de Multa';
      } else if (description == 'CIMX') {
        return 'Pago en CIMEX';
      } else if (description.contains('Hist')) {
        return 'Aporte al Patrimonio';
      } else if (description.contains('PLI')) {
        return 'Pago en línea';
      } else if (description.contains('CADT')) {
        return 'Transferencia con cambio de CADECA';
      } else if (action == 'DB') {
        return 'Extracción';
      } else {
        return 'Crédito';
      }
    } else {
      if (channel == 'REV') {
        return 'Reverso';
      } else if (channel == 'EV' && action == 'CR') {
        return 'Nómina';
      } else if (action == 'DB' && channel == 'POS') {
        return 'Pago en POS';
      } else {
        if (action == 'DB') {
          return 'Extracción';
        } else {
          return 'Crédito';
        }
      }
    }
    return '';
  }

  _isPayEtecsa(String description) {
    return description.contains("TEL") ||
        description.contains("MREC") ||
        description.contains("MRG") ||
        description.contains("RECA") ||
        description.contains("RMV") ||
        description == "MOVI" ||
        description.contains("NAU") ||
        description.contains("RNT") ||
        description.contains("PCU") ||
        description.contains("RPP") ||
        description.contains("PROP");
  }

  dynamic _loadImage(OperationModel operation) {
    String result = _descriptionDefine(operation);

    String channel = operation.channel;
    String action = operation.action;
    switch (result) {
      case 'Transferencia':
        //Image.asset('');
        if (channel == 'ENZ') {
          return Image.asset('assets/images/backgrounds/enzona/ez.png');
        } else {
          return Image.asset(
              'assets/images/backgrounds/enzona/ic_tranferencia.png');
        }

      case 'Activación de Tarjeta':
        return Image.asset('assets/images/backgrounds/enzona/ez.png');

      case 'Compra en POS':
        return Image.asset('assets/images/backgrounds/enzona/ic_pos.png');

      case 'Devolución con cambio de CADECA':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_tranferencia.png');

      case 'Transferencia con cambio de CADECA':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_tranferencia.png');

      case 'Extracción con cambio de CADECA':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_tranferencia.png');

      case 'Pago al servicio de Gas':
        return Image.asset('assets/images/backgrounds/enzona/ic_pago_gas.png');

      case 'Pago de impuesto':
        return Image.asset('assets/images/backgrounds/enzona/onat.png');

      case 'Pago de servicio a ETECSA':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_pago_telefono.png');

      case 'Micro Recarga Móvil':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_pago_telefono.png');

      case 'Recarga Móvil':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_pago_telefono.png');

      case 'Recarga Nauta':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_pago_telefono.png');

      case 'Recarga Propia':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_extraccion.png');

      case 'Pago al servicio de Electricidad':
        return Image.asset('assets/images/backgrounds/enzona/ez.png');

      case 'Pago al servicio de Agua':
        return Image.asset('assets/images/backgrounds/enzona/ic_pago_agua.png');

      case 'Pago de Multa':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_extraccion.png');

      case 'Pago en CIMEX':
        return Image.asset('assets/images/backgrounds/enzona/ic_pos.png');

      case 'Aporte al Patrimonio':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_extraccion.png');

      case 'Pago en línea':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_pago_telefono.png');

      case 'Reverso':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_tranferencia.png');

      case 'Nómina':
        if (action == 'DB') {
          return Image.asset('assets/images/backgrounds/enzona/ic_nomina.png');
        } else {
          return Image.asset(
              'assets/images/backgrounds/enzona/ic_nomina_verde.png');
        }
      case 'Pago en POS':
        return Image.asset('assets/images/backgrounds/enzona/ic_pos.png');
      case 'Crédito':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_nomina_verde.png');
      case 'Pago a comercio':
        return Image.asset('assets/images/backgrounds/enzona/fotocomercio.png');
      case 'Extracción':
        return Image.asset(
            'assets/images/backgrounds/enzona/ic_extraccion.png');
    }
  }
}
