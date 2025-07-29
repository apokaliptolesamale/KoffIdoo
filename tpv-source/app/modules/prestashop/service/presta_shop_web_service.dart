// ignore_for_file: unnecessary_null_comparison, unused_field

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart' as con;
import 'package:xml/xml.dart';

import '/../../../../app/core/config/errors/exceptions.dart';
import '/../../../../app/core/config/errors/fault.dart';
import '/app/core/cache/custom_cache_manager.dart';
import '/app/core/interfaces/get_provider.dart';
import '/app/core/interfaces/net_work_info.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/webservice.dart';
import '/app/modules/prestashop/domain/models/address_model.dart';
import '/app/modules/prestashop/domain/models/customer_model.dart';
import '/app/modules/prestashop/service/presta_shop_data_source_web_service.dart';
import '/app/modules/prestashop/service/query.dart';
import '/app/widgets/utils/custom_datetime_converter.dart';

class ApiPrestaShopWebService<xml extends XmlDocument> {
  static final Map<String, PrestaShopWebServiceResource> _serviceMapper = {};
  String shopName, url;

  List<PrestaShopWebServiceResource> services;

  PrestaShopWebService webService;

  ApiPrestaShopWebService({
    required this.shopName,
    required this.webService,
    this.services = const [],
    required this.url,
  }) {
    _serviceMapper.forEach((key, value) {
      value.setApi(this);
    });
    for (var element in services) {
      element.setApi(this);
    }
  }

  factory ApiPrestaShopWebService.fromXml(
      PrestaShopWebService webService, XmlElement element, String url) {
    List<XmlElement> children = element.children != null
        ? element.children.whereType<XmlElement>().toList()
        : [];
    return ApiPrestaShopWebService(
        webService: webService,
        shopName: element.getAttribute('shopName') ?? "Tienda sin nombre",
        url: url,
        services: children.map((e) {
          //log("Creación de PrestaShopWebServiceResource para servicio de:${e.name}");
          return _serviceMapper.putIfAbsent(
              e.name.local, () => PrestaShopWebServiceResource.fromXml(e));
        }).toList());
  }
  PrestaShopWebService get getWebService => webService;

  Future<T?> executeQuery<T>({
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
    if (tableName.isEmpty) return Future.value(null);

    PrestaShopQuery query = PrestaShopQuery(
      tableName: tableName,
      display: display,
      filters: filters,
      sort: sort,
      offSet: offSet,
      limit: limit,
    );

    final xmlQuery = query.queryService();
    if (callback != null) {
      //log("Url Service:$url$xmlQuery");
      return callback(this, "$url$xmlQuery");
    }
    return null;
  }

  PrestaShopWebServiceResource<XmlDocument>? getWebServiceResource(String key) {
    return _serviceMapper.containsKey(key) ? _serviceMapper[key] : null;
  }

  Future<T?> update<T>({
    String tableName = "",
    List<String> display = const [],
    List<Where> filters = const [],
    Future<T> Function(ApiPrestaShopWebService<XmlDocument> api,
            PrestaShopQuery query, String urlQueryService)?
        callback,
  }) async {
    if (tableName.isEmpty) return Future.value(null);

    PrestaShopQuery query = PrestaShopQuery(
      tableName: tableName,
      display: display,
      filters: filters,
    );

    final xmlQuery = query.queryService();
    if (callback != null) {
      //log("Url Service:$url$xmlQuery");
      return callback(this, query, "$url$xmlQuery");
    }
    return null;
  }
}

class PrestaShopAddressWebService<xml extends XmlDocument>
    extends GetProviderImpl {
  xml? address;
  String link;
  ApiPrestaShopWebService<XmlDocument> api;

  PrestaShopAddressWebService({
    required this.link,
    required this.api,
    this.address,
  }) {
    if (!link.contains(api.getWebService.key)) {
      link = link.replaceAll(
          RegExp(r'https://'), "https://${api.getWebService.key}@");
    }
  }

  Future<Either<Exception, xml?>> load<xml>(Map<String, String>? params) async {
    con.Response<xml?>? resp;
    await httpClient.get<xml?>(link).then((value) {
      resp = value;
    }, onError: (error) {});

    if (resp!.body is Fault) {
      log("Error solicitando listado de direcciones...");
      return Left(HttpServerException(fault: resp!.body as Fault));
    }
    log("Retornando listado de direcciones...");
    return Right(resp!.body);
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (data) {
      if (data
          .toString()
          .startsWith('<?xml version="1.0" encoding="UTF-8"?>')) {
        return address = XmlDocument.parse(data) as xml;
      }
      return Fault.fromJson(
          {"error": "Error al intentar cargar el recurso xml."});
    };
  }

  static Future<AddressModel> getAddress(
      ApiPrestaShopWebService<XmlDocument> api, String url) async {
    final service = PrestaShopAddressWebService(
      api: api,
      link: url,
    );
    final response = await service
        .load({}); //.then((value) {}).onError((error, stackTrace) => null);
    late AddressModel address;
    response.fold((l) => null, (r) {
      final doc = XmlDocument.parse(r);

      address =
          AddressModel.fromXml(doc.findAllElements("address").first, (el) {
        //TODO asignar fecha de creación desde el xml
        return AddressModel(
            idAddress: el.getElement("id")!.value,
            idCountry: el.getElement("id_country")!.value,
            idState: el.getElement("id_state")!.value,
            custormer: CustomerModel(
              firstName: el.getElement("firstname")!.value ?? "",
              lastName: el.getElement("lastname")!.value ?? "",
              dni: el.getElement("dni")!.value ?? "",
            ),
            postcode: el.getElement("postcode")!.value,
            alias: el.getElement("alias")!.value ?? "",
            city: el.getElement("city")!.value ?? "",
            address: el.getElement("address1")!.value ?? "",
            createAt:
                CustomDateTimeConverter.from(el.getElement("date_add")!.value),
            updateAt:
                CustomDateTimeConverter.from(el.getElement("date_upd")!.value));
      });
    });
    return address;
  }
}

class PrestaShopCustomerWebService<xml extends XmlDocument>
    extends GetProviderImpl {
  xml? orders;
  String link;

  PrestaShopCustomerWebService({
    required this.link,
    this.orders,
  });

  Future<Either<Exception, xml?>> load<xml>(Map<String, String>? params) async {
    con.Response<xml?>? resp;
    await httpClient.get<xml?>(link).then((value) {
      resp = value;
    }, onError: (error) {});

    if (resp!.body is Fault) {
      log("Error solicitando listado de direcciones...");
      return Left(HttpServerException(fault: resp!.body as Fault));
    }
    log("Retornando listado de direcciones del cliente...");
    return Right(resp!.body);
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (data) {
      if (data
          .toString()
          .startsWith('<?xml version="1.0" encoding="UTF-8"?>')) {
        return orders = XmlDocument.parse(data) as xml;
      }
      return Fault.fromJson(
          {"error": "Error al intentar cargar el recurso xml."});
    };
  }

  static Future<CustomerModel> getCustomer(
      ApiPrestaShopWebService<XmlDocument> api, String url) async {
    final service = PrestaShopAddressWebService(
      api: api,
      link: url,
    );
    final response = await service.load({});
    late CustomerModel customer;
    response.fold((l) => null, (r) {
      final doc = XmlDocument.parse(r);
      customer =
          CustomerModel.fromXml(doc.findAllElements("customer").first, (el) {
        //TODO asignar fecha de creación desde el xml
        return CustomerModel(
          id: el.getElement("id")!.value,
          firstName: el.getElement("firstname")!.value ?? "",
          lastName: el.getElement("lastname")!.value ?? "",
          email: el.getElement("email")!.value ?? "",
          userName: el.getElement("sub")!.value ?? "",
        );
      });
    });
    return customer;
  }
}

class PrestaShopOrderWebService<xml extends XmlDocument>
    extends GetProviderImpl {
  xml? orders;
  String link;

  PrestaShopOrderWebService({
    required this.link,
    this.orders,
  });

  Future<Either<Exception, xml?>> load<xml>(Map<String, String>? params) async {
    /*Map<String, String> headers =
        DefaultHeaderRequestService.getHttpDefaulHeader();*/
    con.Response<xml?>? resp;
    await httpClient.get<xml?>(link).then((value) {
      resp = value;
    }, onError: (error) {});

    if (resp!.body is Fault) {
      log("Error solicitando listado de ordenes de prestashop...");
      return Left(HttpServerException(fault: resp!.body as Fault));
    }
    log("Retornando listado de ordenes...");
    return Right(resp!.body);
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (data) {
      if (data
          .toString()
          .startsWith('<?xml version="1.0" encoding="UTF-8"?>')) {
        return orders = XmlDocument.parse(data) as xml;
      }
      return Fault.fromJson(
          {"error": "Error al intentar cargar el recurso xml."});
    };
  }
}

class PrestaShopProductWebService<xml extends XmlDocument>
    extends GetProviderImpl {
  xml? products;
  String link;

  PrestaShopProductWebService({
    required this.link,
    this.products,
  });

  Future<Either<Exception, xml?>> load<xml>(Map<String, String>? params) async {
    /*Map<String, String> headers =
        DefaultHeaderRequestService.getHttpDefaulHeader();*/
    con.Response<xml?>? resp;
    await httpClient.get<xml?>(link).then((value) {
      resp = value;
    }, onError: (error) {});

    if (resp!.body is Fault) {
      log("Error solicitando listado de ordenes de prestashop...");
      return Left(HttpServerException(fault: resp!.body as Fault));
    }
    log("Retornando listado de ordenes...");
    return Right(resp!.body);
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (data) {
      if (data
          .toString()
          .startsWith('<?xml version="1.0" encoding="UTF-8"?>')) {
        return products = XmlDocument.parse(data) as xml;
      }
      return Fault.fromJson(
          {"error": "Error al intentar cargar el recurso xml."});
    };
  }
}

class PrestaShopWebService<xml extends XmlDocument> extends GetProviderImpl
    implements WebService {
  String key;
  String hostShop;
  bool withSsl;
  String? _url;
  bool _hasConnection = false;

  XmlDocument? _body;

  ApiPrestaShopWebService? _api;

  PrestaShopWebService({
    required this.key,
    required this.hostShop,
    this.withSsl = true,
  }) {
    _url = "${withSsl ? 'https' : 'http'}://$key@$hostShop/api/";
    log("Api service url on: ${_url!.replaceAll("$key@", "")}");
    /*_api = ApiPrestaShopWebService(
      shopName: hostShop,
      webService: this,
      url: _url!,
    );*/
    load().then((value) {
      value.fold((l) {
        log("Error loading prestashop services.");
      }, (r) {
        log("Prestashop services loaded successfully.");
      });
    });
  }

  bool get apiHasLoaded => _api != null;

  ApiPrestaShopWebService get getApi =>
      _api ??
      ApiPrestaShopWebService(
        shopName: hostShop,
        webService: this,
        url: _url!,
      );

  set setApi(ApiPrestaShopWebService api) {
    _api = api;
  }

  Future<Either<Exception, xml?>> execute<xml>(
      String action, Map<String, String>? params) async {
    switch (action) {
      case "GET":
        return _get<xml?>(params);
      default:
    }
    return Future.value(Left(HttpServerException(
      fault: Fault.fromJson({
        "code": "0",
        "type": "Error",
        "message": "Error de acceso al servicio",
        "description": "Error al intentar acceder al recurso xml en la red",
      }),
    )));
  }

  String getUrl() => _url!;

  Future<Either<Exception, XmlDocument>> load() async {
    if (_body != null) {
      return Right(_body!);
    }
    final content = await Get.find<NetworkInfoImpl>().getContent(_url!);
    _hasConnection = content != null;
    // await Get.find<NetworkInfoImpl>().hasConnection(_url!);
    log(_url!);
    if (!_hasConnection) {
      return Left(HttpServerException(
          fault: Fault(
        faultCode: 0,
        type: "Error",
        message: "Error de conexión.",
        description: "No se puede acceder al recurso de red.",
      )));
    }
    try {
      _body = XmlDocument.parse(content);
      log("Retornando xml con especificación de servicios...");
      _api = ApiPrestaShopWebService.fromXml(
          this, _body!.getElement("prestashop")!.getElement("api")!, _url!);
      return Right(_body!);
    } catch (e) {
      _body = null;
    }
    log("Error cargando recurso xml...");
    return Left(HttpServerException(
        fault: Fault(
      faultCode: 0,
      type: "Error",
      message: "Error cargando recurso xml...",
      description:
          "Ha sucedido un error al intentar acceder al recuerdo remoto.",
    )));
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (data) {
      if (data
          .toString()
          .startsWith('<?xml version="1.0" encoding="UTF-8"?>')) {
        return data;
      }
      return Fault.fromJson(
          {"error": "Error al intentar cargar el recurso xml."});
    };
  }

  Future<Either<Exception, xml?>> _get<xml>(Map<String, String>? params) async {
    con.Response<xml?>? resp;
    await httpClient.get<xml?>(getUrl()).then((value) {
      resp = value;
    }, onError: (error) {});

    if (resp!.body is Fault) {
      log("Error cargando recurso xml...");
      return Left(HttpServerException(fault: resp!.body as Fault));
    }
    log("Retornando xml con especificación de servicios...");
    return Right(resp!.body);
  }
}

class PrestaShopWebServiceResource<xml extends XmlDocument>
    extends GetProviderImpl {
  String link, tag;
  late String blank, synopsis;

  late ApiPrestaShopWebService _api;

  PrestaShopWebServiceResource({
    required this.tag,
    required this.link,
  }) {
    blank = "$link?schema=blank";
    synopsis = "$link?schema=synopsis";
  }

  factory PrestaShopWebServiceResource.fromXml(XmlElement element) {
    return PrestaShopWebServiceResource(
      tag: element.name.local,
      link: element.getAttribute('xlink:href') ?? "",
    );
  }

  ApiPrestaShopWebService<XmlDocument> get getApi => _api;

  Future<Either<Exception, XmlDocument>> createTemplate() async {
    return loadFromUrl(tag, "?schema=blank");
  }

  Future<List<PrestaShopDataSourceWebService>?> getDataService() async {
    if (link != null &&
        _api != null &&
        !link.contains(_api.getWebService.key)) {
      link = link.replaceAll(
          RegExp(r'https://'), "https://${_api.getWebService.key}@");
    }
    log("Obteniendo datos del servicio de: [$tag]");
    final content = await CustomCacheManager.getHttpContent(link);
    return content != null && content.isNotEmpty
        ? Future.value(PrestaShopDataSourceWebService.getChildren(
            XmlDocument.parse(content), tag))
        : Future.value([]);
  }

  Future<Either<Exception, XmlDocument>> loadFromUrl(
      String resource, String? queryString) async {
    log("Cargando recurso desde: $baseUrl$resource$queryString .");
    final response = await get(
      "$resource$queryString",
      contentType: "application/xml",
    );
    if (response.statusCode == 200) {
      return Right(XmlDocument.parse(response.body));
    }
    return Left(HttpServerException404());
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (data) {
      if (data
          .toString()
          .startsWith('<?xml version="1.0" encoding="UTF-8"?>')) {
        return XmlDocument.parse(data) as xml;
      }
      return Fault.fromJson(
          {"error": "Error al intentar cargar el recurso xml."});
    };
  }

  PrestaShopWebServiceResource setApi(ApiPrestaShopWebService api) {
    _api = api;
    if (link != null &&
        _api != null &&
        !link.contains(_api.getWebService.key)) {
      link = link.replaceAll(
          RegExp(r'https://'), "https://${_api.getWebService.key}@");
      /*_api.url = _api.url.replaceAll(
          RegExp(r'https://'), "https://${_api.getWebService.key}@");*/
    }
    setBaseUrl(_api.url);
    blank = "$link?schema=blank";
    synopsis = "$link?schema=synopsis";
    return this;
  }
}
