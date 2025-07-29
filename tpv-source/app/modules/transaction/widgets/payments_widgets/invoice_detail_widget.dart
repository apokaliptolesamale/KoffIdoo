import 'dart:convert';

import 'package:dartz/dartz.dart' as dart;
import '/app/modules/security/domain/models/account_model.dart';
import '/app/modules/transaction/domain/entities/bank_debit_detail.dart';
import '/app/modules/transaction/widgets/payments_widgets/account_card_widget.dart';
import '../../domain/models/payment_model.dart';
import '/app/modules/transaction/domain/entities/invoice_charged.dart';
import '/app/modules/transaction/domain/models/invoice_charged_model.dart';
import '/app/modules/transaction/widgets/discount_amount_widget.dart';
import '/app/widgets/utils/loading.dart';
import '/app/core/services/logger_service.dart';
import '/app/modules/transaction/clientinvoice_exporting.dart';
import '/remote/basic_utils/basic_utils.dart';
import 'package:flutter/services.dart';
import '/app/core/config/errors/errors.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/services/store_service.dart';
import '/app/modules/card/controllers/card_controller.dart';
import '/app/modules/card/domain/models/card_model.dart';
import '/app/modules/transaction/domain/entities/invoice.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '/app/modules/transaction/widgets/payments_widgets/credit_card_payment_widget.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
// ignore_for_file: must_be_immutable

import 'invoice_properties_ez.dart';
import 'invoice_properties_simple.dart';

class InvoiceDetailWidget extends StatefulWidget {
  String? consumption;
  Invoice? invoice;
  InvoiceCharged? invoiceCharged;
  BuildContext? context;
  String? chargedI;
  InvoiceDetailWidget(
      {Key? key,
      this.invoice,
      this.invoiceCharged,
      this.context,
      this.consumption,
      this.chargedI})
      : super(key: key);

  @override
  _InvoiceDetailWidgetState createState() => _InvoiceDetailWidgetState();
}

Widget getCard(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  CardController cardController = Get.find<CardController>();
  return Container(
    color: Colors.transparent,
    height: 50,
    width: double.infinity,
    child: FutureBuilder(
        future: cardController.getCards(),
        //AsyncSnapshot<Either<Failure, EntityModelList<CardModel>>
        builder: (context,
            AsyncSnapshot<dart.Either<Failure, EntityModelList<CardModel>>>
                snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return snapshot.data!.fold((l) {
              l.message;
              return AlertDialog();
            }, (r) {
              final form = StoreService().getStore("payElectricityService");
              List<CardModel> list = r.getList();
              CardModel? cardDefault;
              for (int i = 0; i < list.length; i++) {
                if (list[i].primarySource == "true") {
                  cardDefault = list[i];
                }
              }
              form.add('funding_source_uuid', cardDefault!.fundingSourceUuid);
              return CreditCardDropdown(
                context: context,
                cards: list,
                initialCard: cardDefault,
                onCardSelected: (card) {
                  final form = StoreService().getStore("payElectricityService");
                  form.add('funding_source_uuid', card.fundingSourceUuid);
                },
              );
            });
          }
        }),
  );
}

Widget getInfoCard(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.8,
    height: size.height * 0.2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 10,
          child: Padding(
            padding: EdgeInsets.only(left: size.width / 80),
            child: Image.asset(
              "assets/images/backgrounds/enzona/banmet.png",
              width: size.width / 20,
              height: size.height / 20,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.04,
        ),
        Expanded(
          flex: 10,
          child: Container(
            width: size.width * 0.6,
            height: size.height * 0.1,
            child: Center(
              child: Text(
                'account',
                style: TextStyle(fontSize: size.width * 0.03),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.02,
        ),
        Expanded(
          flex: 10,
          child: Container(
            width: size.width * 0.1,
            height: size.height * 0.1,
            child: Center(
              child: Text(
                '',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.01,
        ),
      ],
    ),
  );
}

Future<String> cifrar(String texto) async {
  var certPuk =
      await rootBundle.loadString('assets/raw/enzona_assets_config_pubkey.pem');
  final publicKey = encrypt.RSAKeyParser().parse(certPuk) as RSAPublicKey;

  final encrypter = encrypt.Encrypter(encrypt.RSA(
    publicKey: publicKey,
  ));

  final encrypted = encrypter.encrypt(texto);

  texto = encrypted.base64;
  //String test = encrypted.base64;

  log("Este es contraseña pa pagar factura Cifrada>>>>>>>>>>>>>>>>>> $texto");
  //log("Este es Texto Cifrado TEST>>>>>>>>>>>>>>>>>> $test");
  return texto;
}

class _InvoiceDetailWidgetState extends State<InvoiceDetailWidget> {
  List<dynamic> data = [];

  @override
  Widget build(BuildContext context) {
    //List<Invoice> invoices = widget.invoice.invoices;
    bool charged = false;
    bool discount = false;
    bool bankDebitDetailDiscount = false;
    bool isChargedStatus = false;
    bool isThisAccountId = false;
    AccountModel account = Get.find<AccountModel>();
    if (widget.invoice!.charged! == "true" || widget.invoice!.pagado == "1") {
      charged = true;
    } else if (widget.invoice!.charged! == "false" ||
        widget.invoice!.pagado == "0") {
      charged = false;
    }
    if (widget.chargedI == "true") {
      charged = true;
    } else if (widget.chargedI == "false") {
      charged = false;
    }
    if (widget.invoice!.accountId != null) {
      isChargedStatus = true;
    } else {
      isChargedStatus = false;
    }

    if (widget.invoice!.discount != "0" && widget.invoice!.discount != "") {
      discount = true;
    } else if (widget.invoice!.importe != "0") {
      discount = false;
    }
    if (widget.invoice!.invoiceEz != "") {
      isThisAccountId = true;
    } else {
      isThisAccountId = false;
    }
    return Scaffold(
      appBar: charged
          ? AppBar(
              backgroundColor: Colors.grey,
              surfaceTintColor: Colors.red,
              flexibleSpace: Container(
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              title: Text("Detalles"),
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Get.back();
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {},
                  child:
                      Text("Reclamar", style: TextStyle(color: Colors.white)),
                )
              ],
            )
          : AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                        fit: BoxFit.fill)),
              ),
              title: Text("Pagar Factura"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Primer Column
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.04,
                      child: Image.asset(
                          'assets/images/backgrounds/enzona/ic_pago_electricidad.png'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Text('Empresa Electrica',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                            fontSize:
                                MediaQuery.of(context).size.width * 0.04)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    charged
                        ? Column(
                            children: [
                              Text(
                                'Factura pagada',
                                style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Roboto",
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    color: Colors.green),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 60,
                              )
                            ],
                          )
                        : isChargedStatus
                            ? Column(
                                children: [
                                  getStatus(context, widget.invoiceCharged!),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 60,
                                  )
                                ],
                              )
                            : SizedBox(
                                height: 1,
                              ),
                    !discount
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '-${widget.invoice!.amount!} ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Roboto",
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width / 80,
                              ),
                              Text(
                                'CUP ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Roboto",
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              ),
                            ],
                          )
                        : DiscountPriceWidget(
                            invoice: widget.invoice!,
                            discountPrice: (widget.invoice!.bankDebitDetail
                                    as BankDebitDetail)
                                .debited!,
                            originalPrice: widget.invoice!.totalAmount!,
                            discount: widget.invoice!.discount!,
                            currency: widget.invoice!.currency!,
                            context: context,
                          ),
                  ],
                ),
              ),
              // Segundo Column
              charged && widget.invoice!.username == account.username
                  ? InvoicePropertiesEz(
                      consumption: widget.consumption,
                      invoice: widget.invoice,
                    )
                  : charged && widget.invoice!.username != account.username
                      ? InvoicePropertiesWidget(
                          invoice: widget.invoice,
                        )
                      : Container(
                          height: 0,
                        ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 80,
              ),
              !charged
                  ? getCard(context)
                  : charged && widget.invoice!.username == account.username
                      ? AccountCardWidget(
                          invoice: widget.invoice,
                        )
                      : charged && widget.invoice!.username == account.username
                          ? SizedBox(
                              height: 0,
                            )
                          : Container(),

              !charged
                  ? TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return enterPaymentPassword(context);
                            });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: MediaQuery.of(context).size.height * 0.070,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Pagar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                color: Colors.white),
                          ),
                        ),
                      )) //: Container(height: 1,),
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                    )
            ],
          ),
        ),
      ),
    );
  }

  getInvoiceCharged(dart.Either<Failure, InvoiceChargedModel> payment,
      BuildContext context, Invoice? invoice) {
    payment.fold((l) {
      l.message;

      Get.back();
      Get.defaultDialog(middleText: l.message);
    }, (r) {
      InvoiceChargedModel invoiceCharged = r;
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => InvoiceDetailWidget(
            invoiceCharged: invoiceCharged,
            invoice: invoice,
          ),
        ),
      );
    });
  }

  Widget enterPaymentPassword(BuildContext context) {
    TextEditingController controllerEdit = TextEditingController();
    String date = widget.invoice!.invoiceDate!.toString();
    return AlertDialog(
      actions: [
        Align(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: () async {
                ClientInvoiceController controller =
                    Get.find<ClientInvoiceController>();
                final form = StoreService().getStore("payElectricityService");
                Map<String, dynamic> metadataJson = {
                  "folio": widget.invoice!.folio,
                  "route": widget.invoice!.route,
                };
                String password = controllerEdit.text;
                if (password != '') {
                  password = await cifrar(password);
                }
                String metadataString = json.encode(metadataJson);
                form.add(
                    'service_code', ServicesPayment.byName("Electricidad"));
                form.add('client_id', widget.invoice!.clientId);
                form.add('owner', widget.invoice!.owner);
                form.add('metadata', metadataString);
                form.add('automatic', "false");
                form.add('period', date);
                form.add('amount', widget.invoice!.amount);
                form.add('payment_password', password);
                Navigator.pop(context);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Loading(
                        text: "Esperando resultado de su transferencia...",
                        backgroundColor: Colors.lightBlue.shade700,
                        animationColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightBlue.withOpacity(0.8)),
                        containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                      );
                    });
                controller.payServiceUseCase
                    .setParamsFromMap(form.getMapFields);
                dart.Either<Failure, InvoiceChargedModel> paymentPayload =
                    await controller.payServiceUseCase.payService();
                getInvoiceCharged(paymentPayload, context, widget.invoice);
                log("ESTOS SON LOS CAMPOS DEL FORMULARIO DE PAGAR FACTURA ${form.getMapFields.toString()}");
                log("NAVEGANDO HACIA DETALLES DE FACTURA PAGADA...");
                //Get.toNamed(Routes.getInstance.getPath("ELECTRICITY_PAY_SERVICE"));
                // Get.to(()=>PayElectricityServiceFrame());
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.30,
                height: MediaQuery.of(context).size.height * 0.070,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Aceptar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.white),
                  ),
                ),
              )),
        )
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      scrollable: true,
      titlePadding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
      title: Center(child: Text("Pagar factura")),
      contentPadding: EdgeInsets.only(
          left: 5, right: 5, top: MediaQuery.of(context).size.height / 30),
      elevation: 10,
      //title: Text('Material Dialog'),
      // ignore: sized_box_for_whitespace
      content: Container(
          //color: Colors.red,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Form(
            child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  value = controllerEdit.text;
                  //log(controllerEdit.text);
                },
                controller: controllerEdit,
                decoration: InputDecoration(
                    errorBorder: InputBorder.none,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          controllerEdit.clear();
                        },
                        child: Icon(Icons.close)),
                    label: Text("Introduzca su contraseña de pago"),
                    border: OutlineInputBorder())),
          )),
    );
  }

  Widget getStatus(BuildContext context, InvoiceCharged invoiceCharged) {
    String? texto;
    Color color = Colors.black;
    switch (invoiceCharged.status) {
      case "Aceptada":
        color = Colors.green;
        texto = "Confirmada";
        break;
      case "Fallida":
        color = Colors.red;
        texto = "Fallida";
        break;
      case "Pendiente":
        color = Colors.orange;
        texto = "Pendiente";
        break;
      default:
    }

    return Text(
      'Factura $texto',
      style: TextStyle(
          fontWeight: FontWeight.w200,
          fontFamily: "Roboto",
          fontSize: MediaQuery.of(context).size.width * 0.04,
          color: color),
    );
  }
}
