// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '../entities/bank_debit_detail.dart';
import '/app/modules/transaction/domain/models/bank_debit_detail_model.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/invoice.dart';

InvoiceList invoiceListModelFromJson(String str) {
  return InvoiceList.fromJson(json.decode(str));
}

InvoiceModel invoiceModelFromJson(String str) =>
    InvoiceModel.fromJson(json.decode(str));

String invoiceModelToJson(InvoiceModel data) => json.encode(data.toJson());

class InvoiceList<T extends InvoiceModel> implements EntityModelList<T> {
  final List<T> invoices;

  InvoiceList({
    this.invoices = const [],
  });

  factory InvoiceList.fromStringJson(String strJson) =>
      InvoiceList.fromJson(json.decode(strJson));

  factory InvoiceList.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("invoice")) {
  return InvoiceList(
    invoices:
        List<T>.from(json["invoice"].map((x) => InvoiceModel.fromJson(x))),
  );
}else if(json.containsKey("debt")){
  return InvoiceList(
    invoices:
        List<T>.from(json["debt"].map((x) => InvoiceModel.fromJson(x))),
  );
}
return InvoiceList(invoices: []);
  }
  factory InvoiceList.fromEmpty() => InvoiceList(
        invoices: List<T>.from([].map((x) => InvoiceList.fromJson(x))),
      );

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return InvoiceList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!invoices.contains(element)) invoices.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return InvoiceList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => invoices;

  Map<String, dynamic> toJson() => {
        "invoices": List<dynamic>.from(invoices.map((x) => x.toJson())),
      };

  static Future<T> fromXmlServiceUrl<T>(
      String url,
      String parentTagName,
      Future<T> Function(XmlDocument doc, XmlElement el) process,
      Future<T> Function() onError) async {
    return EntityModelList.fromXmlServiceUrl(
        url, parentTagName, process, onError);
  }

  static Future<T> getJsonFromXMLUrl<T>(
      String url,
      Future<T> Function(XmlDocument result) process,
      Future<T> Function() onError) async {
    return EntityModelList.getJsonFromXMLUrl(url, process, onError);
  }
}

@JsonSerializable()
class InvoiceModel extends Invoice implements EntityModel {
  @override
  String? paymentServiceId;
  @override
  int? transactionId;
  @override
  String? amount;
  @override
  double? totalAmount;
  @override
  int? branch;
  @override
  String? invoiceEz;
  @override
  String? owner;
  @override
  Map<String, dynamic>? metadata;
  @override
  String? period;
  @override
  String? transactionUuid;
  @override
  DateTime? transactionCreatedAt;
  @override
  int? transactionStatusCode;
  @override
  String? transactionStatus;
  @override
  String? last4;
  @override
  String? currency;
  @override
  String? transactionDescription;
  @override
  String? transactionDenom;
  @override
  int? transactionCode;
  @override
  String? merchantAlias;
  @override
  String? merchantAvatar;
  @override
  String? bankCode;
  @override
  String? username;
  @override
  String? privuse2;
  @override
  BankDebitDetail? bankDebitDetail;
  @override
  String? fundingSourceUuid;
  @override
  int? clientId;
  @override
  String? transactionSignature;
  @override
  String? rc04;
  @override
  String? folio;
  @override
  String? tomo;
  @override
  String? route;
  @override
  String? month;
  @override
  String? year;
  @override
  String? charged;
  @override
  String? invoiceDate;
  @override
  String? discount;
  @override
  String? consumption;
  @override
  String? status;
  @override
  int? statusCode;
  @override
  int? accountId;
  @override
  String? name;
  @override
  String? libro;
  @override
  String? importe;
  @override
  String? code;
  @override
  String? lectura;
  @override
  String? gasConsumption;
  @override
  String? postVenta;
  @override
  String? municipio;
  @override
  String? cobrador;
  @override
  String? datosContrato;
  @override
  DateTime? mensualidad;
  @override
  String? metro;
  @override
  String? idMunicipio;
  @override
  String? noFactura;
  @override
  String? description;
  @override
  String? pagado;
  @override
  String? saldo;

  InvoiceModel(
      {this.name,
      this.libro,
      this.importe,
      this.code,
      this.lectura,
      this.gasConsumption,
      this.postVenta,
      this.municipio,
      this.cobrador,
      this.datosContrato,
      this.mensualidad,
      this.metro,
      this.idMunicipio,
      this.noFactura,
      this.description,
      this.pagado,
      this.saldo,
      this.amount,
      this.bankCode,
      this.bankDebitDetail,
      this.branch,
      this.clientId,
      this.currency,
      this.fundingSourceUuid,
      this.invoiceEz,
      this.last4,
      this.merchantAlias,
      this.merchantAvatar,
      this.metadata,
      this.owner,
      this.paymentServiceId,
      this.period,
      this.privuse2,
      this.rc04,
      this.totalAmount,
      this.transactionCode,
      this.transactionCreatedAt,
      this.transactionDenom,
      this.transactionDescription,
      this.transactionId,
      this.transactionSignature,
      this.transactionStatus,
      this.transactionStatusCode,
      this.transactionUuid,
      this.username,
      this.charged,
      this.consumption,
      this.discount,
      this.folio,
      this.invoiceDate,
      this.month,
      this.route,
      this.tomo,
      this.year,
      this.status,
      this.statusCode,
      this.accountId})
      : super(
          name: name,
          libro: libro,
          importe: importe,
          code: code,
          gasConsumption: gasConsumption,
          postVenta: postVenta,
          municipio: municipio,
          cobrador: cobrador,
          datosContrato: datosContrato,
          mensualidad: mensualidad,
          metro: metro,
          idMunicipio: idMunicipio,
          noFactura: noFactura,
          description: description,
          pagado: pagado,
          saldo: saldo,
          lectura: lectura,
          amount: amount,
          bankCode: bankCode,
          bankDebitDetail: bankDebitDetail,
          branch: branch,
          clientId: clientId,
          currency: currency,
          fundingSourceUuid: fundingSourceUuid,
          invoiceEz: invoiceEz,
          last4: last4,
          merchantAlias: merchantAlias,
          merchantAvatar: merchantAvatar,
          metadata: metadata,
          owner: owner,
          paymentServiceId: paymentServiceId,
          period: period,
          privuse2: privuse2,
          rc04: rc04,
          totalAmount: totalAmount,
          transactionCode: transactionCode,
          transactionCreatedAt: transactionCreatedAt,
          transactionDenom: transactionDenom,
          transactionDescription: transactionDescription,
          transactionId: transactionId,
          transactionSignature: transactionSignature,
          transactionStatus: transactionStatus,
          transactionStatusCode: transactionStatusCode,
          transactionUuid: transactionUuid,
          username: username,
          folio: folio,
          route: route,
          month: month,
          year: year,
          charged: charged,
          invoiceDate: invoiceDate,
          discount: discount,
          consumption: consumption,
          status: status,
          statusCode: statusCode,
          accountId: accountId,
        );

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      name: getValueFrom("Nombre", json, ""),
      libro: getValueFrom("Libro", json, ""),
      importe: getValueFrom("Importe", json, ""),
      code: getValueFrom("Codigo", json, ""),
      lectura: getValueFrom("Lectura", json, ""),
      gasConsumption: getValueFrom("Consumo", json, ""),
      postVenta: getValueFrom("postventa", json, ""),
      municipio: getValueFrom("Municipio", json, ""),
      cobrador: getValueFrom("Cobrador", json, ""),
      datosContrato: getValueFrom("DatosContrato", json, ""),
      mensualidad: getValueFrom(
        "Mensualidad",
        json,
        DateTime.now(),
        reader: (key, data, defaultValue) {
          return json.containsKey(key) &&
                  json[key] != null &&
                  json[key] is String
              ? DateTime.parse(json["Mensualidad"].toString().substring(0, 19))
              : defaultValue;
        },
      ),
      metro: getValueFrom("Metro", json, null),
      idMunicipio: getValueFrom("IdMunicipio", json, null),
      noFactura: getValueFrom("NoFactura", json, ""),
      description: getValueFrom("Descripcion", json, ""),
      pagado: getValueFrom("Pagado", json, null),
      saldo: getValueFrom("Saldo", json, null),
      amount: getValueFrom(
        "amount",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is double) {
            return (json[key].toString());
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is int) {
            return (json[key].toString());
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            return (json[key].toString());
          } else {
            return defaultValue;
          }
        },
      ),
      bankCode: getValueFrom(
        "bank_code",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is int) {
            return json[key].toString();
          } else {
            return defaultValue;
          }
        },
      ),
      bankDebitDetail: getValueFrom(
        "bank_debit_detail",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            String data = json[key];
            List<String> keyValuePairs =
                data.replaceAll('{', '').replaceAll('}', '').split(',');
            Map<String, dynamic> map = {};
            for (String pair in keyValuePairs) {
              // Dividir cada par clave-valor por el signo de dos puntos
              List<String> entry = pair.split(':');

              // Eliminar las comillas de la clave y el valor y agregarlas al mapa
              map[entry[0].trim().replaceAll("'", "")] =
                  entry[1].trim().replaceAll("'", "");
            }
            log(map.toString());
            return BankDebitDetailModel.fromJson(map);
          } else {
            return defaultValue;
          }
        },
      ),
      branch: getValueFrom("branch", json, null),
      clientId: getValueFrom(
        "client_id",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            int? number = int.tryParse(json[key]);
            return number;
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is int) {
            return json[key];
          } else {
            return defaultValue;
          }
        },
      ),
      currency: getValueFrom("currency", json, ""),
      fundingSourceUuid: getValueFrom("funding_source_uuid", json, ""),
      invoiceEz: getValueFrom("invoice_ez", json, ""),
      last4: getValueFrom(
        "last4",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is int) {
            return json[key].toString();
          } else {
            return defaultValue;
          }
        },
      ),
      merchantAlias: getValueFrom("merchant_alias", json, ""),
      merchantAvatar: getValueFrom("merchant_avatar", json, ""),
      metadata: getValueFrom(
        "metadata",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            String jsonString = json[key];
            Map<String, dynamic> mapa = jsonDecode(jsonString);
            return mapa;
          }
          return null;
        },
      ),
      owner: getValueFrom("owner", json, ""),
      paymentServiceId: getValueFrom(
        "payment_service_id",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is int) {
            return json[key].toString();
          } else {
            return defaultValue;
          }
        },
      ),
      period: getValueFrom("period", json, ""),
      privuse2: getValueFrom("privuse2", json, ""),
      rc04: getValueFrom("rc04", json, ""),

      totalAmount: getValueFrom(
        "total_amount",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            double toInt = double.parse(json[key]);
            return toInt;
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is double) {
            return json[key];
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is int) {
            int numero = json[key];
            double toDouble = double.parse('$numero');
            return toDouble;
          }
          return null;
        },
      ),
      transactionCode: getValueFrom("transaction_code", json, null),
      transactionCreatedAt: getValueFrom(
        "transaction_created_at",
        json,
        DateTime.now(),
        reader: (key, data, defaultValue) {
          return json.containsKey(key) &&
                  json[key] != null &&
                  json[key] is String
              ? DateTime.parse(
                  json["transaction_created_at"].toString().substring(0, 19))
              : defaultValue;
        },
      ),
      // transactionCreatedAt:  DateTime.parse(json["transaction_created_at"].toString().substring(0,19)) ,
      transactionDenom: getValueFrom("transaction_denom", json, ""),
      transactionDescription: getValueFrom("transaction_description", json, ""),
      transactionId: getValueFrom(
        "transaction_id",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            return json[key] as int;
          } else {
            return json[key];
          }
        },
      ),
      transactionSignature: getValueFrom("transaction_signature", json, ""),
      transactionStatus: getValueFrom("transaction_status", json, ""),
      transactionStatusCode: getValueFrom("transaction_status_code", json, 1),
      transactionUuid: getValueFrom("transaction_uuid", json, ""),
      username: getValueFrom("username", json, ""),
      folio: getValueFrom("folio", json, ""),
      route: getValueFrom("route", json, ""),
      month: getValueFrom("month", json, ""),
      year: getValueFrom("year", json, ""),
      charged: getValueFrom(
        "charged",
        json,
        "",
      ),
      invoiceDate: getValueFrom(
        "invoice_date",
        json,
        "",
      ),
      discount: getValueFrom("discount", json, ""),
      consumption: getValueFrom("consumption", json, ""),
    );
  }
  factory InvoiceModel.fromEtecsa(Map<String, dynamic> json) {
    return InvoiceModel(
      amount: getValueFrom(
        "amount",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is double) {
            return (json[key].toString());
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is int) {
            return (json[key].toString());
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            return (json[key].toString());
          } else {
            return defaultValue;
          }
        },
      ),
      bankCode: getValueFrom(
        "bank_code",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is int) {
            return json[key].toString();
          } else {
            return defaultValue;
          }
        },
      ),
      bankDebitDetail: getValueFrom(
        "bank_debit_detail",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            String data = json[key];
            List<String> keyValuePairs =
                data.replaceAll('{', '').replaceAll('}', '').split(',');
            Map<String, dynamic> map = {};
            for (String pair in keyValuePairs) {
              // Dividir cada par clave-valor por el signo de dos puntos
              List<String> entry = pair.split(':');

              // Eliminar las comillas de la clave y el valor y agregarlas al mapa
              map[entry[0].trim().replaceAll("'", "")] =
                  entry[1].trim().replaceAll("'", "");
            }
            log(map.toString());
            return BankDebitDetailModel.fromJson(map);
          } else {
            return defaultValue;
          }
        },
      ),
      branch: getValueFrom("branch", json, null),
      clientId: getValueFrom(
        "client_id",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            int? number = int.tryParse(json[key]);
            return number;
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is int) {
            return json[key];
          } else {
            return defaultValue;
          }
        },
      ),
      currency: getValueFrom("currency", json, ""),
      fundingSourceUuid: getValueFrom("funding_source_uuid", json, ""),
      invoiceEz: getValueFrom("invoice_ez", json, ""),
      last4: getValueFrom(
        "last4",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is int) {
            return json[key].toString();
          } else {
            return defaultValue;
          }
        },
      ),
      merchantAlias: getValueFrom("merchant_alias", json, ""),
      merchantAvatar: getValueFrom("merchant_avatar", json, ""),
      metadata: getValueFrom(
        "metadata",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            String jsonString = json[key];
            Map<String, dynamic> mapa = jsonDecode(jsonString);
            return mapa;
          }
          return null;
        },
      ),
      owner: getValueFrom("owner", json, ""),
      paymentServiceId: getValueFrom(
        "payment_service_id",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is int) {
            return json[key].toString();
          } else {
            return defaultValue;
          }
        },
      ),
      period: getValueFrom("period", json, ""),
      privuse2: getValueFrom("privuse2", json, ""),
      rc04: getValueFrom("rc04", json, ""),

      totalAmount: getValueFrom(
        "total_amount",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            double toInt = double.parse(json[key]);
            return toInt;
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is double) {
            return json[key];
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is int) {
            int numero = json[key];
            double toDouble = double.parse('$numero');
            return toDouble;
          }
          return null;
        },
      ),
      transactionCode: getValueFrom("transaction_code", json, null),
      transactionCreatedAt: getValueFrom(
        "transaction_created_at",
        json,
        DateTime.now(),
        reader: (key, data, defaultValue) {
          return json.containsKey(key) &&
                  json[key] != null &&
                  json[key] is String
              ? DateTime.parse(
                  json["transaction_created_at"].toString().substring(0, 19))
              : defaultValue;
        },
      ),
      // transactionCreatedAt:  DateTime.parse(json["transaction_created_at"].toString().substring(0,19)) ,
      transactionDenom: getValueFrom("transaction_denom", json, ""),
      transactionDescription: getValueFrom("transaction_description", json, ""),
      transactionId: getValueFrom(
        "transaction_id",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            return json[key] as int;
          } else {
            return json[key];
          }
        },
      ),
      transactionSignature: getValueFrom("transaction_signature", json, ""),
      transactionStatus: getValueFrom("transaction_status", json, ""),
      transactionStatusCode: getValueFrom("transaction_status_code", json, 1),
      transactionUuid: getValueFrom("transaction_uuid", json, ""),
      username: getValueFrom("username", json, ""),
      folio: getValueFrom("folio", json, ""),
      route: getValueFrom("route", json, ""),
      month: getValueFrom("month", json, ""),
      year: getValueFrom("year", json, ""),
      charged: getValueFrom(
        "charged",
        json,
        "",
      ),
      invoiceDate: getValueFrom(
        "invoice_date",
        json,
        "",
      ),
      discount: getValueFrom("discount", json, ""),
      consumption: getValueFrom("consumption", json, ""),
    );
  }

  factory InvoiceModel.fromXml(
          XmlElement element, InvoiceModel Function(XmlElement el) process) =>
      process(element);

  @override
  static T getValueFrom<T>(
    String key,
    Map<dynamic, dynamic> json,
    T defaultValue, {
    JsonReader<T>? reader,
  }) {
    return EntityModel.getValueFromJson<T>(
      key,
      json,
      defaultValue,
      reader: reader,
    );
  }

  @override
  Map<String, dynamic> toJson() => {};

  @override
  Map<String, String> getColumnNames() {
    return {"id_invoice": "ID"};
  }

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return InvoiceList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return InvoiceList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return InvoiceList.fromJson({});
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    //Map<String, String> colNames = getColumnNames();
    metaModel = metaModel ??
        {
          //TODO Declare here all ColumnMetaModel. you can use class implementation of class "DefaultColumnMetaModel".
        };
    int index = 0;
    metaModel!.forEach((key, value) {
      value.setColumnIndex(index++);
    });
    return metaModel!;
  }

  @override
  List<String> getColumnNamesList() {
    return getColumnNames().values.toList();
  }

  StreamController<EntityModel> getController({
    void Function()? onListen,
    void Function()? onPause,
    void Function()? onResume,
    FutureOr<void> Function()? onCancel,
  }) {
    return EntityModel.getController(
        entity: this,
        onListen: onListen,
        onPause: onPause,
        onResume: onResume,
        onCancel: onCancel);
  }

  @override
  Map<K1, V1> getMeta<K1, V1>(String searchKey, dynamic searchValue) {
    final Map<K1, V1> result = {};
    getColumnMetaModel().map<K1, V1>((key, value) {
      MapEntry<K1, V1> el = MapEntry(value.getDataIndex() as K1, value as V1);
      if (value[searchKey] == searchValue) {
        result.putIfAbsent(value.getDataIndex() as K1, () {
          return value as V1;
        });
      }
      return el;
    });
    return result;
  }

  @override
  Map<String, String> getVisibleColumnNames() {
    Map<String, String> names = {};
    getMeta<String, ColumnMetaModel>("visible", true)
        .map<String, String>((key, value) {
      names.putIfAbsent(key, () => value.getColumnName());
      return MapEntry(key, value.getColumnName());
    });
    return names;
    // throw UnimplementedError();
  }

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, dynamic valueSearch, dynamic newValue) {
    Map<String, ColumnMetaModel> tmp = getColumnMetaModel();
    getMeta<String, ColumnMetaModel>(keySearch, valueSearch)
        .map<String, ColumnMetaModel>((key, value) {
      tmp.putIfAbsent(key, () => value);
      return MapEntry(key, value);
    });
    return metaModel = tmp;
  }

  @override
  Map<String, ColumnMetaModel>? metaModel;

  @override
  // TODO: implement getMetaModel
  Map<String, ColumnMetaModel>? get getMetaModel => throw UnimplementedError();
}
