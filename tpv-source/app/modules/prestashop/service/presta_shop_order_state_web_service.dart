import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart' as con;
import 'package:xml/xml.dart';

import '/app/core/interfaces/get_provider.dart';
import '/app/core/services/logger_service.dart';
import '/app/modules/prestashop/domain/models/status_model.dart';
import '/app/modules/prestashop/service/presta_shop_web_service.dart';
import '../../../../app/core/config/errors/exceptions.dart';
import '../../../../app/core/config/errors/fault.dart';

class PrestaShopOrderStateWebService<xml extends XmlDocument>
    extends GetProviderImpl {
  xml? status;
  String link;

  PrestaShopOrderStateWebService({
    required this.link,
    this.status,
  });

  Future<Either<Exception, xml?>> load<xml>(Map<String, String>? params) async {
    con.Response<xml?>? resp;
    await httpClient.get<xml?>(link).then((value) {
      resp = value;
    }, onError: (error) {});

    if (resp!.body is Fault) {
      log("Error solicitando estados...");
      return Left(HttpServerException(fault: resp!.body as Fault));
    }
    log("Retornando listado de estados...");
    return Right(resp!.body);
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (data) {
      if (data
          .toString()
          .startsWith('<?xml version="1.0" encoding="UTF-8"?>')) {
        return status = XmlDocument.parse(data) as xml;
      }
      return Fault.fromJson(
          {"error": "Error al intentar cargar el recurso xml."});
    };
  }

  static Future<StatusModel> getStatus(
      ApiPrestaShopWebService<XmlDocument> api, String url) async {
    final service = PrestaShopAddressWebService(
      api: api,
      link: url,
    );
    final response = await service
        .load({}); //.then((value) {}).onError((error, stackTrace) => null);
    late StatusModel status;
    response.fold((l) => null, (r) {
      final doc = XmlDocument.parse(r);
      status =
          StatusModel.fromXml(doc.findAllElements("order_state").first, (el) {
        return StatusModel(
          id: el.getElement("id")!.value,
          color: el.getElement("color")!.value ?? "",
          status: doc.findAllElements("name").first.firstChild!.value ?? "",
        );
      });
    });
    return status;
  }
}
