import 'package:apk_template/config/config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final baseUrl = Environment.notifyUrlService
    .replaceAllMapped(RegExp(r'(wss://)|(ws://)'), (match) {
  if (match.group(0) == 'wss://') {
    return 'https://';
  } else {
    return 'http://';
  }
});

void subscribeToNotifications(String merchantUuid) {
  final channel = WebSocketChannel.connect(Uri.parse('$baseUrl/$merchantUuid'));

  channel.stream.listen((message) {
    handleNotification(message);
  });
}

void handleNotification(String message) {
  if (message.contains('scaned')) {
    closeQRView();
  }
}

void closeQRView() {
  // Cierra la vista del QR o realiza cualquier otra acción necesaria
  //Navigator.pop(context);
}
