import 'dart:developer';

import 'package:apk_template/features/chinchal/presentation/providers/ntfy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
//import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../../config/constants/environment.dart';
import '../../../../shared/ntfy/client.dart';
import '../../../../shared/ntfy/models/message_response.dart';
import '../../../../shared/shared.dart';

class DynamicQrCodeScreen extends ConsumerStatefulWidget {
  static const String name = 'DynamicQrCode';
  final String? amount;
  final String? qrcode;
  final String? image;

  const DynamicQrCodeScreen({super.key, this.amount, this.qrcode, this.image});

  @override
  DynamicQrCodeScreenState createState() => DynamicQrCodeScreenState();
}

class DynamicQrCodeScreenState extends ConsumerState<DynamicQrCodeScreen> {
  final baseUrl = Environment.notifyUrlService
      .replaceAllMapped(RegExp(r'(wss://)|(ws://)'), (match) {
    if (match.group(0) == 'wss://') {
      return 'https://';
    } else {
      return 'http://';
    }
  });

  @override
  void initState() {
    /* final merchantSelected = ref.read(merchantSelectedProvider);
    log('Este es el uuid del merchant seleccionado ==> ${merchantSelected!.uuid}'); */
    //subscribeToNotificationsWithWebSocketChannel(merchantSelected.uuid!);
    //suscribeNotificationsWithNtfyClient(merchantSelected.uuid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final ntfyStateProvider = ref.watch(ntfyProvider);
    if (ntfyStateProvider.state == 'scaned') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(ntfyProvider.notifier).changeStateParam(stateParam: 'none');
        Navigator.pop(context);
      });
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Pago a comercio',
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: height * 0.35,
              width: height * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.1),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5, 5),
                        blurRadius: 10),
                  ],
                  color: Colors.grey.shade300),
              child: QrImage(
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: const Size(50, 50),
                ),
                embeddedImage: const AssetImage('apkenzona/assets/ez.png'),
                data: widget.qrcode!,
                //accountModel.receiveCode,
                version: QrVersions.auto,
                size: height * 0.3,
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              widget.amount!,
              style: TextStyle(fontSize: height * 0.03),
            )
          ],
        ),
      ),
    );
  }

  void handleNotification(String message) {
    if (message.contains('scaned')) {
      log('Se ha escaneado correctamente el QR');
      context.pop();
    }
  }

  //* Puede ser via Web Socket de esta manera
  /* void subscribeToNotificationsWithWebSocketChannel(String merchantUuid) async {
    String url =
        'wss://ntfyenzona.platel.cu/m$merchantUuid/ws'; // al final puede tener esto : /sse
    // String url = '$baseUrl/m$merchantUuid';

    log('Esta es la url para suscribirse $url');
    final websocketChannel = WebSocketChannel.connect(Uri.parse(url));
    try {
      await websocketChannel.ready;

      websocketChannel.stream.listen((mensaje) {
        // ignore: prefer_interpolation_to_compose_strings
        log('Esto es lo que viene del servidor de notificaciones' + mensaje);
        handleNotification(mensaje);
        websocketChannel.sink.add('received!');
        //websocketChannel.sink.close(status.goingAway);
      });
    } on SocketException catch (e) {
      throw Exception(e);
    } on WebSocketChannelException catch (e) {
      throw Exception(e);
    }
  } */

  //* Puede ser via NtfyClient, http
  suscribeNotificationsWithNtfyClient(String merchantUuid) async {
    final String topic = 'm$merchantUuid';
    final client = NtfyClient();
    client.changeBasePath(Uri.parse(
      '$baseUrl/',

      ///'wss://ntfyenzona.platel.cu/' //! o esta 'https://ntfyenzona.platel.cu/' o '$baseUrl/'
    ));
    // Subscribe to the topic(s), receiving the MessageResponses right as they are published
    final stream = (await client.getMessageStream(
      [topic],
      // filters: const FilterOptions(
      //    /*  tags: [
      //       'completed',
      //       'scaned',
      //       //'dart'
      //     ], */ // needs ALL of these tags to be emited */
      //     priority: [
      //       PriorityLevels.low,
      //       PriorityLevels.none
      //     ] // needs ANY of the priority levels to be emited
      //     )
    ));

    // listen to our stream for messages sent to the topic, instantaneous update
    final listening = stream.listen((event) {
      print(event);
      if (event.message != null) {
        if (event.message!.contains('scaned')) {
          log('Ya se escaneo el qr');
          Navigator.pop(context);
        }
      }
      if (event.event == EventTypes.message) {
        //  again note other event types will periodically be sent here, but will be empty
        print(event.message);
        print(event.id); // mostly useful for future polling (see below)

        return;
      } else {
        print('received ${event.event}');
      }
    });

    // IMPORTANT: dispose of the client at the end of your usage to avoid hanging the process or leaving unneeded channels open with the ntfy server
    // this will break our stream, however, unless we do it after we terminate the stream.  Lets do this after the 20 seconds.
    /* Future.delayed(const Duration(seconds: 20)).then((value) async {
      await listening.cancel();
      client.close();
    }); */
  }
}
