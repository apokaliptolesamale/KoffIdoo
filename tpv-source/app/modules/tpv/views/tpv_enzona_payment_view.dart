// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class TpvEnzonaPaymentView extends StatefulWidget {
  final List<String> itemList = ['Tomate', 'Pepino', 'Zanahoria'];
  final double totalPrice = 20.00;

  @override
  _TpvEnzonaPaymentViewState createState() => _TpvEnzonaPaymentViewState();
}

class _TpvEnzonaPaymentViewState extends State<TpvEnzonaPaymentView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String _paymentUrl = '';

  Future<http.Response> _registerPayment() async {
    final url = 'https://api.mipagoweb.com/payments/register';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'amount': widget.totalPrice});
    return http.post(Uri.parse(url), headers: headers, body: body);
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scan this QR to pay'),
          content: Container(
            width: 200.0,
            height: 200.0,
            child: _paymentUrl.isNotEmpty
                ? QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code == _paymentUrl) {
        controller.pauseCamera();
        Navigator.of(context).pop();
        _confirmPayment();
      }
    });
  }

  void _confirmPayment() async {
    final url = 'https://api.mipagoweb.com/payments/confirm';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'amount': widget.totalPrice});
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
    } else {}
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagar usando enzona'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.itemList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(widget.itemList[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${widget.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final response = await _registerPayment();
              if (response.statusCode == 200) {
                final paymentData = jsonDecode(response.body);
                setState(() {
                  _paymentUrl = paymentData['url'];
                });
                _showPaymentDialog(context);
              } else {
                // error
              }
            },
            child: Text('Pay'),
          ),
        ],
      ),
    );
  }
}
