import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LoginWidget extends StatelessWidget {
  final String initialUrl;
  final Function onStartLoadUrl;
  final Function onStopLoadUrl;
  final Function onProgressChange;

  const LoginWidget({
    super.key,
    required this.initialUrl,
    required this.onStartLoadUrl,
    required this.onStopLoadUrl,
    required this.onProgressChange,
  });

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(initialUrl)), // initialUrl,
      initialSettings: InAppWebViewSettings(
          safeBrowsingEnabled: true,
          useShouldOverrideUrlLoading: false,
          javaScriptEnabled: true,
          builtInZoomControls: false,
          displayZoomControls: false,
          enableViewportScale: true,
          useWideViewPort: true,
          verticalScrollBarEnabled: false,
          horizontalScrollBarEnabled: true,
          sharedCookiesEnabled: true,
          // isInspectable: kDebugMode,

          mediaPlaybackRequiresUserGesture: false,
          allowsInlineMediaPlayback: true,
          iframeAllow: "camera; microphone",
          iframeAllowFullscreen: true),
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return ServerTrustAuthResponse(
            action: ServerTrustAuthResponseAction.PROCEED);
      },
      onProgressChanged: (controller, progress) =>
          onProgressChange(controller, progress),
      onLoadStart: (controller, url) => onStartLoadUrl(controller, url),
      onLoadStop: (controller, url) => onStopLoadUrl(controller, url),
    );
  }
}
