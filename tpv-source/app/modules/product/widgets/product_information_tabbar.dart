// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/app/core/config/assets.dart';
import '/app/core/constants/style.dart';
import '/app/core/helpers/functions.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/paths_service.dart';
import '/app/modules/product/domain/models/beneficiary_model.dart';
import '/app/modules/product/domain/models/product_model.dart';
import '/app/modules/product/domain/models/role_model.dart';
import '/app/widgets/components/pdf_viewer.dart';
import '/app/widgets/panel/qr_panel.dart';
import '/app/widgets/utils/custom_datetime_converter.dart';
import '/app/widgets/utils/size_constraints.dart';
import '../../../widgets/components/access_on_tap.dart';
import '../../order/controllers/order_controller.dart';
import '../../warranty/controllers/warranty_controller.dart';

class ProductTabInformation extends StatefulWidget {
  final TabController tabController;
  State<ProductTabInformation>? _state;
  final ProductModel product;
  ProductTabInformation({
    Key? key,
    required this.tabController,
    required this.product,
  }) : super(key: key);
  State<ProductTabInformation> get getState => _state ?? createState();
  @override
  State<ProductTabInformation> createState() =>
      _state = _state ?? _ProductTabInformationState();
}

class _ProductTabInformationState extends State<ProductTabInformation>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController tabController;
  late ProductModel product;
  bool isTransportista = RoleModel.instance.isTransportista();
  int index = 0;
  BeneficiaryModel? beneficiary;

  Map<String, dynamic> orderPayLoad = {};
  Map<String, dynamic> warrantyPayLoad = {};

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
    final size = SizeConstraints(context: context);

    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TabBar(
              controller: widget.tabController,
              automaticIndicatorColorAdjustment: true,
              enableFeedback: true,
              unselectedLabelColor: Colors.lightBlue[100],
              overlayColor: MaterialStateProperty.all<Color>(
                  Color(0xFF00b1a4).withOpacity(0.2)),
              onTap: (index) {},
              tabs: <Widget>[
                //if (!RoleModel.instance.isTransportista())
                Tab(
                  child: Text(
                    "Garantía",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Producto",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                //if (!RoleModel.instance.isCliente())
                Tab(
                  child: Text(
                    "Beneficiario",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              height: size.getHeightByPercent(30, vheight: 30, hwidth: 40),
              child: TabBarView(
                controller: widget.tabController,
                children: <Widget>[
                  //if (!isTransportista)
                  /*Text(
                    "Garantía completa por un período de 3 años",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )*/
                  _warrantyDetail(context),
                  _productDetail(context),
                  _beneficiaryDetail(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    //
    //tabController.dispose();
    super.dispose();
  }

  Widget getQrWindowAcceptBotton(Function() handler) {
    return Container(
      height: 40,
      width: 250,
      margin: EdgeInsets.only(top: 30),
      child: MaterialButton(
        onPressed: handler,
        shape: StadiumBorder(),
        color: aceptBottonColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3.0,
          ),
          child: Text(
            "Aceptar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = widget.tabController;
    tabController.addListener(_handleTabSelection);
    product = widget.product;
    orderPayLoad = product.getOrderPayLoad;
    warrantyPayLoad = product.getWarrantyPayLoad;

    beneficiary = orderPayLoad.containsKey("beneficiary")
        ? BeneficiaryModel.fromJson(orderPayLoad["beneficiary"])
        : beneficiary;
    index = tabController.index;
    if (product.getOrderPayLoad.isEmpty) {
      final ctl = Get.find<OrderController>();
      ctl.getOrder
          .setParamsFromMap({
            "id": product.idOrderService,
          })
          .call(null)
          .then((value) => value.fold((failure) {
                log(failure.message);
              }, (order) {
                setState(() {
                  product.setOrderPayLoad(order.toJson());
                });
              }));
    }
    if (product.hasWarranty && product.getWarrantyPayLoad.isEmpty) {
      final ctl = Get.find<WarrantyController>();
      ctl.getWarranty
          .setParamsFromMap({
            "id": product.idWarranty,
          })
          .call(null)
          .then((value) => value.fold((failure) {
                log(failure.message);
              }, (warranty) {
                setState(() {
                  product.setWarrantyPayLoad(warranty.toJson());
                });
              }));
    }
  }

  Text _beneficiaryDetail(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: "Beneficiario del producto : ",
          style: TextStyle(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text:
                  "${beneficiary != null ? beneficiary!.getFullName : ''}\n\n",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: "Dirección del beneficiario : ",
            ),
            TextSpan(
              text:
                  "${beneficiary != null ? beneficiary!.addressBeneficiary : 'Sin dirección del beneficiario.'}\n",
              style: TextStyle(fontWeight: FontWeight.normal),
            )
          ]),
    );
  }

  _handleTabSelection() {
    setState(() {
      index = tabController.index;
    });
  }

  Widget _productDetail(BuildContext context) {
    //final size = SizeConstraints(context: context);

    final urlQrOrder = product.getOrderPayLoad.isNotEmpty &&
            product.getOrderPayLoad.containsKey("qrCode")
        ? "${PathsService.qrUrlService}${product.getOrderPayLoad['qrCode'].toString().replaceFirst("/", "")}"
        : "";
    final urlQr = product.qrCode != null && product.qrCode!.isNotEmpty
        ? "${PathsService.qrUrlService}${product.qrCode.toString().replaceFirst("/", "")}"
        : "";
    log("Qr del producto=>$urlQr");
    log("Qr de la orden=>$urlQrOrder");
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "${product.name}: ${product.shortDescription}",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrPanel(
                title: "QR del producto",
                context: context,
                description:
                    "Utilice el Qr para agilizar el proceso de lectura de información del producto.",
                urlQr: urlQr,
                handler: (panel, ctl) {
                  Navigator.pop(ctl);
                },
                logo: ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG,
              ),
              QrPanel(
                title: "QR de la orden",
                context: context,
                description:
                    "Utilice el Qr para agilizar el proceso de lectura de información de la orden.",
                urlQr: urlQrOrder,
                handler: (panel, ctl) {
                  Navigator.pop(ctl);
                },
                logo: ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _warrantyDetail(BuildContext context) {
    warrantyPayLoad =
        warrantyPayLoad.isEmpty ? product.getWarrantyPayLoad : warrantyPayLoad;
    final short = EntityModel.getValueFromJson;
    final id = short("warrantyId", warrantyPayLoad, "");
    final code = short("code", warrantyPayLoad, "");
    final qr = removeLast(PathsService.qrUrlService) +
        short("qrWarranty", warrantyPayLoad, "");
    log("Qr de la garantía=>$qr");
    final time =
        CustomDateTimeConverter.from(short("time", warrantyPayLoad, ""));
    final article = short("article", warrantyPayLoad, "");
    final mark = short("mark", warrantyPayLoad, "");
    final model = short("model", warrantyPayLoad, "");
    /*final tradeName = short("tradeName", warrantyPayLoad, "");
    final paymentType = short("paymentType", warrantyPayLoad, "");
    final clientName = short("clientName", warrantyPayLoad, "");

    final ci = short("ci", warrantyPayLoad, "");*/

    return warrantyPayLoad.isEmpty
        ? Text("El producto no tiene información de garantía asociada.")
        : Column(children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 5),
                color: aceptBottonColor.withOpacity(0.04),
                child: ListTile(
                  title: Text(
                    "Datos generales de la garantía\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Column(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 0,
                                left: 0,
                                right: 15,
                              ),
                              child: QrPanel(
                                title: "QR",
                                context: context,
                                description:
                                    "Utilice el Qr para agilizar el proceso de lectura de información de la orden.",
                                urlQr: qr,
                                handler: (panel, ctl) {
                                  Navigator.of(ctl).pop();
                                },
                                logo:
                                    ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG,
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            child: AccessOnTapWidget(
                              onTapColor: Colors.teal.withOpacity(0.3),
                              onTapDown: (detail) {
                                //Open pdf
                                final url =
                                    "${PathsService.warrantyUrlService}queries/report{format}?id=$id&format=pdf";
                                final name = "Garantía No. $code";
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CustomPdfViewer(
                                    url: url,
                                    name: name,
                                  );
                                }));
                              },
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                              text: "Código de la garantía: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: "${code.toString()}\n\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: "Vigente hasta: ",
                                ),
                                TextSpan(
                                  text:
                                      "${DateFormat('dd-MM-yyyy - kk:mm').format(time)}\n\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: "Producto: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: "$article\n\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: "Marca: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: "$mark\n\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: "Modelo: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: "$model\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]);
  }
}
