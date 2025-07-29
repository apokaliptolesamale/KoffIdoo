// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart' as dart;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/app/core/config/assets.dart';
import '/app/core/constants/enums.dart';
import '/app/core/constants/style.dart';
import '/app/core/services/logger_service.dart';
import '/app/modules/product/controllers/product_controller.dart';
import '/app/modules/product/domain/models/product_model.dart';
import '/app/modules/qrcode/views/pages/qr_scan_page.dart';
import '/app/widgets/botton/custom_icon_botton.dart';
import '/app/widgets/promise/custom_future_builder.dart';
import '/app/widgets/text/custom_text_form_field.dart';
import '/app/widgets/text/custom_text_trigger.dart';
import '../../../core/helpers/functions.dart';
import '../../../core/services/store_service.dart';
import '../../../routes/app_routes.dart';

// Create a Form widget.
class ProductScanneableCustomForm extends StatefulWidget {
  ProductModel product;
  GlobalViewMode mode;
  void Function(ProductScanneableCustomForm)? onPressed;
  ProductScanneableCustomFormState? _state;
  ProductScanneableCustomForm({
    Key? key,
    required this.product,
    required this.mode,
    this.onPressed,
  });

  ProductScanneableCustomFormState get getState => _state ?? createState();

  @override
  ProductScanneableCustomFormState createState() =>
      _state = ProductScanneableCustomFormState();

  Map<String, dynamic> getData() {
    if (getState.mounted) {
      return getState.getData();
    }
    return {};
  }

  bool isValid() {
    if (getState.mounted) {
      return getState.isValid();
    }
    return false;
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ProductScanneableCustomFormState
    extends State<ProductScanneableCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  late GlobalViewMode? mode;

  late ProductModel product;

  afterBuild() {
    if (mounted &&
        (product.mark == null ||
            product.mark != null && product.mark!.isEmpty) &&
        product.code != null) {
      updateProduct(product).then((value) {
        if (value != null) {
          setState(() {
            product = widget.product = value;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (Get.arguments == null) {
      _FormFields.instance.flush();
    }
    /*
    //TODO actualizar los datos del producto desde el servicio de datos primarios.
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: size.width,
      child: getProductForm(_formKey),
    );
    */
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: size.width,
      child: CustomFutureBuilder(
        future: updateProduct(product),
        builder: getProductBuilder(),
        context: context,
      ),
    );
  }

  Future<ProductModel?> checkProductByCode(String code) async {
    final ctl = Get.find<ProductController>();
    final result =
        await ctl.checkUseProduct.setParamsFromMap({"code": code}).call(null);
    return result.fold((l) => null, (product) {
      //Significa que no existe producto alguno con ese código
      if (product.code == null ||
          product.code != null && product.code!.isEmpty) {
        return null;
      }
      return product;
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget getAcceptBotton() {
    return Container(
      height: 40,
      width: 250,
      margin: EdgeInsets.only(top: 25),
      child: MaterialButton(
        onPressed: () {
          //final ctl = Get.find<ProductController>();
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

  Map<String, dynamic> getData() => _FormFields.instance.mapFields;

  AsyncWidgetBuilder<A> getProductBuilder<A>() {
    builder(BuildContext context, AsyncSnapshot<A> snapshot) {
      /*final waiting = isWaiting(snapshot);
      final done = isDone(snapshot);
      final error = isError(snapshot);
      if (waiting) {
        return EmptyDataSearcherResult(
          child: Loading.fromText(text: "Iniciando formulario de producto..."),
        );
      } else if (done) {
        final dart.Right resultData = snapshot.data as dart.Right;

        return getProductForm(_formKey);
      } else if (error) {
        return Loading.fromText(text: snapshot.error.toString());
      }*/

      //return Loading.fromText(text: "Iniciando formulario de producto...");
      return getProductForm(_formKey);
    }

    return builder;
  }

  Widget getProductForm(Key key) {
    final sello = product.getWarrantyPayLoad.isNotEmpty &&
            product.getWarrantyPayLoad.containsKey("sello")
        ? product.getWarrantyPayLoad["sello"]
        : "Sin sello";
    final serieOne = product.getWarrantyPayLoad.isNotEmpty &&
            product.getWarrantyPayLoad.containsKey("serieOne")
        ? product.getWarrantyPayLoad["serieOne"]
        : "Sin No. serie";
    final serieTwo = product.getWarrantyPayLoad.isNotEmpty &&
            product.getWarrantyPayLoad.containsKey("serieTwo")
        ? product.getWarrantyPayLoad["serieTwo"]
        : "Sin No. serie";
    final precio =
        product.salePrice > 0 ? "${product.salePrice}" : "Sin precio";
    final form = Container(
      margin: const EdgeInsets.only(right: 5, left: 5, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, bottom: 5, top: 30),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF3F888C).withOpacity(0.09),
                      blurRadius: 2.0,
                      spreadRadius: 2, //New
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Datos del producto:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    /*CustomOutlinedIconButton(
                      color: Colors.white,
                      onPressed: <CustomOutlinedIconButton>(ctx, btn) async {
                        final tmpProduct =
                            await checkProductByCode(product.code!);
                        if (tmpProduct != null) {
                          setState(() {
                            product.merge(widget.product = tmpProduct);
                          });
                        }
                      },
                      text: "",
                      icon: Container(
                        child: Icon(Icons.update),
                      ),
                    )*/
                  ],
                ),
              ),
            ),
            CustomTriggerTextFormField(
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
                name: "articulo",
                focusNode: FocusNode(),
                labelText: "Nombre del producto",
                controller: TextEditingController(
                  text: product.name,
                ),
                value: product.name,
                enabled: widget.mode == GlobalViewMode.enabled,
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
            CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: widget.mode == GlobalViewMode.enabled,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
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
                name: "code",
                focusNode: FocusNode(),
                labelText: "Código",
                enabled: widget.mode == GlobalViewMode.enabled,
                value: product.code,
                controller: TextEditingController(
                  text: product.code,
                ),
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
                  }
                  return null;
                },
              ),
            ),
            CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: widget.mode == GlobalViewMode.enabled,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      return Future.value(
                        StoreService()
                            .set(
                              key,
                              "mark",
                              code.code!,
                            )
                            .getStore(key)
                            .getMapFields,
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
                name: "mark",
                focusNode: FocusNode(),
                labelText: widget.product.mark != null &&
                        widget.product.mark!.isNotEmpty
                    ? widget.product.mark!
                    : "Marca",
                value: product.mark,
                controller: TextEditingController(
                  text: product.mark,
                ),
                enabled: widget.mode == GlobalViewMode.enabled,
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
            CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: widget.mode == GlobalViewMode.enabled,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      return Future.value(
                        StoreService()
                            .set(key, "model", code.code!)
                            .getStore(key)
                            .getMapFields,
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
                name: "model",
                focusNode: FocusNode(),
                labelText: widget.product.model != null &&
                        widget.product.model!.isNotEmpty
                    ? widget.product.model!
                    : "Modelo",
                value: product.model,
                controller: TextEditingController(
                  text: product.model,
                ),
                enabled: widget.mode == GlobalViewMode.enabled,
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
            CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: widget.mode == GlobalViewMode.enabled,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      return Future.value(
                        StoreService()
                            .set(key, "sello", code.code!)
                            .getStore(key)
                            .getMapFields,
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
                name: "sello",
                focusNode: FocusNode(),
                labelText: "No. de sello",
                keyboardType: TextInputType.name,
                value: sello,
                controller: TextEditingController(
                  text: sello,
                ),
                enabled: widget.mode == GlobalViewMode.enabled,
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
            CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: widget.mode == GlobalViewMode.enabled,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      return Future.value(
                        StoreService()
                            .set(key, "serieOne", code.code!)
                            .getStore(key)
                            .getMapFields,
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
                name: "serieOne",
                focusNode: FocusNode(),
                labelText: "No. Serie 1",
                keyboardType: TextInputType.number,
                value: serieOne,
                controller: TextEditingController(
                  text: serieOne,
                ),
                enabled: widget.mode == GlobalViewMode.enabled,
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
            CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: widget.mode == GlobalViewMode.enabled,
              botton: CustomOutlinedIconButton(
                color: Colors.white,
                onPressed: <CustomOutlinedIconButton>(ctx, btn) {
                  QrScanPage.onScan = (code) async {
                    try {
                      return Future.value(
                        StoreService()
                            .set(key, "serieTwo", code.code!)
                            .getStore(key)
                            .getMapFields,
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
                name: "serieTwo",
                focusNode: FocusNode(),
                labelText: "No. Serie 2",
                keyboardType: TextInputType.number,
                value: serieTwo,
                controller: TextEditingController(
                  text: serieTwo,
                ),
                enabled: widget.mode == GlobalViewMode.enabled,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
              ),
            ),
            CustomTriggerTextFormField(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              visibleTriggerBotton: widget.mode == GlobalViewMode.enabled,
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
                name: "price",
                focusNode: FocusNode(),
                labelText: "Precio",
                keyboardType: TextInputType.number,
                value: precio,
                controller: TextEditingController(
                  text: precio,
                ),
                enabled: widget.mode == GlobalViewMode.enabled,
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
            Center(child: getAcceptBotton()),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );

    return form;
  }

  @override
  initState() {
    product = widget.product;
    mode = widget.mode;
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());
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

  bool isValid() {
    return _formKey.currentState != null
        ? _formKey.currentState!.validate()
        : false;
  }

  bool isWaiting(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.waiting;
  }

  Future<ProductModel?> updateProduct(ProductModel prod) async {
    final ctl = Get.find<ProductController>();
    if (prod.mark == null) {
      ProductModel? tmpProduct = await checkProductByCode(prod.code!);
      if (tmpProduct != null) {
        product = product.merge(tmpProduct);
        log("Actualizando producto:${product.name}");
        final result = await ctl.updateProduct.setParamsFromMap({
          "id": product.id,
          "code": product.code,
          "entity": product,
        }).call(null);
        return result.fold((l) {
          error(l.getMessage());
          return prod;
        }, (r) {
          if (mounted) {
            setState(() {
              product = widget.product = r;
            });
          }
          return r;
        });
      }
    }
    return Future.value(prod);
  }
}

class _FormFields {
  static final _FormFields instance = _FormFields._internal({});

  Map<String, String> mapFields;

  _FormFields._internal(this.mapFields);

  add(String key, String value) {
    mapFields.addIf(true, key, value);
    return mapFields;
  }

  flush() {
    mapFields = {};
    return this;
  }
}
