class OrderDetail {
  final int? idOrderDetail, idOrder, idProduct;
  final String? productName;
  final int? productQuantity;
  final double? productPrice;

  OrderDetail({
    this.idOrderDetail,
    this.idOrder,
    this.idProduct,
    this.productName,
    this.productPrice,
    this.productQuantity,
  });
}
