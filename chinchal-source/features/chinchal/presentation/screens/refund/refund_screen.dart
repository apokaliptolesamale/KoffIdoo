import 'dart:convert';
import 'dart:developer'as log;
import 'dart:math';

import 'package:apk_template/features/chinchal/presentation/providers/merchant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../config/router/app_router.dart';
import '../../../domain/models/operation_model.dart';
import '../../../domain/models/refund_model.dart';

class RefundScreen extends ConsumerStatefulWidget {
  static const String name='refund';
  final OperationMerchantModel? operationModel;
  //final MerchantModel? merchantModel;
  const RefundScreen(
      {this.operationModel ,super.key});

  @override
  RefundViewState createState() => RefundViewState();
}

class RefundViewState extends ConsumerState<RefundScreen> {
  
  
  /* createRefund(AddRefundModel model, String transactionUUID) async {
    
    createRefund.fold((l) {
      if(l.message=='Runtime error'|| l.message=='Desconocido'){
                    Get.dialog(ElasticIn(
                      child: CustomAlertDialog().simpleAlertMessages('El tiempo ha expirado, por favor realice la operación nuevamente', () {
                              Get.back();
                            }, false, Get.context),
                    ));
                  }else{Get.dialog(ElasticIn(
                    child: CustomAlertDialog().simpleAlertMessages(l.message, () {
                            Get.back();
                          }, false, Get.context),
                  ));}
      Get.back();
      
    }, (refund) {
      Get.back();
      Get.to(() => PaymentDetailView(
            //operation: operation,
            refundModel: refund,
            merchant: widget.merchantModel,
          ));
    });
    } */
  TextEditingController textController = TextEditingController();
  GlobalKey<FormState> formKeyImporte = GlobalKey<FormState>();
  String errorText = '';
  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(locale: 'en_US', symbol: "\$");
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:  const Text('Devolucion',style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(radius: height * 0.1,)
            ),
            Text(
              'Nombre y apellidos}',
              style: textTheme.headlineSmall,
              overflow: TextOverflow.ellipsis,
              textScaler: TextScaler.noScaling,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              'Usuario',
              style: TextStyle(
                  fontSize: textTheme.headlineSmall!.fontSize,
                  color: Colors.grey),
              overflow: TextOverflow.ellipsis,
              textScaler: TextScaler.noScaling,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              'ID: id de operación',
              style: textTheme.titleLarge,
              overflow: TextOverflow.ellipsis,
              textScaler: TextScaler.noScaling,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              'Introduce el monto a devolver',
              style: TextStyle(
                  fontSize: textTheme.headlineSmall!.fontSize,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              textScaler: TextScaler.noScaling,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Form(
              key: formKeyImporte,
              child: TextFormField(
                controller: textController,
                inputFormatters: const [
                  // ImporteInputFormatter(),
                ],
                decoration: InputDecoration(
                    error: errorText == ''
                        ? null
                        : Center(
                            child: Text(
                            errorText,
                            style: const TextStyle(color: Colors.red),
                          )),
                    // hintText: numberFormat
                    //     .format(double.parse(widget.operationModel.total!)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.04)),
                    constraints: BoxConstraints(maxWidth: width * 0.6)),
                validator: (value) {
                  if (value == null || value == "") {
                    setState(() {
                      errorText = "Campo requerido";
                    });
                    return errorText;
                  }
                  if (value.trim() == '\$0.00') {
                    setState(() {
                      errorText = "Introduzca un monto válido";
                    });
                    return errorText;
                  }

                  return null;
                },
              ),
            ),

            SizedBox(
              height: height * 0.02,
            ),
            const Text.rich(TextSpan(children: [
              TextSpan(text: 'El monto debe ser inferior o igual a '),
              TextSpan(
                  text: 'Monto total de devolución',
                  style: TextStyle(fontWeight: FontWeight.bold))
            ])),
            //Text('El monto debe ser inferior o igual a ${numberFormat.format(double.parse(operationModel.total!))}'),
            SizedBox(
              height: height * 0.1,
            ),

            SizedBox(
                width: double.infinity,
                height: height * 0.06,
                child: FilledButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.04))),
                    backgroundColor: const WidgetStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () async {
                    if (formKeyImporte.currentState!.validate()) {
                      log.log('Este es el AddRefundModel que se enviará==> {total:${textController.text},username:${widget.operationModel!.username!}}');
                      AddRefundModel addRefundmodel = AddRefundModel(
                          amount: {'total': textController.text.replaceAll('\$', '').trim()},
                          commerceRefundId: generateRandomString(),
                          username: widget.operationModel!.username!,
                          description: widget.operationModel!.description!);
                      log.log('Este es el String generado==> ${generateRandomString()}');

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      Map<String,dynamic> mapToAddRefund= {
                        'addRefundModel': addRefundmodel,
                        'transactionUuid':widget.operationModel!.transactionUuid!
                      };
                     final refund =await ref.read(addRefundProvider(mapToAddRefund).future);
                     if(refund!=null){
                      ref.read(goRouterProvider).pushNamed('operationDetail',pathParameters: {
                        'refund':json.encode(refund.toJson()),
                        'operation':json.encode(widget.operationModel!.toJson())
                      });
                     }
                     /*  await createRefund(
                          model, widget.operationModel!.transactionUuid!); */
                    } else {
                      formKeyImporte.currentState!.reset();
                    }
                  },
                  child: Text(
                    'DEVOLVER',
                    style: TextStyle(fontSize: height * 0.03),
                  ),
                ))
          ]),
        ),
      ),
    );
  }

  String generateRandomString() {
    final random = Random();
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const length = 12;

    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
  }
}
