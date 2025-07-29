import 'dart:io';

import 'package:get/get.dart';

import '/app/core/interfaces/net_work_info.dart';
import '../../../app/core/services/logger_service.dart';

class MyHttpOverrides extends HttpOverrides {
  String proxyUrl;
  List<TrustedCertificate> _certs = const [];
  SecurityContext? _context;
  MyHttpOverrides({
    this.proxyUrl = "",
    List<TrustedCertificate> certs = const [],
    SecurityContext? context,
  }) {
    _certs = certs;
    _context = context;
  }

  List<TrustedCertificate> get getTrustedCertificates => _certs;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    /*final httpClient = super.createHttpClient(context);
    //log("Conectándose vía http con proxy:$proxyUrl");
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    httpClient.findProxy = (uri) {
      return proxyUrl.isNotEmpty
          ? "PROXY $proxyUrl;"
          : "PROXY http://10.12.34.153:80";
    };
    httpClient.authenticate = (uri, scheme, realm) {
      httpClient.addCredentials(uri, realm ?? "",
          HttpClientBasicCredentials('pmorell', 'seacemeb2020'));
      return Future.value(true);
    };
    httpClient.authenticateProxy = (host, port, scheme, realm) {
      httpClient.addProxyCredentials(host, port, realm ?? "",
          HttpClientBasicCredentials('pmorell', 'seacemeb2020'));
      return Future.value(true);
    };
    return httpClient;*/
    context = _context ?? context;

    HttpClient client = super.createHttpClient(context);

    return client
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        log("badCertificateCallback from: $host:$port for certificate:${cert.issuer}");
        return true;
      }
      ..connectionTimeout = NetworkInfoImpl.instance.getTimeOut;
  }
}

abstract class WebService {}
