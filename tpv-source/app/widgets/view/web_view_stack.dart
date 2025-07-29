// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../app/widgets/view/webview/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  String initialUrl;
  WebViewStack({Key? key, required this.initialUrl}) : super(key: key);

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;
  var initialUrl = "";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: initialUrl,
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    initialUrl = widget.initialUrl;
    super.initState();
  }
}
