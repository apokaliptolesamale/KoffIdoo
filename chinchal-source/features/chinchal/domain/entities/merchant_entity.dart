class MerchantEntity{
  final String? address;
    final String? banco;
    final String? categoriaComercial;
    final String? code;
    final String? createdAt;
    final String? email;
    final String? firstNumber;
    final String? last4Number;
    final String? latitude;
    final String? longitude;
    final String? moneda;
    final String? name;
    final String? phone;
    final String? provincia;
    final String? receiveCode;
    final String? role;
    final String? typoAccount;
    final Map<String,dynamic>? typoMerchant;
    final String? username;
    final String? uuid;
    final bool? isSelect;

    MerchantEntity({
        this.address,
        this.banco,
        this.categoriaComercial,
        this.code,
        this.createdAt,
        this.email,
        this.firstNumber,
        this.last4Number,
        this.latitude,
        this.longitude,
        this.moneda,
        this.name,
        this.phone,
        this.provincia,
        this.receiveCode,
        this.role,
        this.typoAccount,
        this.typoMerchant,
        this.username,
        this.uuid,
        this.isSelect
    });
}