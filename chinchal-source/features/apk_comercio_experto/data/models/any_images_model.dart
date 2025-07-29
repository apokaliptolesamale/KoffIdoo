// // ignore_for_file: overridden_fields

import 'dart:convert';

import 'package:apk_template/features/apk_comercio_experto/domain/entities/entities.dart';




ListAnyImagesModel anyImageModelFromJson(String str) => ListAnyImagesModel.fromJson(json.decode(str));

String anyImagesModelToJson(ListAnyImagesModel data) => json.encode(data.toJson());

class ListAnyImagesModel extends AnyImageModel {
  
final List<AnyImageModel>? content;
    

    ListAnyImagesModel({
        this.content,
        
    });

    factory ListAnyImagesModel.fromJson(Map<String, dynamic> json) => ListAnyImagesModel(
        content: List<AnyImageModel>.from(json["content"].map((x) => AnyImageModel.fromJson(x))),
        
    );
    factory ListAnyImagesModel.fromStringJson(String strJson) =>
      ListAnyImagesModel.fromJson(json.decode(strJson));
    
    @override
  Map<String, dynamic> toJson() => {
        "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
        
    };
}

class AnyImageModel implements AnyImageEntity {
  @override
  String? alt;

  @override
  String? id;

  @override
  String? imageDescription;

  @override
  String? imageURL;

  @override
  String? title;
  AnyImageModel(
      {
      this.alt,
      this.id,
      this.imageDescription,
      this.imageURL,
      this.title
      });

  factory AnyImageModel.fromRawJson(String str) =>
      AnyImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnyImageModel.fromJson(Map<String, dynamic> json) => AnyImageModel(
        id: json['id'] ?? '',
        imageDescription: json['imageDescription'] ?? "Sin imagen",
        imageURL: json['imageURL'] ?? "Sin url",
        title: json['title'] ?? "Desconocido",
        alt: json['alt'] ?? "Desconocido",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageDescription': imageDescription,
        'imageURL': imageURL,
        'title': title,
        'alt': alt,
      };
}













































// AnyImageList anyImageListModelFromJson(String str) =>
//     AnyImageList.fromJson(json.decode(str));

// AnyImageModel anyImageModelFromJson(String str) =>
//     AnyImageModel.fromJson(json.decode(str));

// String anyImageModelToJson(AnyImageModel data) => json.encode(data.toJson());

// class AnyImageList<T extends AnyImageModel> implements EntityModelList<T> {
//   final List<T> anyImages;
//   @override
//   EntityMod<T> addAll(EntityModelList<T> newItems) {
//     anyImages.addAll(newItems.getList());
//     return this;
//   }

//   AnyImageList({
//     required this.anyImages,
//   });

//   factory AnyImageList.fromJson(Map<String, dynamic> json) {
//     /*if (json.containsKey("anyImage") && json["anyImage"] == null) {
//       log("json.containsKey('anyImage') AND ${json.toString()}");
//     }*/
//     return AnyImageList(
//       anyImages: json.containsKey("anyImage") && json["anyImage"] != null
//           ? List<T>.from(json["anyImage"].map((x) => AnyImageModel.fromJson(x)))
//           : [],
//     );
//   }

//   factory AnyImageList.fromStringJson(String strJson) => AnyImageList(
//         anyImages: List<T>.from(json
//             .decode(strJson)["anyImage"]
//             .map((x) => AnyImageModel.fromJson(x))),
//       );

//   @override
//   int get getTotal => getList().length;

//   @override
//   EntityModelList<T> add(T element) => fromList(getList()..add(element));

//   @override
//   EntityModelList<T> fromJson(Map<String, dynamic> json) {
//     return AnyImageList.fromJson(json);
//   }

//   @override
//   EntityModelList<T> fromList(List<T> list) {
//     for (var element in list) {
//       if (!anyImages.contains(element)) anyImages.add(element);
//     }
//     return this;
//   }

//   @override
//   EntityModelList<T> fromStringJson(String strJson) {
//     return AnyImageList.fromStringJson(strJson);
//   }
// elList
//   @override
//   List<T> getList() => anyImages;

//   @override
//   EntityModelList<T> remove(T element) {
//     anyImages.remove(element);
//     return this;
//   }

//   Map<String, dynamic> toJson() => {
//         "anyImage": List<dynamic>.from(anyImages.map((x) => x.toJson())),
//       };
// }

// class AnyImageModel extends AnyImage implements EntityModel {
//   @override
//   Map<String, ColumnMetaModel>? metaModel;

//   @override
//   bool? selected;
//   @override
//   String getColumnIdName() {
//     return "id";
//   }

//   @override
//   dynamic getId() {
//     return id;
//   }

//   @override
//   String id;
//   @override
//   String imageDescription;

//   @override
//   String imageURL;

//   @override
//   String title;

//   @override
//   String alt;

//   AnyImageModel({
//     this.id = "",
//     this.imageDescription = "Sin imagen",
//     this.imageURL = "Sin url",
//     this.alt = "Desconocido",
//     this.title = "Desconocido",
//   }) : super(
//           id: id,
//           alt: alt,
//           imageDescription: imageDescription,
//           imageURL: imageURL,
//           title: title,
//         );

//   factory AnyImageModel.fromJson(Map<String, dynamic> json) => AnyImageModel(
//         id: json["idImage"],
//         alt: EntityModel.getValueFromJson("alt", json, "ENTALLA"),
//         imageDescription: EntityModel.getValueFromJson(
//             "imageDescription", json, "Sin descripción"),
//         imageURL: EntityModel.getValueFromJson(
//             "imageURL", json, ASSETS_IMAGES_ICONS_APP_CARRITO_PNG),
//         title: EntityModel.getValueFromJson("title", json, "Sin título"),
//       );
//   @override
//   Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();
//   @override
//   bool get isSelected => selected ?? false;

//   List<Object?> get props => [];

//   @override
//   set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
//     metaModel = newMetaModel;
//   }

//   bool? get stringify => true;

//   //method generated by wizard
//   T cloneWith<T extends EntityModel>(T other) {
//     return AnyImageModel.fromJson(other.toJson()) as T;
//   }

//   @override
//   EntityModelList createModelListFrom(dynamic data) {
//     try {
//       if (data is Map) {
//         return AnyImageList.fromJson(data as Map<String, dynamic>);
//       }
//       if (data is String) {
//         return AnyImageList.fromStringJson(data);
//       }
//     } on Exception {
//       log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
//     }
//     return AnyImageList.fromJson({});
//   }

//   T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
//     return AnyImageModel.fromJson(params) as T;
//   }

//   @override
//   Map<String, ColumnMetaModel> getColumnMetaModel() {
//     try {
//       //Map<String, String> colNames = getColumnNames();
//       metaModel = metaModel ??
//           {
//             //TODO Declare here all ColumnMetaModel. you can use class implementation of class "DefaultColumnMetaModel".
//           };
//       int index = 0;
//       metaModel!.forEach((key, value) {
//         value.setColumnIndex(index++);
//       });
//       return metaModel!;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   @override
//   Map<String, String> getColumnNames() {
//     return {
//       "id": "Id AnyImageo",
//       "idOrder": "Id de Orden",
//       "name": "Nombre",
//       "description": "Descripción",
//       "images": "Imágenes",
//     };
//   }

//   @override
//   List<String> getColumnNamesList() {
//     return getColumnNames().values.toList();
//   }

//   StreamController<EntityModel> getController({
//     void Function()? onListen,
//     void Function()? onPause,
//     void Function()? onResume,
//     FutureOr<void> Function()? onCancel,
//   }) {
//     return EntityModel.getController(
//       entity: this,
//       onListen: onListen,
//       onPause: onPause,
//       onResume: onResume,
//       onCancel: onCancel,
//     );
//   }

//   @override
//   Map<K1, V1> getMeta<K1, V1>(String searchKey, dynamic searchValue) {
//     try {
//       final Map<K1, V1> result = {};
//       getColumnMetaModel().map<K1, V1>((key, value) {
//         MapEntry<K1, V1> el = MapEntry(value.getDataIndex() as K1, value as V1);
//         if (value[searchKey] == searchValue) {
//           result.putIfAbsent(value.getDataIndex() as K1, () {
//             return value as V1;
//           });
//         }
//         return el;
//       });
//       return result;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   @override
//   Map<String, String> getVisibleColumnNames() {
//     try {
//       Map<String, String> names = {};
//       getMeta<String, ColumnMetaModel>("visible", true)
//           .map<String, String>((key, value) {
//         names.putIfAbsent(key, () => value.getColumnName());
//         return MapEntry(key, value.getColumnName());
//       });
//       return names;
//       // throw UnimplementedError();
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   @override
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "alt": alt,
//         "imageDescription": imageDescription,
//         "imageURL": imageURL,
//         "title": title,
//       };

//   @override
//   Map<String, ColumnMetaModel> updateColumnMetaModel(
//       String keySearch, dynamic valueSearch, dynamic newValue) {
//     try {
//       Map<String, ColumnMetaModel> tmp = getColumnMetaModel();
//       getMeta<String, ColumnMetaModel>(keySearch, valueSearch)
//           .map<String, ColumnMetaModel>((key, value) {
//         tmp.putIfAbsent(key, () => value);
//         return MapEntry(key, value);
//       });
//       return metaModel = tmp;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   static T? getValueFrom<T>(
//       String key, Map<dynamic, dynamic> json, T? defaultValue,
//       {JsonReader<T?>? reader}) {
//     return EntityModel.getValueFromJson<T?>(key, json, defaultValue,
//         reader: reader);
//   }
// }
