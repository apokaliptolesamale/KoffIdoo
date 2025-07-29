import 'dart:developer';

import 'package:apk_template/features/apk_comercio_experto/presentation/providers/expert_mode_provider.dart';
import 'package:apk_template/features/chinchal/presentation/providers/ntfy_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../home/presentation/providers/home_provider.dart';
import '../../../domain/models/merchant_model.dart';
import '../../../domain/models/operation_model.dart';
import '../../providers/merchant_provider.dart';
import '../../providers/operations_provider.dart';
import '../../widgets/operation_tile.dart';

class OperationsScreen extends ConsumerStatefulWidget {
  static const String name = 'operations';

  const OperationsScreen({super.key});

  @override
  OperationsScreenState createState() => OperationsScreenState();
}

class OperationsScreenState extends ConsumerState<OperationsScreen> {
  final player = AudioPlayer();
  ScrollController scrollController = ScrollController();
  int limit = 15;
  int offset = 0;
  List<OperationMerchantModel> list = <OperationMerchantModel>[];
  @override
  void initState() {
    super.initState();
    // Create the audio player.

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);
    // Start the player as soon as the app is displayed.
    /*  WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('assets/sounds/fairy_tone.mp3'));
      await player.resume();
    }); */
    scrollController.addListener(() {
      // agregar mas al final de la lista
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //es decir la utlima posicion de la lista, al final
        setState(() {
          offset = limit + 1;
          limit = limit + 16;
        });
        //_agregar10();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /* final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width; */
    final numberFormat = NumberFormat.currency(locale: 'en_US', symbol: "\$");
    final ntfyState = ref.watch(ntfyProvider);

    //int counterList = list.content!.length;
    if (ref.watch(merchantSelectedProvider) != null &&
        (ref.watch(expertModeProvider)?ref.watch(currentIndexProvider) == 2:ref.watch(currentIndexProvider) == 1)) {
      if (ntfyState.state.contains('completed')) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          ref.read(ntfyProvider.notifier).changeStateParam(stateParam: 'none');
          setState(() {});
          await player.setSource(AssetSource('sounds/fairy_tone.mp3'));
          await player.resume();
          // counterList++;
        });
      }
      final MerchantModel? merchantSeleted =
          ref.watch(merchantSelectedProvider);
      /* final operations = ref
          .watch(filterOperationsMerchantProvider.call(merchantSeleted!.uuid!)); */
      return FutureBuilder(
        future: ref.read(filterOperationsMerchantProvider({
          'merchantUUID': merchantSeleted!.uuid!,
          'limit': limit,
          'offset': offset
        }
            //merchantSeleted!.uuid!
            ).future),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            ListOperationMerchantModel lista = snapshot.data;
           
           //TODO.CHECK ESTE ERROR
            list=lista.content!;
            /* lista.content!.map((e) {
              list.add(e);
              setState(() {});
            }); */
            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      log('Este es el avatar ==> ${list[index].avatar}');
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: OperationTile(
                          operation: list[index],
                          user: '${list[index].name} ${list[index].lastname}',
                          amount: (list[index].total != null &&
                                      list[index].total!.isEmpty) &&
                                  list[index].refundedAmount!.isNotEmpty
                              ? '-${numberFormat.format(double.parse(list[index].refundedAmount!))}'
                              : (list[index].total != null &&
                                      list[index].total!.isEmpty)
                                  ? ''
                                  : '+${numberFormat.format(double.parse(list[index].total!))}',
                          status: '${list[index].status}',
                          transactionId: '${list[index].merchantOpId}',
                          currency: '${list[index].currency}',
                          urlAvatar: list[index].avatar,
                        ),
                      );
                    }),
              ),
            );
          }
        },
      );
    } else {
      return Container();
    }
  }
}
