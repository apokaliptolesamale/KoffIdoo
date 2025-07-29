// ignore_for_file: unnecessary_null_comparison, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/app/core/config/app_config.dart';
import '/app/core/config/assets.dart';
import '/app/core/helpers/functions.dart';
import '/app/core/helpers/store_short_cuts.dart';
import '/app/core/interfaces/app_page.dart';
import '/app/core/interfaces/get_provider.dart';
import '/app/core/interfaces/header_request.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/core/services/paths_service.dart';
import '/app/core/services/user_session.dart';
import '/app/modules/qrcode/views/pages/qr_scan_page.dart';
import '/app/modules/security/domain/models/profile_model.dart';
import '/app/modules/warranty/bindings/warranty_binding.dart';
import '/app/modules/warranty/domain/models/product_model.dart';
import '/app/modules/warranty/domain/models/warranty_model.dart';
import '/app/modules/warranty/views/colors.dart';
import '/app/modules/warranty/warranty_exporting.dart';
import '/app/modules/warranty/widgets/warranty_logo.dart';
import '/app/widgets/bar/custom_app_bar.dart';
import '/app/widgets/botton/custom_base_botton.dart';
import '/app/widgets/botton/custom_bottom_nav_bar.dart';
import '/app/widgets/botton/custom_icon_botton.dart';
import '/app/widgets/dialog/custom_dialog.dart';
import '/app/widgets/ext/user_profile_avatar.dart';
import '/app/widgets/images/background_image.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/store/single_store.dart';
import '/app/widgets/text/custom_text_form_field.dart';
import '/app/widgets/text/custom_text_trigger.dart';
import '/globlal_constants.dart';
import '../../../core/helpers/idp.dart';
import '../../../core/services/store_service.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/botton/custom_botton_text_form_field.dart';
import '../../../widgets/components/pdf_viewer.dart';
import '../../../widgets/text/custom_list_form_field.dart';
import '../../config/bindings/config_binding.dart';
import '../../config/controllers/config_controller.dart';
import '../../config/domain/models/nomenclador_model.dart';
import '../../product/bindings/product_binding.dart';
import '../../product/controllers/product_controller.dart';

// Create a Form widget.
class AddWarrantyCustomView extends StatefulWidget {
  ProductModel? product;
  AddWarrantyCustomView({
    Key? key,
    this.product,
  });

  @override
  AddWarrantyCustomViewState createState() => AddWarrantyCustomViewState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddWarrantyCustomViewState extends State<AddWarrantyCustomView> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _productFormKey = GlobalKey<FormState>();
  final _personFormKey = GlobalKey<FormState>();
  final _warrantyFormKey = GlobalKey<FormState>();

  final singleStore = SingleStore.getInstance;

  NomencladorList<NomencladorModel>? unidadesComerciales;
  NomencladorList<NomencladorModel>? provincias;
  NomencladorList<NomencladorModel>? paymentTypes;

  String? avatarUrl;
  String? user;
  bool loadingProvinces = false;
  bool loadingUnits = false;
  bool loadingPaymentTypes = false;
  bool checkingCode = false;
  bool isvalid = false;
  late ProductModel product;

  late CustomTriggerTextFormField personName,
      carnetIdentidad,
      address,
      email,
      cellphone;

  late CustomTriggerTextFormField code,
      mark,
      model,
      sello,
      serieOne,
      serieTwo,
      price,
      articulo;

  late CustomTriggerTextFormField tradeName,
      province,
      time,
      createdAt,
      paymentType;

  late Function(dynamic val)? setValueWarrantyFunction;

  CustomDialogBox? certDialogBox;

  String? createdAtLabelText;

  String defaultCreatedAtLabelText = "Garantía hasta";

  final Store<String, dynamic> warrantyStore =
      StoreService().getStore<String, dynamic>("warranty");
  final Store<String, dynamic> productStore =
      StoreService().getStore<String, dynamic>("product");
  final Store<String, dynamic> personStore =
      StoreService().getStore<String, dynamic>("person");
  final Store<String, TextEditingController> textCtlStore =
      StoreService().getStore<String, TextEditingController>("textControllers");
  List<String> formKeys = [
    //Clientes
    "personName",
    "carnetIdentidad",
    "email",
    "cellphone",
    "address",
    //Productos
    "articulo",
    "code",
    "mark",
    "model",
    "sello",
    "serieOne",
    "serieTwo",
    "price",
    //Warranty
    "tradeName"
        "province",
    "time",
    "createdAt",
    "paymentType"
  ];

  afterBuild() {
    if (mounted && product.mark == null && product.code != null) {}
  }

  applyValueToTextControllers(Store store, List<String> keys) {
    final txt = TextEditingController();
    keys.forEach((key) {
      final value = store.getValueOn<String>(key, "");
      textCtlStore.get(key, txt)!.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      //height: size.height,
      width: size.width,

      child: SingleChildScrollView(
        child: Column(
          children: [
            WarrantyLogo(),
            getPersonForm(_personFormKey),
            getProductForm(_productFormKey),
            getWarrantyForm(_warrantyFormKey),
            getAcceptBotton(),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textCtlStore.getMapFields.removeWhere((key, value) {
      value.dispose();
      return true;
    });
    super.dispose();
    //
    //StoreService().flush("person").flush("warranty").flush("product");
  }

  Widget getAcceptBotton() {
    return Container(
      height: 40,
      width: 250,
      margin: EdgeInsets.only(top: 25),
      child: MaterialButton(
        onPressed: () async {
          if (validate(checkStore: false)) {
            final ctl = Get.find<WarrantyController>();
            final fst = StoreService();
            Map map = fst.asMap(["person", "product", "warranty"]);
            //Setting params
            final response = await ctl.addWarranty.setParamsFromMap({
              //Cliente
              "clientName": map["personName"],
              "ci": map["carnetIdentidad"],
              "email": map["email"],
              "cellphone": map["cellphone"],
              "address": map["address"],
              //Producto
              "article": map["articulo"],
              "code": map["code"],
              "mark": map["mark"],
              "model": map["model"],
              "seller": map["sello"],
              "firstSerialNumber": map["serieOne"],
              "secondSerialNumber": map["serieTwo"],
              "price": double.parse(map["price"]),
              //Garantia
              "tradeName": map["tradeName"],
              "province": map["province"],
              "warrantyTime": map["time"],
              "time": map["createdAt"],
              "createdAt": DateTime.now(),
              "paymentType": map["paymentType"],
              "salePrice": double.parse(map["price"])
            }).call(null);
            //final profile = getAuthenticatedUserProfile();
            response.fold((l) => null, (cert) {
              final downloadUrl =
                  "${PathsService.warrantyUrlService}queries/report{format}?id=${cert.warrantyId}&format=pdf";
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CustomPdfViewer(
                  url: downloadUrl,
                  name: "Certificado",
                );
              }));
            });
          }
        },
        shape: StadiumBorder(),
        color: isvalid ? aceptBottonColor : disabledButtonColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3.0,
            //horizontal: 24.0,
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

  Widget getAcceptCertBotton(Function() handler) {
    return Container(
      height: 40,
      width: 250,
      margin: EdgeInsets.only(top: 100),
      child: MaterialButton(
        onPressed: () {
          handler();
        },
        shape: StadiumBorder(),
        color: aceptBottonColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3.0,
            //horizontal: 24.0,
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

  CustomDialogBox getCertDialogBoxInstance({
    Key? key,
    required BuildContext context,
    required String title,
    String? description,
    Widget? descriptionWidget,
    required List<Widget> actions,
    required Image logo,
    required WarrantyModel cert,
    Widget? content,
  }) {
    content = content ??
        Column(
          children: [
            Container(
              color: Colors.red,
              height: 20,
              width: 30,
            )
          ],
        );

    return certDialogBox = certDialogBox != null
        ? certDialogBox!.show()
        : CustomDialogBox(
            context: context,
            title: title,
            description: description,
            descriptionWidget: descriptionWidget,
            content: content,
            actions: actions,
            padding: EdgeInsets.only(
              left: Constants.padding / 2,
              top: Constants.avatarRadius / 2 + Constants.padding / 2,
              right: Constants.padding / 2,
              bottom: Constants.padding / 2,
            ),
            logo: Image.asset(ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG),
          ).show();
  }

  Widget getPersonForm(Key keyForm) {
    final key = "person";
    return Container(
      margin: const EdgeInsets.only(right: 5, left: 5, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Form(
        key: keyForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 5),
              height: 100,
              width: 100,
              child: UserProfileAvatar(
                user: user,
                avatarUrl: avatarUrl,
                radius: 95,
              ),
            ),
            Container(
              //height: 50,
              padding: EdgeInsets.only(left: 10, bottom: 5, top: 30),
              child: Text(
                "Datos del cliente:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            personName = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5),
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      /* 
                      N:ROLANDO
                      A:ORO SINCONEGUI
                      CI:96102607928
                      FV:AAI730116                      
                       */

                      final result = code.code!;
                      final name = result.substring(2, result.indexOf("\n"));
                      final apell = result.substring(
                          result.indexOf(RegExp(r'A:')) + 2,
                          result.indexOf(RegExp(r'CI:')));
                      final ci = result.substring(
                          result.indexOf(RegExp(r'CI:')) + 3,
                          result.indexOf(RegExp(r'FV:')));

                      log("Nombre y apellidos: $name $apell");
                      StoreService()
                          .set(key, "personName", "$name $apell")
                          .set(key, "carnetIdentidad", ci);
                      final mas = ManagerAuthorizationService().get("apis-fuc");
                      bool test = StoreService().existStore(
                          "sdsdsdsd"); //para que de false y no entre al if
                      if (mas != null && test) {
                        bool hasConnection =
                            await mas.hasConnection(Duration(seconds: 10));
                        bool isAuth =
                            hasConnection ? await mas.isAuthenticated() : false;
                        if (isAuth) {
                          log("Authenticado en el API de la Ficha Única del Ciudadano:$isAuth");
                          final url =
                              "api/v1/nivel3?identidad_numero=$ci&similar=false";
                          final baseUrl =
                              "https://${PathsService.apiFucManagerHost}/pn-api-consulta/2.0.210131/";
                          log("Buscando datos del ciudadano desde:$baseUrl$url");
                          final headerObj = HeaderRequestImpl(
                            idpKey: mas.key,
                            headers: {
                              "accept": "application/json",
                            },
                          );
                          final headers = await headerObj.getHeaders();
                          final provider = GetDefautlProviderImpl(
                            allowAutoSignedCert: true,
                            maxAuthRetries: 3,
                            maxRedirects: 3,
                            baseUrl: baseUrl,
                            headers: headers,
                          );
                          await provider.get(
                            url,
                            headers: headers,
                            decoder: (data) {
                              log(data);
                            },
                          );
                        }
                      }

                      return Future.value(
                        personStore.getMapFields,
                      );
                    } catch (e) {
                      e.printError();
                    }

                    return Future.value("Error...");
                  };
                  Get.toNamed(Routes.getInstance.getPath("QR_SCAN"),
                      parameters: {
                        "urlCallBack": Get.currentRoute,
                      });
                },
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.person,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "personName",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  personStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                value: personStore.get("personName", ""),
                controller: textCtlStore.getValueOn(
                  "personName",
                  TextEditingController(),
                ),
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  // for below version 2 use this
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Z a-z]')),
                  // for version 2 and greater youcan also use this
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                labelText: "Nombre y apellidos",
                validator: (textField, value) {
                  return NotEmptyTextFieldValidator(
                    value,
                    text: "Debe introducir nombre y apellidos correctos.",
                  );
                },
              ),
            ),
            carnetIdentidad = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: false,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      final profile = getAuthenticatedUserProfile();
                      setState(() {
                        if (profile != null) {
                          avatarUrl =
                              "${PathsService.mediaHost}images/user/avatar/${profile.sub}.png";
                        }
                      });
                      return Future.value(StoreService()
                          .set(key, "carnetIdentidad", code.code!)
                          .getStore(key)
                          .getMapFields);
                    } catch (e) {
                      e.printError();
                    }
                    return Future.value("Error...");
                  };
                  Get.toNamed(Routes.getInstance.getPath("QR_SCAN"),
                      parameters: {
                        "urlCallBack": Get.currentRoute,
                      });
                },
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.perm_identity,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "carnetIdentidad",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  personStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                labelText: "Documento de identidad",
                value: personStore.get("carnetIdentidad", ""),
                controller: textCtlStore.getValueOn(
                  "carnetIdentidad",
                  TextEditingController(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  // for below version 2 use this
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  // for version 2 and greater youcan also use this
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (textField, value) {
                  if (value == null || value == "") {
                    return NotEmptyTextFieldValidator(
                      value,
                      text: "Debe introducir un número de identidad válido.",
                    );
                  } else if (value.length != 6 || value.length != 11) {
                    return NotEmptyTextFieldValidator(
                      value,
                      text:
                          "Debe introducir un número de identidad válido de 6 o 11 dígitos.",
                    );
                  }
                  return null;
                },
              ),
            ),
            address = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: false,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {},
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.home_work,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "address",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  personStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                value: personStore.get("address", ""),
                controller: textCtlStore.getValueOn(
                  "address",
                  TextEditingController(),
                ),
                labelText: "Dirección de residencia",
                keyboardType: TextInputType.streetAddress,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                validator: (textField, value) {
                  if (value == null || value == "") {
                    return NotEmptyTextFieldValidator(
                      value,
                      text: "Debe introducir una dirección válida.",
                    );
                  }
                  return null;
                },
              ),
            ),
            email = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: false,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {},
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.email,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "email",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  personStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                labelText: "Correo electrónico",
                value: personStore.get("email", ""),
                controller: textCtlStore.getValueOn(
                  "email",
                  TextEditingController(),
                ),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                validator: (textField, value) {
                  if (value == null || value == "") {
                    return NotEmptyTextFieldValidator(
                      value,
                      text:
                          "Debe introducir una dirección de correo electrónico válida.",
                    );
                  }
                  return null;
                },
              ),
            ),
            cellphone = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: false,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {},
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.phone,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "cellphone",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  personStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                value: personStore.get("cellphone", ""),
                controller: textCtlStore.getValueOn(
                  "cellphone",
                  TextEditingController(),
                ),
                labelText: "Teléfono/Celular",
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                validator: (textField, value) {
                  if (value == null || value == "") {
                    return NotEmptyTextFieldValidator(
                      value,
                      text:
                          "Debe introducir un número de teléfono o celular válido.",
                    );
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget getProductForm(Key keyForm) {
    String key = "product";
    return Container(
      margin: const EdgeInsets.only(right: 5, left: 5, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Form(
        key: keyForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, bottom: 5, top: 30),
              child: Text(
                "Datos del producto:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            articulo = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: false,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  //TODO actualizar datos del producto desde el servicio de TRD
                  log("message-1");
                },
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.description,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "articulo",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  productStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                value: productStore.get("articulo", ""),
                controller: textCtlStore.getValueOn(
                  "articulo",
                  TextEditingController(),
                ),
                labelText: productStore.getNotValueOn(
                    "articulo", "Nombre del producto"),
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                validator: (textField, value) {
                  if (value == null || value == "") {
                    return NotEmptyTextFieldValidator(
                      value,
                      text: "Debe introducir un nombre de artículo válido.",
                    );
                  }
                  return null;
                },
              ),
            ),
            code = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  //code=1467524000050
                  QrScanPage.onScan = (code) async {
                    try {
                      log("Resultado del Scan:\n${code.code ?? 'Nulo'}");
                      return Future.value(StoreService()
                          .set(key, "code", code.code!)
                          .getStore(key)
                          .getMapFields);
                    } catch (e) {
                      e.printError();
                    }
                    return Future.value("Error...");
                  };
                  Get.toNamed(Routes.getInstance.getPath("QR_SCAN"),
                      parameters: {
                        "urlCallBack": Get.currentRoute,
                      });
                },
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () async {
                    final ctl = textCtlStore.getValueOn(
                      "code",
                      TextEditingController(),
                    );
                    String value = ctl.text;
                    StoreService().set(key, "code", ctl.text);
                    productStore.set("code", value);
                    if (value != null &&
                        value.isNotEmpty &&
                        value.length == 13) {
                      await processCode(value);
                      //setState(() {});
                    }
                  },
                  icon: Icon(
                    Icons.home_work,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "code",
                focusNode: FocusNode(),
                enabled: checkingCode == false,
                onChanged: (field, value) async {
                  productStore.set(field.name, value);
                  if (value != null && value.isNotEmpty && value.length == 13) {
                    await processCode(value);
                    //setState(() {});
                  }
                  //
                },
                value: productStore.get("code", ""),
                controller: textCtlStore.getValueOn(
                  "code",
                  TextEditingController(),
                ),
                labelText: productStore.getNotValueOn("code", "Código"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (textField, value) {
                  if (value == null || value == "") {
                    return NotEmptyTextFieldValidator(
                      value,
                      text: "Código vacío o incorrecto.",
                    );
                  } else if (value != null) {
                    return TextFieldLengthValidator(value);
                  }
                  return null;
                },
              ),
            ),
            mark = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      return Future.value(StoreService()
                          .set(key, "mark", code.code!)
                          .getStore(key)
                          .getMapFields);
                    } catch (e) {
                      e.printError();
                    }
                    return Future.value("Error...");
                  };
                  Get.toNamed(Routes.getInstance.getPath("QR_SCAN"),
                      parameters: {
                        "urlCallBack": Get.currentRoute,
                      });
                },
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.label,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "mark",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  productStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                labelText: productStore.getNotValueOn("mark", "Marca"),
                value: productStore.get("mark", ""),
                controller: textCtlStore.getValueOn(
                  "mark",
                  TextEditingController(),
                ),
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                validator: (textField, value) {
                  if (value == null || value == "") {
                    return NotEmptyTextFieldValidator(
                      value,
                      text: "Marca vacía o incorrecta.",
                    );
                  }
                  return null;
                },
              ),
            ),
            model = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      return Future.value(StoreService()
                          .set(key, "model", code.code!)
                          .getStore(key)
                          .getMapFields);
                    } catch (e) {
                      e.printError();
                    }
                    return Future.value("Error...");
                  };
                  Get.toNamed(Routes.getInstance.getPath("QR_SCAN"),
                      parameters: {
                        "urlCallBack": Get.currentRoute,
                      });
                },
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.label,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "model",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  productStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                value: productStore.get("model", ""),
                controller: textCtlStore.getValueOn(
                  "model",
                  TextEditingController(),
                ),
                labelText: productStore.getNotValueOn("model", "Modelo"),
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                validator: (textField, value) {
                  if (value == null || value == "") {
                    return NotEmptyTextFieldValidator(
                      value,
                      text: "Modelo vacío o incorrecto.",
                    );
                  }
                  return null;
                },
              ),
            ),
            sello = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      return Future.value(StoreService()
                          .set(key, "sello", code.code!)
                          .getStore(key)
                          .getMapFields);
                    } catch (e) {
                      e.printError();
                    }
                    return Future.value("Error...");
                  };
                  Get.toNamed(Routes.getInstance.getPath("QR_SCAN"),
                      parameters: {
                        "urlCallBack": Get.currentRoute,
                      });
                },
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "sello",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  productStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                value: productStore.get("sello", ""),
                controller: textCtlStore.getValueOn(
                  "sello",
                  TextEditingController(),
                ),
                labelText: productStore.getNotValueOn("sello", "No. de sello"),
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                validator: (textField, value) {
                  if (value == null || value == "") {
                    return NotEmptyTextFieldValidator(
                      value,
                      text: "Sello vacío o incorrecto.",
                    );
                  }
                  return null;
                },
              ),
            ),
            serieOne = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      return Future.value(StoreService()
                          .set(key, "serieOne", code.code!)
                          .getStore(key)
                          .getMapFields);
                    } catch (e) {
                      e.printError();
                    }
                    return Future.value("Error...");
                  };
                  Get.toNamed(Routes.getInstance.getPath("QR_SCAN"),
                      parameters: {
                        "urlCallBack": Get.currentRoute,
                      });
                },
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.numbers,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "serieOne",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  productStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                value: productStore.get("serieOne", ""),
                controller: textCtlStore.getValueOn(
                  "serieOne",
                  TextEditingController(),
                ),
                labelText:
                    productStore.getNotValueOn("serieOne", "No. Serie 1"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                validator: (textField, value) {
                  if (value == null || value == "") {
                    return NotEmptyTextFieldValidator(
                      value,
                      text: "Número de serie vacío o incorrecto.",
                    );
                  }
                  return null;
                },
              ),
            ),
            serieTwo = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      return Future.value(StoreService()
                          .set(key, "serieTwo", code.code!)
                          .getStore(key)
                          .getMapFields);
                    } catch (e) {
                      e.printError();
                    }
                    return Future.value("Error...");
                  };
                  Get.toNamed(Routes.getInstance.getPath("QR_SCAN"),
                      parameters: {
                        "urlCallBack": Get.currentRoute,
                      });
                },
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.numbers,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "serieTwo",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  productStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                value: productStore.get("serieTwo", ""),
                controller: textCtlStore.getValueOn(
                  "serieTwo",
                  TextEditingController(),
                ),
                labelText:
                    productStore.getNotValueOn("serieTwo", "No. Serie 2"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
              ),
            ),
            price = CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: false,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {},
                text: "",
                icon: Container(
                  width: 40,
                  height: 40,
                  child: Image(
                    image:
                        AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
                  ),
                ),
              ),
              textField: CustomTextFormField(
                icon: CustomBottonTextFormFiedl(
                  onTap: () {},
                  icon: Icon(
                    Icons.price_check,
                    color: Color(0xFF00b1a4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: !loadingProvinces
                        ? Colors.transparent
                        : Color(0xFF00b1a4).withOpacity(0.7),
                  ),
                ),
                name: "price",
                focusNode: FocusNode(),
                onChanged: (field, value) {
                  productStore.set(field.name, value);
                  //field.controller.text = value ?? "";
                  validateStore();
                },
                value: productStore.get("price", ""),
                controller: textCtlStore.getValueOn(
                  "price",
                  TextEditingController(),
                ),
                labelText: productStore.getNotValueOn("price", "Precio"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                ],
                validator: (textField, value) {
                  if (value == null || value == "") {
                    return NotEmptyTextFieldValidator(
                      value,
                      text: "Debe introducir un precio válido.",
                    );
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget getWarrantyForm(Key keyForm) {
    ConfigBinding().dependencies();

    final List<Map<String, String>> ucDropDownList =
        unidadesComerciales != null && unidadesComerciales!.getList().isNotEmpty
            ? unidadesComerciales!.toDropDownFormat()
            : [];
    final List<Map<String, String>> dpaDropDownList =
        provincias != null && provincias!.getList().isNotEmpty
            ? provincias!.toDropDownFormat()
            : [];
    final List<Map<String, String>> currencyDropDownList =
        paymentTypes != null && paymentTypes!.getList().isNotEmpty
            ? paymentTypes!.toDropDownFormat()
            : [];
    tradeName = CustomTriggerTextFormField(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      visibleTriggerBotton: false,
      botton: CustomOutlinedIconButton(
        color: Colors.white,
        onPressed: <CustomOutlinedIconButton>(ctx, btn) {},
        text: "",
        icon: Container(
          width: 40,
          height: 40,
          child: Image(
            image: AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
          ),
        ),
      ),
      textField: CustomListFormField(
        icon: CustomBottonTextFormFiedl(
          onTap: () {
            final mas =
                ManagerAuthorizationService().get(PathsService.identityKey);
            if (mas != null) {
              setState(() {
                loadingUnits = true;
              });
              final cfgController = Get.find<ConfigController>();
              final unidades = cfgController.getComercialUnits(
                  mas.consumerKey, "Unidades Comerciales TRD");
              unidades.then((value) {
                setState(() {
                  loadingUnits = false;
                  unidadesComerciales =
                      value.fold((l) => NomencladorList.fromEmpty(), (result) {
                    final list = result.getList().first;
                    return list;
                  });
                });
              });
            }
          },
          icon: Icon(
            !loadingUnits ? Icons.home : Icons.refresh,
            color: Color(0xFF00b1a4),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: !loadingUnits
                ? Colors.transparent
                : Color(0xFF00b1a4).withOpacity(0.7),
          ),
        ),
        name: "tradeName",
        options: ucDropDownList,
        onChanged: (field, value) {
          warrantyStore.set(field.name, value);
          //field.controller.text = value ?? "";
          validateStore();
        },
        focusNode: FocusNode(),
        labelText: warrantyStore.getNotValueOn("tradeName", "Unidad comercial"),
        value: warrantyStore.get("tradeName", ""),
        controller: textCtlStore.getValueOn(
          "TradeName",
          TextEditingController(),
        ),
        keyboardType: TextInputType.name,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        validator: (textField, value) {
          if (value == null || value == "") {
            return NotEmptyTextFieldValidator(
              value,
              text: "Unidad comercial vacía o incorrecta.",
            );
          }
          return null;
        },
      ),
    );
    province = CustomTriggerTextFormField(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      visibleTriggerBotton: false,
      botton: CustomOutlinedIconButton(
        color: Colors.white,
        onPressed: <CustomOutlinedIconButton>(ctx, btn) {},
        text: "",
        icon: Container(
          width: 40,
          height: 40,
          child: Image(
            image: AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
          ),
        ),
      ),
      textField: CustomListFormField(
        icon: CustomBottonTextFormFiedl(
          onTap: () {
            final mas =
                ManagerAuthorizationService().get(PathsService.identityKey);
            if (mas != null) {
              setState(() {
                loadingProvinces = true;
              });
              final cfgController = Get.find<ConfigController>();
              final dpa = cfgController.getDpa(
                  mas.consumerKey, "División Política Administrativa (DPA)");
              dpa.then((value) {
                setState(() {
                  loadingProvinces = false;
                  provincias =
                      value.fold((l) => NomencladorList.fromEmpty(), (result) {
                    final list = result.getList().first;
                    return list;
                  });
                });
              });
            }
          },
          icon: Icon(
            !loadingProvinces ? Icons.place : Icons.refresh,
            color: Color(0xFF00b1a4),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: !loadingProvinces
                ? Colors.transparent
                : Color(0xFF00b1a4).withOpacity(0.7),
          ),
        ),
        options: dpaDropDownList,
        name: "province",
        onChanged: (field, value) {
          warrantyStore.set(field.name, value);
          //field.controller.text = value ?? "";
          /*if (field.focusNode != null) {
            field.focusNode!.unfocus();
          }*/
          //field.controller.text = value ?? "";
          validateStore();
        },
        focusNode: FocusNode(),
        labelText: warrantyStore.getNotValueOn("province", "Provincia"),
        keyboardType: TextInputType.name,
        controller: textCtlStore.getValueOn(
          "province",
          TextEditingController(),
        ),
        value: warrantyStore.get("province", ""),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        validator: (textField, value) {
          if (value == null || value == "") {
            return NotEmptyTextFieldValidator(
              value,
              text: "Provincia vacía o incorrecta.",
            );
          }
          return null;
        },
      ),
    );
    final createdAtTextCtl = textCtlStore.get(
      "createdAt",
      TextEditingController(),
    );
    /*final createdAtFocus = FocusNode();
    createdAtFocus.addListener(() {
      final updatedText = productStore.get("createdAt", "");
      setState(() {
        createdAtLabelText =
            !createdAtFocus.hasFocus ? updatedText : defaultCreatedAtLabelText;
      });
    });*/
    time = CustomTriggerTextFormField(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      visibleTriggerBotton: false,
      botton: CustomOutlinedIconButton(
        color: Colors.white,
        onPressed: <CustomOutlinedIconButton>(ctx, btn) {},
        text: "",
        icon: Container(
          width: 40,
          height: 40,
          child: Image(
            image: AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
          ),
        ),
      ),
      textField: CustomTextFormField(
        icon: CustomBottonTextFormFiedl(
          onTap: () {},
          icon: Icon(
            Icons.lock_clock,
            color: Color(0xFF00b1a4),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: !loadingProvinces
                ? Colors.transparent
                : Color(0xFF00b1a4).withOpacity(0.7),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: FocusNode(),
        onChanged: (field, value) {
          func(val) {
            if (val == null || (val != null && val.isEmpty)) return value;
            return DateFormat('dd-MM-yyyy')
                .format(DateTime.now().add(Duration(days: int.parse(val))));
          }

          final newText = func(value);
          warrantyStore.set("createdAt", newText);
          warrantyStore.set(field.name, value);
          createdAtTextCtl!.text = newText ?? "";
          //field.controller.text = value ?? "";
          validateStore();
          /*setState(() {
            createdAtLabelText =
                newText != null ? defaultCreatedAtLabelText : newText;
          });*/
        },
        name: "time",
        value: warrantyStore.get("time", "").toString(),
        controller: textCtlStore.getValueOn(
          "time",
          TextEditingController(),
        ),
        labelText: warrantyStore.getNotValueOn("time", "Tiempo de garantía"),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (textField, value) {
          return NotEmptyTextFieldValidator(
            value,
            text: "Tiempo de garantía",
          );
        },
      ),
    );

    createdAt = CustomTriggerTextFormField(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      visibleTriggerBotton: false,
      botton: CustomOutlinedIconButton(
        color: Colors.white,
        onPressed: <CustomOutlinedIconButton>(ctx, btn) {},
        text: "",
        icon: Container(
          width: 40,
          height: 40,
          child: Image(
            image: AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
          ),
        ),
      ),
      //
      textField: CustomTextFormField(
        icon: CustomBottonTextFormFiedl(
          onTap: () {},
          icon: Icon(
            Icons.verified,
            color: Color(0xFF00b1a4),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: !loadingProvinces
                ? Colors.transparent
                : Color(0xFF00b1a4).withOpacity(0.7),
          ),
        ),
        name: "createdAt",
        focusNode: FocusNode(),
        onChanged: (field, value) {
          warrantyStore.set(field.name, value);
          // field.controller.text = value!;
          //field.controller.text = value ?? "";
          validateStore();
        },
        labelText: warrantyStore.getNotValueOn("createdAt", "Garantía hasta"),
        enabled: true,
        controller: createdAtTextCtl!,
        value: warrantyStore.get("createdAt", ""),
        //focusNode: createdAtFocus,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blueAccent.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        validator: (textField, value) {
          return NotEmptyTextFieldValidator(
            value,
            text: "Fecha de vigencia de la garantía",
          );
        },
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
          // FilteringTextInputFormatter.allow(RegExp('[0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{2}-[0-9]{2}-[0-9]{4}|[0-9]{4}/[0-9]{2}/[0-9]{2}|[0-9]{2}/[0-9]{2}/[0-9]{4}')),
        ],
      ),
    );

    paymentType = CustomTriggerTextFormField(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      visibleTriggerBotton: false,
      botton: CustomOutlinedIconButton(
        color: Colors.white,
        onPressed: <CustomOutlinedIconButton>(ctx, btn) {},
        text: "",
        icon: Container(
          width: 40,
          height: 40,
          child: Image(
            image: AssetImage(ASSETS_IMAGES_ICONS_APP_ESCANER_AMIGO_PNG),
          ),
        ),
      ),
      textField: CustomListFormField(
        icon: CustomBottonTextFormFiedl(
          onTap: () {
            final mas =
                ManagerAuthorizationService().get(PathsService.identityKey);
            if (mas != null) {
              final cfgController = Get.find<ConfigController>();
              setState(() {
                loadingPaymentTypes = true;
              });
              final payments = cfgController.getPaymentTypes(
                  mas.consumerKey, "Tipos de Pago");
              payments.then((value) {
                setState(() {
                  loadingPaymentTypes = false;
                  paymentTypes =
                      value.fold((l) => NomencladorList.fromEmpty(), (result) {
                    final list = result.getList().first;
                    return list;
                  });
                });
              });
            }
          },
          icon: Icon(
            !loadingPaymentTypes ? Icons.payments : Icons.refresh,
            color: Color(0xFF00b1a4),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: !loadingPaymentTypes
                ? Colors.transparent
                : Color(0xFF00b1a4).withOpacity(0.7),
          ),
        ),
        options: currencyDropDownList,
        name: "paymentType",
        onChanged: (field, value) {
          warrantyStore.set(field.name, value);
          //field.controller.text = value ?? "";
          /*if (field.focusNode != null) {
            field.focusNode!.unfocus();
          }*/
          //field.controller.text = value ?? "";
          validateStore();
        },
        value: warrantyStore.get("paymentType", ""),
        controller: textCtlStore.getValueOn(
          "paymentType",
          TextEditingController(),
        ),
        focusNode: FocusNode(),
        labelText: warrantyStore.getNotValueOn("paymentType", "Forma de pago"),
        keyboardType: TextInputType.name,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        validator: (textField, value) {
          if (value == null || value == "") {
            return NotEmptyTextFieldValidator(
              value,
              text: "Tipo de pago vacío o incorrecto.",
            );
          }
          return null;
        },
      ),
    );

    return RefreshIndicator.adaptive(
      onRefresh: () {
        func() {
          isvalid = validateStore(updateState: true);
        }

        return Future.value(func());
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5, left: 5, top: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //height: 50,
                    padding: EdgeInsets.only(left: 10, bottom: 5, top: 30),
                    child: Text(
                      "Datos de la garantía:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  tradeName,
                  province,
                  paymentType,
                  time,
                ],
              ),
            ),
            createdAt,
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initTextControllers();
    unidadesComerciales = NomencladorList.fromEmpty();
    provincias = NomencladorList.fromEmpty();
    paymentTypes = NomencladorList.fromEmpty();
    final mas = ManagerAuthorizationService().get(PathsService.identityKey);
    if (mas != null) {
      final cfgController = Get.find<ConfigController>();
      final unidades = cfgController.getComercialUnits(
          mas.consumerKey, "Unidades Comerciales TRD");
      unidades.then((value) {
        setState(() {
          unidadesComerciales =
              value.fold((l) => NomencladorList.fromEmpty(), (result) {
            final list = result.getList().first;
            return list;
          });
        });
      });
      final dpa = cfgController.getDpa(
          mas.consumerKey, "División Política Administrativa (DPA)");
      dpa.then((value) {
        setState(() {
          provincias = value.fold((l) => NomencladorList.fromEmpty(), (result) {
            final list = result.getList().first;
            return list;
          });
        });
      });
      final payments =
          cfgController.getPaymentTypes(mas.consumerKey, "Tipos de Pago");
      payments.then((value) {
        setState(() {
          paymentTypes =
              value.fold((l) => NomencladorList.fromEmpty(), (result) {
            final list = result.getList().first;
            return list;
          });
        });
      });
    }

    setValueWarrantyFunction = (val) {
      if (val == null || (val != null && val.isEmpty)) return val;
      return DateFormat('dd-MM-yyyy')
          .format(DateTime.now().add(Duration(days: int.parse(val))));
    };
  }

  initTextControllers() {
    int c = 0;
    for (var key in formKeys) {
      Store<String, dynamic> tmp = c >= 0 && c <= 4
          ? personStore
          : c > 4 && c <= 12
              ? productStore
              : warrantyStore;
      textCtlStore.set(
          key,
          TextEditingController(
            text: tmp.get(key, ""),
          ));
    }
  }

  processCode(String value) async {
    final isValid = validateStore(updateState: false);
    setState(() {
      checkingCode = true;
      isvalid = isValid;
    });
    log("Validar código del producto contra microservicio...");
    final productBinding = ProductBinding();
    productBinding.dependencies();
    final ctl = Get.find<ProductController>();
    final response = await ctl.filterUseProduct.setParamsFromMap({
      "code": value.toString(),
    }).call(null);
    response.fold((l) {
      log("Mostrar mensaje de error");
      StoreService().flush("product");
      bool isValid = validateStore(updateState: false);
      setState(() {
        checkingCode = false;
        isvalid = isValid;
      });
    }, (products) {
      if (products.getList().isNotEmpty) {
        log("llenar formulario de producto");
        final product = products.getList().first;
        productStore
            .set("articulo", product.name)
            .set("mark", product.mark)
            .set("model", product.model)
            .set("price", product.salePrice.toString())
            .set("productIdService", product.id)
            .set("orderIdService", product.idOrderService);
        func(val) {
          if (val == null || (val != null && val.isEmpty)) return value;
          return DateFormat('dd-MM-yyyy')
              .format(DateTime.now().add(Duration(days: int.parse(val))));
        }

        final newText = func(product.warrantyTime.toString());
        warrantyStore
            .set("time", product.warrantyTime.toString())
            .set("createdAt", newText);
        applyValueToTextControllers(
            productStore, ["articulo", "mark", "model", "price"]);
        applyValueToTextControllers(warrantyStore, ["time", "createdAt"]);
        /*final txt = TextEditingController();
        textCtlStore.get("articulo", txt)!.text =
            productStore.getValueOn<String>("articulo", "");*/
        bool isValid = validateStore(updateState: false);
        setState(() {
          checkingCode = false;
          isvalid = isValid;
        });
      }
    });
  }

  bool validate({
    bool checkStore = false,
  }) {
    bool formValid =
        validateProductForm() && validatePersonForm() && validateWarrantyForm();
    if (formValid && checkStore) return validateStore();
    return formValid;
  }

  bool validatePersonForm() {
    return _personFormKey.currentState != null &&
        _personFormKey.currentState!.validate();
  }

  bool validateProductForm() {
    return _productFormKey.currentState != null &&
        _productFormKey.currentState!.validate();
  }

  bool validateStore({
    bool updateState = true,
  }) {
    final fst = StoreService();
    List<String> keys = [
      "personName",
      "carnetIdentidad",
      "email",
      "cellphone",
      "address",
      "articulo",
      "code",
      "mark",
      "model",
      "sello",
      "serieOne",
      "serieTwo",
      "price",
      "tradeName",
      "province",
      "time",
      "createdAt",
      "paymentType",
      "productIdService",
      "orderIdService",
    ];
    bool valid = fst.isValid(["person", "product", "warranty"], keys) &&
        validate(checkStore: false);
    if (updateState) {
      setState(() {
        isvalid = valid;
      });
    }
    return valid;
  }

  bool validateWarrantyForm() {
    return _warrantyFormKey.currentState != null &&
        _warrantyFormKey.currentState!.validate();
  }
}

class AddWarrantyPage extends GetResponsiveView<WarrantyController> {
  final Widget? child;

  AddWarrantyPage({
    Key? key,
    this.child,
  }) : super(
            key: key,
            settings: ResponsiveScreenSettings(
              desktopChangePoint: 800,
              tabletChangePoint: 700,
              watchChangePoint: 600,
            ));
  @override
  Widget build(BuildContext context) {
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    return CustomFutureBuilder(
      future: Future.value(service?.getUserSession()),
      builder: getBuilder(),
      context: context,
    );
  }

  AsyncWidgetBuilder<dynamic> getBuilder() {
    builder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      final waiting = isWaiting(snapshot);
      final done = isDone(snapshot);
      final error = isError(snapshot);
      Widget profileWidget = Container();
      if (waiting || error) {
        profileWidget = Container();
      } else {
        final UserSession usession = snapshot.data as UserSession;
        ProfileModel? profile =
            done ? usession.getBy<ProfileModel>("profile") : null;
        log(profile != null
            ? "El perfil iniciado es del usuario: ${profile.userName}"
            : "No se inició correctamete el perfil de usuario.");
        profileWidget = profile != null
            ? UserProfileAvatar(
                user: profile.userName,
              )
            : Container();
      }
      return Stack(
        children: [
          BackGroundImage(
            backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            bottomNavigationBar: CustomBotoonNavBar.fromRoute(
              Get.currentRoute,
              listOfPages: getListOfPages,
            ),
            appBar: CustomAppBar(
              leading: Icon(Icons.menu),
              title: Text(ConfigApp.getInstance.configModel!.name),
              keyStore: "garantia",
              actions: [
                //Icon(Icons.favorite),
                //if (activateSearch) searchInput!,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomBaseBotton(
                    icon: Icon(Icons.notifications),
                    onHover: <CustomBaseBotton>(_, event, btn) {
                      /*setState(() {
                      activateSearch = true;
                    });*/
                    },
                    onExit: <CustomBaseBotton>(_, event, btn) {
                      /*setState(() {
                      activateSearch = false;
                    });*/
                    },
                    onTap: <CustomBaseBotton>(_, btn) {
                      /*setState(() {
                      activateSearch = !activateSearch;
                    });*/
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: profileWidget,
                ),
              ],
              backgroundColor: Color(0xFF00b1a4),
            ),
            body: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: child,
            ),
          ),
        ],
      );
    }

    return builder;
  }

  bool isDone(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
        snapshot.hasData &&
        snapshot.data is dart.Right;
  }

  bool isError(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data is dart.Left ||
        snapshot.error != null;
  }

  bool isWaiting(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.waiting;
  }
}

class WarrantyAddPageImpl<T> extends CustomAppPageImpl<T> {
  @override
  final GetPageBuilder page;
  @override
  final bool? popGesture;
  @override
  final Map<String, String>? parameters;
  @override
  final String? title;
  @override
  final Transition? transition;
  @override
  final Curve curve;
  @override
  final bool? participatesInRootNavigator;
  @override
  final Alignment? alignment;
  @override
  final bool maintainState;
  @override
  final bool opaque;
  @override
  final double Function(BuildContext context)? gestureWidth;
  @override
  final Bindings? binding;
  @override
  final List<Bindings> bindings;
  @override
  final CustomTransition? customTransition;
  @override
  final Duration? transitionDuration;
  @override
  final bool fullscreenDialog;
  @override
  final bool preventDuplicates;

  @override
  final Object? arguments;

  @override
  final String name;

  @override
  final List<GetPage> children;
  @override
  final List<GetMiddleware>? middlewares;
  @override
  final PathDecoded customPath;
  @override
  final GetPage? unknownRoute;
  @override
  final bool showCupertinoParallax;
  @override
  String keyMap;
  @override
  int index;

  WarrantyAddPageImpl({
    required this.name,
    required this.keyMap,
    required this.page,
    this.index = -1,
    this.title,
    this.participatesInRootNavigator,
    this.gestureWidth,
    this.maintainState = true,
    this.curve = Curves.linear,
    this.alignment,
    this.parameters,
    this.opaque = true,
    this.transitionDuration,
    this.popGesture,
    this.binding,
    this.bindings = const [],
    this.transition,
    this.customTransition,
    this.fullscreenDialog = false,
    this.children = const <GetPage>[],
    this.middlewares,
    this.unknownRoute,
    this.arguments,
    this.showCupertinoParallax = true,
    this.preventDuplicates = true,
  })  : customPath = CustomAppPageImpl.nameToRegex(name),
        assert(name.startsWith('/'),
            'It is necessary to start route name [$name] with a slash: /$name'),
        super(
          name: name,
          keyMap: keyMap,
          page: page,
          index: index,
          title: title,
          participatesInRootNavigator: participatesInRootNavigator,
          gestureWidth: gestureWidth,
          maintainState: maintainState,
          curve: curve,
          alignment: alignment,
          parameters: parameters,
          opaque: opaque,
          transitionDuration: transitionDuration,
          popGesture: popGesture,
          binding: binding,
          transition: transition,
          customTransition: customTransition,
          fullscreenDialog: fullscreenDialog,
          children: children,
          middlewares: middlewares,
          unknownRoute: unknownRoute,
          arguments: Get.arguments,
          showCupertinoParallax: showCupertinoParallax,
          preventDuplicates: preventDuplicates,
        );

  @override
  Route<T> createRoute(BuildContext context) {
    final page = PageRedirect(
      route: this,
      settings: this,
      unknownRoute: unknownRoute,
    ).getPageToRoute<T>(this, unknownRoute);
    return page;
  }

  static WarrantyAddPageImpl builder({
    String name = "/warranty/add-warranty",
    String keyMap = "WARRANTY_ADD",
    int index = -1,
    bool? popGesture,
    Map<String, String>? parameters,
    String? title,
    Transition? transition,
    Curve curve = Curves.linear,
    Alignment? alignment,
    bool maintainState = true,
    bool opaque = true,
    Bindings? binding,
    List<Bindings>? bindings,
    CustomTransition? customTransition,
    Duration? transitionDuration,
    bool fullscreenDialog = false,
    RouteSettings? settings,
    List<GetPage> children = const <GetPage>[],
    GetPage? unknownRoute,
    List<GetMiddleware>? middlewares,
    bool preventDuplicates = true,
    final double Function(BuildContext context)? gestureWidth,
    bool? participatesInRootNavigator,
    Object? arguments,
    bool showCupertinoParallax = true,
  }) =>
      WarrantyAddPageImpl(
        name: name,
        keyMap: keyMap,
        page: getPageBuilder(name, keyMap),
        index: index,
        title: title,
        participatesInRootNavigator: participatesInRootNavigator,
        gestureWidth: gestureWidth,
        maintainState: maintainState,
        curve: curve,
        alignment: alignment,
        parameters: parameters,
        opaque: opaque,
        transitionDuration: transitionDuration,
        popGesture: popGesture,
        binding: binding ?? WarrantyBinding(),
        transition: transition,
        customTransition: customTransition,
        fullscreenDialog: fullscreenDialog,
        children: children,
        middlewares: middlewares,
        unknownRoute: unknownRoute,
        arguments: Get.arguments,
        showCupertinoParallax: showCupertinoParallax,
        preventDuplicates: preventDuplicates,
      );

  static GetPageBuilder getPageBuilder(String name, String keyMap) {
    Routes.getInstance.addRoute(keyMap, name);
    return () => AddWarrantyPage(
          child: AddWarrantyCustomView(),
        );
  }
}
