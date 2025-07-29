import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart' as con;
import 'package:xml/xml.dart';

import '/app/core/interfaces/get_provider.dart';
import '/app/core/services/logger_service.dart';
import '../../../../app/core/config/errors/exceptions.dart';
import '../../../../app/core/config/errors/fault.dart';

class PrestaShopOrderHistoryWebService<xml extends XmlDocument>
    extends GetProviderImpl {
  xml? orderHistories;
  String link;

  PrestaShopOrderHistoryWebService({
    required this.link,
    this.orderHistories,
  });

  Future<Either<Exception, xml?>> load<xml>(Map<String, String>? params) async {
    /*Map<String, String> headers =
        DefaultHeaderRequestService.getHttpDefaulHeader();*/
    con.Response<xml?>? resp;
    await httpClient
        .get<xml?>(
      link,
    )
        .then((value) {
      resp = value;
    }, onError: (error) {});

    if (resp!.body is Fault) {
      log("Error solicitando listado de historial de órdenes...");
      return Left(HttpServerException(fault: resp!.body as Fault));
    }
    log("Retornando listado de historial de órdenes...");
    return Right(resp!.body);
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (data) {
      if (data
          .toString()
          .startsWith('<?xml version="1.0" encoding="UTF-8"?>')) {
        return orderHistories = XmlDocument.parse(data) as xml;
      }
      return Fault.fromJson(
          {"error": "Error al intentar cargar el recurso xml."});
    };
  }
}
