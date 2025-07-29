import '/app/modules/prestashop/domain/entities/customer.dart';

class Address {
  dynamic idAddress, idCountry, idState;
  String alias, address, city;
  String? postcode;
  DateTime createAt;
  DateTime? updateAt;

  Customer custormer;

  Address({
    required this.alias,
    required this.city,
    required this.address,
    required this.createAt,
    required this.custormer,
    this.updateAt,
    this.postcode,
    this.idAddress,
    this.idCountry,
    this.idState,
  });
}
