import '/app/core/interfaces/entity_model.dart';
import '/app/modules/order/domain/entities/beneficiary.dart';

class Order {
  final String id;
  final String idOrder;
  final String? pin;
  final String address;
  final String status;
  final String? qrCode;
  final String? userName;
  final Beneficiary? beneficiary;
  final String? merchantUrl;
  final String? credential;
  final String? driver;

  final EntityModelList<EntityModel> orderDetail;

  Order({
    required this.id,
    required this.idOrder,
    required this.address,
    required this.orderDetail,
    required this.status,
    this.merchantUrl,
    this.credential,
    this.driver,
    this.qrCode,
    this.beneficiary,
    this.pin,
    this.userName,
  });
}
