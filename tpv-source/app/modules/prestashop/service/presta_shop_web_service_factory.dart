import 'package:xml/xml.dart';

import '/app/modules/prestashop/domain/models/status_model.dart';
import '/app/modules/prestashop/service/presta_shop_web_service.dart';
import '/app/modules/prestashop/service/query.dart';

class PrestaShopWebServiceFactory {
  static final PrestaShopWebServiceFactory instance =
      PrestaShopWebServiceFactory._internal(keys: {}, shops: {});

  final Map _keys = {};
  final Map<String, PrestaShopWebService<XmlDocument>> _shops = {};
  PrestaShopWebService<XmlDocument>? _activeWebService;

  PrestaShopWebServiceFactory._internal({
    required Map keys,
    required Map<String, PrestaShopWebService<XmlDocument>> shops,
  }) {
    _keys.addAll(keys);
    _shops.addAll(shops);
  }

  PrestaShopWebService<XmlDocument>? get getActiveWebService =>
      _activeWebService;
  bool get hasActiveWebService => _activeWebService != null;

  static PrestaShopWebService<XmlDocument> create(
      String shopName, String keyOfShop) {
    final instance = PrestaShopWebServiceFactory.instance;
    bool has = false;
    final PrestaShopWebService<XmlDocument> webService =
        (has = instance._shops.containsKey(shopName))
            ? instance._shops[shopName]!
            : PrestaShopWebService<XmlDocument>(
                key: keyOfShop,
                hostShop: shopName,
                withSsl: true,
              );

    /*if (!webService.apiHasLoaded) {
      webService.load().then((value) {
        value.fold((l) {
          log(
              "No se activó instancia de API para el web service de prestashop.");
        }, (body) {
          PrestaShopWebServiceFactory.instance._activeWebService!.setApi =
              ApiPrestaShopWebService.fromXml(
                  PrestaShopWebServiceFactory.instance._activeWebService!,
                  body.getElement("prestashop")!.getElement("api")!,
                  PrestaShopWebServiceFactory.instance._activeWebService!
                      .getUrl());
        });
      });
    }*/
    if (!has) {
      PrestaShopWebServiceFactory.instance._shops
          .putIfAbsent(shopName.toString(), () => webService);
    }
    PrestaShopWebServiceFactory.instance._activeWebService = webService;
    return webService;
  }

  static ApiPrestaShopWebService<XmlDocument> createApi(
    dynamic shopName,
    dynamic keyOfShop,
  ) {
    return create(shopName, keyOfShop).getApi;
  }

  static Future<T?> executeQuery<T>(
    dynamic shopName,
    dynamic keyOfShop, {
    String tableName = "",
    List<String> display = const [],
    List<String> sort = const [],
    List<Where> filters = const [],
    int? offSet,
    int? limit,
    Future<T> Function(
            ApiPrestaShopWebService<XmlDocument> api, String urlQueryService)?
        callback,
  }) async {
    return createApi(shopName, keyOfShop).executeQuery(
        tableName: tableName,
        display: display,
        sort: sort,
        filters: filters,
        limit: limit,
        offSet: offSet,
        callback: callback);
  }

  static Future<StatusModel> getStatusByName(
      dynamic shopName, dynamic keyOfShop, String stateName) async {
    PrestaShopQuery query = PrestaShopQuery(
        tableName: "order_states",
        filters: [Where(key: "name", value: stateName)]);

    return getStatusByQuery(shopName, keyOfShop, query);
  }

  static Future<StatusModel> getStatusByQuery(
      dynamic shopName, dynamic keyOfShop, PrestaShopQuery query) async {
    ApiPrestaShopWebService<XmlDocument> api = createApi(shopName, keyOfShop);
    final xmlQuery = query.queryService();
    String url = "${api.url}$xmlQuery";

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

  static Future<StatusModel> getStatusByUrl(
      dynamic shopName, dynamic keyOfShop, String url) async {
    ApiPrestaShopWebService<XmlDocument> api = createApi(shopName, keyOfShop);
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

  static PrestaShopWebServiceResource<XmlDocument>? getWebServiceResource(
      String name) {
    if (PrestaShopWebServiceFactory.instance.hasActiveWebService) {
      return PrestaShopWebServiceFactory.instance.getActiveWebService!.getApi
          .getWebServiceResource(name);
    }
    return null;
  }

  static Future<T?> update<T>(
    dynamic shopName,
    dynamic keyOfShop, {
    String tableName = "",
    List<String> display = const [],
    List<Where> filters = const [],
    Future<T> Function(ApiPrestaShopWebService<XmlDocument> api,
            PrestaShopQuery query, String urlQueryService)?
        callback,
  }) async {
    return createApi(shopName, keyOfShop).update(
      tableName: tableName,
      display: display,
      filters: filters,
      callback: callback,
    );
  }
}
