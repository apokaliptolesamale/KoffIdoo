import 'dart:convert';
import 'dart:developer';

import '/app/core/config/errors/errors.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/modules/transaction/widgets/payments_widgets/invoice_detail_widget.dart';
import '/remote/basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart' as dart;
import '../../../../core/services/store_service.dart';
import '../../../../widgets/utils/loading.dart';
import '../../../card/controllers/card_controller.dart';
import '../../../card/domain/models/card_model.dart';
import '../../../security/domain/models/account_model.dart';
import '../../controllers/clientinvoice_controller.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/models/invoice_charged_model.dart';
import '../../domain/models/payment_model.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'credit_card_payment_widget.dart';
import 'invoice_unpaid_gas_widget.dart';

class InvoiceGasDetailWidget extends StatefulWidget {
  Invoice invoice;
  String month;
  InvoiceGasDetailWidget(
      {super.key, required this.invoice, required this.month});

  @override
  State<InvoiceGasDetailWidget> createState() => _InvoiceGasDetailWidgetState();
}

class _InvoiceGasDetailWidgetState extends State<InvoiceGasDetailWidget> {
  @override
  Widget build(BuildContext context) {
    //List<Invoice> invoices = widget.invoice.invoices;
    /* bool charged = false;
    bool discount = false;
    bool bankDebitDetailDiscount = false;
    bool isChargedStatus = false;
    bool isThisAccountId = false;*/
    AccountModel account = Get.find<AccountModel>();

    return Scaffold(
      appBar: AppBar(
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
                    Text(widget.invoice.municipio!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                            fontSize:
                                MediaQuery.of(context).size.width * 0.04)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '-${widget.invoice.importe!} ',
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto",
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
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
                                  MediaQuery.of(context).size.width * 0.04),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Segundo Column
              InvoiceUnPaidWidget(
                month: widget.month,
                invoice: widget.invoice,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 80,
              ),
              getCard(context),

              TextButton(
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
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Colors.white),
                      ),
                    ),
                  )) //: Container(height: 1,),
            ],
          ),
        ),
      ),
    );
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
                    final form =
                        StoreService().getStore("payElectricityService");
                    form.add('funding_source_uuid', card.fundingSourceUuid);
                  },
                );
              });
            }
          }),
    );
  }

  Future<String> cifrar(String texto) async {
    var certPuk = await rootBundle
        .loadString('assets/raw/enzona_assets_config_pubkey.pem');
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

  Widget enterPaymentPassword(BuildContext context) {
    TextEditingController controllerEdit = TextEditingController();
    String date = widget.invoice.invoiceDate!.toString();
    return AlertDialog(
      actions: [
        Align(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: () async {
                ClientInvoiceController controller =
                    Get.find<ClientInvoiceController>();
                final form = StoreService().getStore("payElectricityService");
                Map<String, dynamic> meta = {
                  "cobrador": widget.invoice.cobrador,
                  "Libro": widget.invoice.libro,
                  "IdMunicipio": widget.invoice.idMunicipio,
                  "Municipio": widget.invoice.municipio,
                  "DatosContrato": widget.invoice.datosContrato,
                  "Metro": widget.invoice.metro
                };
                String password = controllerEdit.text;
                if (password != '') {
                  password = await cifrar(password);
                }
                String metadataString = json.encode(meta);
                form.add('service_code', ServicesPayment.byName("Gas"));
                form.add('client_id', widget.invoice.code);
                form.add('owner', widget.invoice);
                form.add('metadata', metadataString);
                form.add('automatic', "false");
                form.add('period', date);
                form.add('amount', widget.invoice.importe);
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
}
