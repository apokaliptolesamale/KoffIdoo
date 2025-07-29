import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart' as con;
import 'package:xml/xml.dart';

import '/app/core/interfaces/get_provider.dart';
import '/app/core/services/logger_service.dart';
import '/app/modules/prestashop/domain/models/product_model.dart';
import '/app/modules/prestashop/service/presta_shop_web_service.dart';
import '/app/modules/prestashop/service/presta_shop_web_service_factory.dart';
import '/app/modules/prestashop/service/query.dart';
import '../../../../app/core/config/errors/exceptions.dart';
import '../../../../app/core/config/errors/fault.dart';

class PrestaShopProductWebService<xml extends XmlDocument>
    extends GetProviderImpl {
  xml? product;
  String link;

  PrestaShopProductWebService({
    required this.link,
    this.product,
  });

  Future<Either<Exception, xml?>> load<xml>(Map<String, String>? params) async {
    con.Response<xml?>? resp;
    await httpClient.get<xml?>(link).then((value) {
      resp = value;
    }, onError: (error) {});

    if (resp!.body is Fault) {
      log("Error solicitando detalles de órdenes...");
      return Left(HttpServerException(fault: resp!.body as Fault));
    }
    log("Retornando listado de detalles de órdenes...");
    return Right(resp!.body);
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (data) {
      if (data
          .toString()
          .startsWith('<?xml version="1.0" encoding="UTF-8"?>')) {
        return product = XmlDocument.parse(data) as xml;
      }
      return Fault.fromJson(
          {"error": "Error al intentar cargar el recurso xml."});
    };
  }

  static Future<ProductModel> getProduct(
      ApiPrestaShopWebService<XmlDocument> api, String url) async {
    final service = PrestaShopAddressWebService(
      api: api,
      link: url,
    );
    final response = await service
        .load({}); //.then((value) {}).onError((error, stackTrace) => null);
    late ProductModel product;
    response.fold((l) => null, (r) {
      final doc = XmlDocument.parse(r);
      product = ProductModel.loadFromXml(doc.findAllElements("products").first);
    });
    return product;
  }

  static Future<List<ProductModel>> getProducts(
      ApiPrestaShopWebService<XmlDocument> api, String idOrder) async {
    /*final service = PrestaShopAddressWebService(
      api: api,
      link: url,
    );
    final response = await service
        .load({}); //.then((value) {}).onError((error, stackTrace) => null);*/
    String resource = "products";
    PrestaShopQuery query = PrestaShopQuery(
        tableName: "products", filters: [Where(key: "id", value: idOrder)]);
    final wsResource =
        await PrestaShopWebServiceFactory.getWebServiceResource(resource)!
            .loadFromUrl("", query.queryService());
    //wsResource.fold((l) => null, (r) => null)

    List<ProductModel> products = [];
    wsResource.fold((l) {
      log(l.toString());
    }, (doc) {
      doc.findAllElements("products").forEach((element) {
        products.add(ProductModel.loadFromXml(element));
      });
    });
    return products;
  }
}
