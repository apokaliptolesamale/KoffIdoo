import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class OperationsChScreen extends StatefulWidget {
  final String merchantUuid;

  const OperationsChScreen({super.key, required this.merchantUuid});

  @override
  _OperationsChScreenState createState() => _OperationsChScreenState();
}

class _OperationsChScreenState extends State<OperationsChScreen> {
  late WebSocketChannel channel;
  List<dynamic> operationsCh = [];
  bool loading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  void _connectToWebSocket() {
    String url = 'ws://ntfyenzona.platel.cu/m${widget.merchantUuid}/sse';
    channel = WebSocketChannel.connect(Uri.parse(url));

    channel.stream.listen((data) {
      final parsedData = jsonDecode(data);
      setState(() {
        if (parsedData['message'] == 'scanned') {
          // Update your state here
        } else if (parsedData['message'].startsWith('completed')) {
          // Handle completed
        }
        // Update operationsCh based on your needs
      });
    }, onError: (error) {
      setState(() {
        errorMessage = error.toString();
        loading = false;
      });
    }, onDone: () {
      // Handle connection closed
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build your widget based on the state
    return Container();
  }
}
