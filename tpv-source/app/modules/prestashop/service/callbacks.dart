// ignore_for_file: prefer_function_declarations_over_variables

import 'package:get/get.dart';
import 'package:xml/xml.dart';

import '/app/core/interfaces/entity_model.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/paths_service.dart';
import '/app/modules/order/controllers/order_controller.dart';
import '/app/modules/order/domain/models/order_model.dart';
import '/app/modules/prestashop/domain/models/orderhistory_model.dart';
import '/app/modules/prestashop/service/presta_shop_order_state_web_service.dart';
import '/app/modules/prestashop/service/presta_shop_web_service.dart';
import '/app/modules/prestashop/service/query.dart';
import '/app/modules/qrcode/controllers/qrcode_controller.dart';

class CallBackPrestaShopFunction {
  static Future<EntityModelList<OrderModel>> Function(
          ApiPrestaShopWebService<XmlDocument>, String)? getOrders =
      (api, url) async {
    OrderList<OrderModel> orderList = OrderList<OrderModel>.fromJson({});
    final qrctl = Get.find<QrCodeController>();
    final orderCtl = Get.find<OrderController>();
    final onError = () {
      return Future.value(OrderList.fromJson({}));
    };

    final res = await EntityModelList.getJsonFromXMLUrl(url,
        (XmlDocument response) async {
      final orders = response.findAllElements("order");
      if (orders.isNotEmpty) {
        bool exit = false;
        for (var order in orders) {
          if (exit) break;
          final idOrder = order.getElement("id")!.value;
          final addressDelivery = await PrestaShopAddressWebService.getAddress(
              api,
              order
                  .getElement("id_address_delivery")!
                  .getAttribute("xlink:href")!);
          final addressInvoice = await PrestaShopAddressWebService.getAddress(
            api,
            order.getElement("id_address_invoice")!.getAttribute("xlink:href")!,
          );
          addressInvoice.toString();
          final status = await PrestaShopOrderStateWebService.getStatus(api,
              order.getElement("current_state")!.getAttribute("xlink:href")!);

          final customer = await PrestaShopCustomerWebService.getCustomer(api,
              order.getElement("id_customer")!.getAttribute("xlink:href")!);

          var qrCode = "";

          final qr = await qrctl.addQrCode.setParamsFromMap({
            "information": {
              "idOrden": idOrder,
              "beneficiario": addressDelivery.getBeneficiary(),
              "idCliente": customer.id,
              "cliente": "${customer.firstName} ${customer.lastName}",
              "usuario": customer.userName,
              "correo": customer.email,
              "direccionEntrega": addressDelivery.address,
              "estado": status.status,
              "color": status.color
            }.toString(),
            "userName": customer.userName,
          }).call(null);

          qr.fold((l) {
            exit = true;
            log(l.toString());
          }, (qrModel) async {
            qrCode = PathsService.qrUrlService + qrModel.getImageUrlService();
            final order = OrderModel.fromJson({
              "id": idOrder,
              "idOrder": idOrder,
              "userName": customer.userName,
              "address": addressDelivery.address,
              "status": status.status,
              "qrCode": qrCode,
            });
            final orderCreated = await orderCtl.addOrder
                .setParamsFromMap(order.toJson())
                .call(null);
            orderCreated.fold((l) {
              log(l.toString());
            }, (orderAdded) {
              orderList.add(orderAdded);
              log("Orden ${orderAdded.idOrder} creada.");
            });
          });
        }
      }
      return Future.value(orderList);
    }, onError);

    return res;
  };

  // update OrderCallBack
  static Future<OrderHistoryModel> Function(
          ApiPrestaShopWebService<XmlDocument>, PrestaShopQuery, String)?
      updateOrderHistoryState = (api, query, url) async {
    return Future.value(OrderHistoryModel.fromJson({}));
  };
}
