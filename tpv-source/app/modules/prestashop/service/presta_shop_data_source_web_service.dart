import 'package:xml/xml.dart';

import '/app/core/interfaces/get_provider.dart';
import '/app/core/services/logger_service.dart';
import '../../../../app/core/config/errors/fault.dart';

class PrestaShopDataSourceWebService<xml extends XmlDocument>
    extends GetProviderImpl {
  String? link;
  XmlName tag;
  String? id;
  PrestaShopDataSourceWebService({
    required this.tag,
    required this.id,
    required this.link,
  });

  factory PrestaShopDataSourceWebService.fromXml(XmlElement element) {
    return PrestaShopDataSourceWebService(
      tag: element.name,
      id: element.getAttribute("id"),
      link: element.getAttribute('xlink:href'),
    );
  }

  Future<XmlDocument?> getDataService() async {
    log("Obteniendo datos del datasource: [$tag] con id=$id");
    XmlDocument? data = XmlDocument.parse(link!);
    return Future.value(data);
  }

  Future<XmlDocument?> load() => Future.value(XmlDocument.parse(link!));

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

  static List<PrestaShopDataSourceWebService> getChildren(
      XmlDocument document, String tag) {
    XmlElement? element = document.findAllElements(tag).first;
    List<XmlElement> children = element.children.isNotEmpty
        ? element.children.whereType<XmlElement>().toList()
        : [];
    return children.map((e) {
      return PrestaShopDataSourceWebService.fromXml(e);
    }).toList();
  }
}
