import 'dart:convert';

import 'package:apk_template/config/config.dart';
import 'package:apk_template/features/chinchal/domain/models/operation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../config/network/network_image_ssl.dart';

class OperationTile extends ConsumerWidget {
  final OperationMerchantModel? operation;
  final String? user;
  final String? status;
  final String? transactionId;
  final String? amount;
  final String? currency;
  final String? urlAvatar;

  const OperationTile(
      {super.key,
      this.operation,
      this.user = '',
      this.status = '',
      this.transactionId = '',
      this.amount = '',
      this.currency = '',
      this.urlAvatar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final numberFormat = NumberFormat.currency(locale: 'en_US', symbol: "\$");
    return GestureDetector(
      child: SizedBox(
        width: width * 0.4,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CircleAvatar(
                radius: 30,
                child: urlAvatar == null
                    ? Image.asset('assets/images/cuenta.png')
                    : FadeInImage(
                        fit: BoxFit.cover,
                        placeholder:
                            const AssetImage('assets/images/cuenta.png'),
                        image: NetworkImageSSL(
                            '${Environment.mediaHost}/${urlAvatar!}'), //NetworkImage(urlAvatar!),
                      ), //Image.asset('assets/images/cuenta.png'),
              ),
            ),
            SizedBox(
              width: width * 0.05,
            ),
            SizedBox(
              width: width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user!,
                    style: textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.noScaling,
                  ),
                  Text(
                    status!.toUpperCase(),
                    style: TextStyle(
                        fontSize: textTheme.titleMedium?.fontSize,
                        color: switchColor(status!, context)),
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.noScaling,
                  ),
                  Text(
                    transactionId!,
                    style: textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.noScaling,
                  ),
                  // Text
                ],
              ),
            ),
            const Spacer(),
            Container(
                alignment: Alignment.centerRight,
                width: width * 0.3,
                child: Column(
                  children: [
                    Text('${amount!}${currency!}',
                        style: textTheme.titleMedium,
                        textScaler: TextScaler.noScaling,
                        overflow: TextOverflow.ellipsis),
                    Text(DateFormat('dd/MM/yyyy')
                            .format(DateTime.parse(operation!.createdAt!))
                        //DateTime.parse(operation!.createdAt!).toString()
                        ),
                    Text(
                      DateFormat('HH:mm:ss a')
                          .format(DateTime.parse(operation!.createdAt!)),
                      style: TextStyle(fontSize: width / 32),
                    )
                  ],
                ))
          ],
        ),
      ),
      onTap: () {
        // context.pushNamed('/operationDetail',pathParameters: );
        ref.read(goRouterProvider).pushNamed('operationDetail',
            pathParameters: {
              'operation': json.encode(operation!.toJson()),
              'refund': null.toString()
            });
      },
    );
  }

  Color? switchColor(String status, BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    switch (status) {
      case 'Aceptada':
        return Colors.green;
      case 'Pendiente':
        return Colors.orange;
      case 'Fallida':
        return Colors.red;
      default:
        return textTheme.titleMedium?.color;
    }
  }
}
