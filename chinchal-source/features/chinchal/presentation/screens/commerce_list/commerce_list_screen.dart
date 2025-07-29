import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:apk_template/features/chinchal/presentation/screens/generic/generic_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../account/data/models/account_model.dart';
import '../../providers/merchant_provider.dart';
import '../../providers/ntfy_provider.dart';

class CommerceListScreen extends ConsumerStatefulWidget {
  final AccountModel account;
  const CommerceListScreen({super.key, required this.account});

  @override
  CommerceListScreenState createState() => CommerceListScreenState();
}

class CommerceListScreenState extends ConsumerState<CommerceListScreen> {
  //ListMerchantModel listMerchants = ListMerchantModel(content: []);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final merchantSelected = ref.read(merchantSelectedProvider);

    final listMerchants =
        ref.watch(filterMerchantProvider.call(widget.account));
    return listMerchants.when(
        data: (merchants) {
          log('Merchants en CommerceListScreen==> ${merchants!.content!.toList()}');
          if (merchants.content!.toList().isNotEmpty) {
            return PopScope(
              canPop: true,
              child: GenericScreen(
                  appBar: false,
                  header: Text(
                    'Selecciona un comercio',
                    style: textTheme.titleLarge,
                  ),
                  content: ListView.builder(
                    itemCount: merchants.content!
                        .toList()
                        .length, //*tamaño de la lista
                    itemBuilder: (context, index) {
                      return SlideInUp(
                        child: ListTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                radius: height * 0.04,
                                backgroundColor: colors.primary,
                                child: Image.asset(
                                    'assets/images/fotocomercio.png'),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: width * 0.5,
                                      child: Text(
                                        merchants.content![index].name!,
                                        style: textTheme.titleMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textScaler: TextScaler.noScaling,
                                      )),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  SizedBox(
                                      width: width * 0.5,
                                      child: Text(
                                        merchants.content![index].role ==
                                                'employee'
                                            ? 'Empleado'
                                            : merchants.content![index].role ==
                                                    'owner'
                                                ? 'Otro rol'
                                                : 'Propietario',
                                        style: textTheme.titleSmall,
                                        overflow: TextOverflow.ellipsis,
                                        textScaler: TextScaler.noScaling,
                                      ))
                                ],
                              )
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              ref
                                  .read(merchantSelectedProvider.notifier)
                                  .update((state) => merchants.content![index]);
                              final merchant =
                                  ref.read(merchantSelectedProvider);
                              if (merchant != null) {
                                final merchantUuid = merchant.uuid;
                                ref
                                    .read(ntfyProvider.notifier)
                                    .suscribeNotificationsWithNtfyClient(
                                        merchantUuid!);
                              }
                            });
                           // context.go('/home');
                            context.go('/mode');
                          },
                        ),
                      );
                    },
                  )),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('No tiene comercios'),
              ),
            );
          }
        },
        error: (error, stracktrace) => Center(
              child: Text(error.toString()),
            ),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
