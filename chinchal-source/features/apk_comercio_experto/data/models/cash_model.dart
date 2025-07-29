import 'package:apk_template/features/apk_comercio_experto/domain/entities/cash_entity.dart';

class CashModel extends CashEntity {
  @override
  final String imagePath;
  @override
  final int cantidad;
  @override
  final int valor;
  CashModel(
      {required this.imagePath, required this.cantidad, required this.valor})
      : super(imagePath: '', cantidad: 0, valor: 0);

  factory CashModel.fromMap(Map<String, dynamic> map) {
    return CashModel(
      cantidad: map['cantidad'],
      imagePath: map['image_path'],
      valor: map['valor'],
    );
  }

  // Convertir de objeto a mapa (SQLite)
  Map<String, dynamic> toMap() {
    return {
      'cantidad': cantidad,
      'image_path': imagePath,
      'valor': valor,
    };
  }
    factory CashModel.fromJson(Map<String, dynamic> json) {
    return CashModel(
      imagePath: json['image_path'] as String,
      cantidad: json['cantidad'] as int,
      valor: json['valor'] as int,
    );
  }

  // Convertir CashModel a JSON (mapa)
  Map<String, dynamic> toJson() {
    return {
      'image_path': imagePath,
      'cantidad': cantidad,
      'valor': valor,
    };
  }
    CashModel copyWith({
    String? imagePath,
    int? cantidad,
    int? valor,
  }) {
    return CashModel(
      imagePath: imagePath ?? this.imagePath,
      cantidad: cantidad ?? this.cantidad,
      valor: valor ?? this.valor,
    );
  }

}








