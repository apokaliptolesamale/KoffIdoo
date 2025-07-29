import 'dart:convert';

import 'package:apk_template/config/config.dart';
import 'package:apk_template/config/network/network_image_ssl.dart';
import 'package:apk_template/features/chinchal/domain/models/operation_model.dart';
import 'package:apk_template/features/chinchal/presentation/providers/merchant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../config/helpers/functions.dart';
import '../../../../home/presentation/providers/home_provider.dart';
import '../../../../shared/qrflutter/qr_flutter.dart';
import '../../../domain/models/refund_model.dart';

class OperationDetailScreen extends ConsumerWidget {
  final OperationMerchantModel? operation;
  final RefundModel? refundModel;
  static const String name = 'operationDetail';
  const OperationDetailScreen({super.key, this.operation, this.refundModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    //final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final numberFormat = NumberFormat.currency(locale: 'en_US', symbol: "\$");
    DateTime? dateOperationParse;
    DateTime? dateRefundParse;
    if (refundModel == null && operation != null) {
      dateOperationParse = DateTime.parse(operation!.createdAt!);
    }
    if (refundModel != null) {
      dateRefundParse = DateTime.parse(refundModel!.createdAt!);
    }
    return PopScope(
      onPopInvoked: (didPop) {
        if (refundModel != null) {
          ref.read(goRouterProvider).pushReplacementNamed('home');
          ref.read(currentIndexProvider.notifier).state = 1;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              if (refundModel != null) {
                Navigator.pop(context);
                //ref.read(goRouterProvider).pushReplacementNamed('home');
                ref.read(currentIndexProvider.notifier).state = 1;
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text(
            'Pago a comercio',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            ref.watch(merchantSelectedProvider)!.role != 'owner'
                ? Container()
                : TextButton(
                    onPressed: () {
                      // TODO: Aquí va la acción de devolver
                      ref.read(goRouterProvider).pushNamed('refund',
                          pathParameters: {
                            'operation': json.encode(operation!.toJson())
                          });
                    },
                    child: Text(
                      'DEVOLVER',
                      style: textTheme.labelLarge,
                    ))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  /* CircleAvatar(
                    radius: height * 0.1,
                    child: Image.asset('assets/images/cuenta.png'),
                  ), */
                  ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: FadeInImage(
                          fit: BoxFit.cover,
                          height: height / 5,
                          placeholder:
                              const AssetImage('assets/images/cuenta.png'),
                          image: NetworkImageSSL(
                              refundModel != null
                                  ? '${Environment.mediaHost}/${refundModel!.refundAvatar!}'
                                  : '${Environment.mediaHost}/${operation!.avatar!}',
                              scale: 1))), //tiene que mandar el verified

                  Text(
                    refundModel == null
                        ? '${operation!.name!} ${operation!.lastname!}'
                        : refundModel!.refundLastname == null
                            ? '${refundModel!.refundName}'
                            : '${refundModel!.refundName} ${refundModel!.refundLastName}',
                    style: TextStyle(fontSize: width * 0.06),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  refundModel == null
                      ? Text(
                          operation!.status!.toUpperCase(),
                          style: TextStyle(
                              fontSize: width * 0.05,
                              color: switchColor(operation!.status!)),
                        )
                      : refundModel!.status == 'Aceptada'
                          ? const Text('Devolución aceptada')
                          : refundModel!.status == 'Fallida'
                              ? const Text('Devolución fallida')
                              : const Text('Devolución pendiente'),
                  Text(
                    refundModel == null
                        ? '${operation!.username}'
                        : refundModel!.refundLastname == null
                            ? '${refundModel!.refundName}'
                            : '${refundModel!.refundName} ${refundModel!.refundLastName}',
                    style: TextStyle(fontSize: width * 0.05),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    refundModel != null
                        ? '-${numberFormat.format(double.parse(refundModel!.amount!['total']))}'
                        : operation!.total!.isEmpty
                            ? ''
                            : '+${numberFormat.format(double.parse(operation!.total!))}',
                    style: textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    refundModel != null
                        ? slashFormatDate(dateRefundParse)
                        : slashFormatDate(dateOperationParse),
                    style:
                        TextStyle(fontSize: width * 0.05, color: Colors.grey),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nro. Operación',
                          style: textTheme.titleMedium,
                        ),
                        Text(
                          operation!.merchantOpId!,
                          //'jh3425jb452er',
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Center(
                          child: Container(
                        alignment: Alignment.center,
                        height: height * 0.3,
                        width: height * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            color: Colors.grey.shade300),
                        child: QrImage(
                          data: refundModel != null
                              ? refundModel!.transactionUuid!
                              : operation!.transactionUuid!,
                          version: QrVersions.auto,
                          size: height * 0.25,
                        ),
                      )
                          /* child: Icon(
                          Icons.qr_code_2,
                          size: height * 0.3,
                        ), */
                          ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color switchColor(String status) {
    switch (status) {
      case 'Aceptada':
        {
          return Colors.green;
        }
      case 'Pendiente':
        {
          return Colors.orange;
        }
      default:
        return Colors.red;
    }
  }
}
