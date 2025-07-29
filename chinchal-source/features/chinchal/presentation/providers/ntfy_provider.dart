import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/environment.dart';
import '../../../shared/ntfy/client.dart';
import '../../../shared/ntfy/models/message_response.dart';

final baseUrl = Environment.notifyUrlService
    .replaceAllMapped(RegExp(r'(wss://)|(ws://)'), (match) {
  if (match.group(0) == 'wss://') {
    return 'https://';
  } else {
    return 'http://';
  }
});

void playNotificationSound() async {
  /* final player = audioplayers.AudioPlayer();
 await player.play(); */
}

final ntfyProvider = StateNotifierProvider<NtfyStateNotifier, NtfyState>((ref) {
  return NtfyStateNotifier();
});

class NtfyStateNotifier extends StateNotifier<NtfyState> {
  NtfyStateNotifier() : super(NtfyState(state: ''));

  void changeStateParam({String? stateParam}) {
    state = state.copyWith(state: stateParam!, amount: state.amount);
  }

  void changeStateAmount(String? amount) {
    state = state.copyWith(state: state.state, amount: amount);
  }

  void suscribeNotificationsWithNtfyClient(String merchantUuid) async {
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
          // Navigator.pop(context);
          state = state.copyWith(state: 'scaned');
        }
        if (event.message!.contains('completed')) {
          log('Tuvo una nueva operación el mensaje es ==> ${event.message}');
          state = state.copyWith(
              state: event.message!, //'completed',
              amount: event.message!.replaceAll('completed-', ''));
        }
        if (event.event == EventTypes.keepAlive) {
          state = state.copyWith(state: 'none');
        }
        if (event.event == EventTypes.open) {
          state = state.copyWith(state: 'none');
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

class NtfyState {
  final String state;
  final String? amount;
  NtfyState({required this.state, this.amount});

  NtfyState copyWith({final String state = '', String? amount}) {
    return NtfyState(state: state, amount: amount);
  }
}
