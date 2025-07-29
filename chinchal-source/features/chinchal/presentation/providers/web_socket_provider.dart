import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final webSocketProvider = StateProvider<WebSocketChannel?>((ref) {
  return null;
});
