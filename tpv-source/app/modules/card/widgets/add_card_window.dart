import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart' as en;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/card/domain/usecases/add_card_usecase.dart';
import '/app/modules/card/widgets/encrypt/encryptFromCrt.dart';
import '/app/widgets/botton/rounded_button.dart';
import '/app/widgets/field/input_formater.dart';
import '/app/widgets/utils/loading.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/services/store_service.dart';
import '../../transaction/domain/models/bank_model.dart';
import '../components/card_type.dart';
import '../components/card_utils.dart';
import '../controllers/card_controller.dart';
import '../domain/models/card_model.dart';
import '../domain/models/cordenate_model.dart';

class AddCardWindow extends StatelessWidget {
  final CordenateModel cordenate;

  AddCardWindow({
    Key? key,
    required this.cordenate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StoreService mapFields = StoreService();
    final key = "card";
    final store = mapFields.getStore<String, dynamic>(key);

    final cardNumberController = TextEditingController();
    final cardExpDateController = TextEditingController();
    final cardIDController = TextEditingController();
    final coord1 = TextEditingController();
    final coord2 = TextEditingController();
    final pin1 = TextEditingController();
    final pin2 = TextEditingController();

    String bankCode = '';
    CardType cardType = CardType.Invalid;

    validateFill() {
      //print('ESte es el numerorooooo ${cardNumberController.text.length}');
      if (cardNumberController.text.length == 22 &&
          cardExpDateController.text.length > 4 &&
          coord1.text.length > 1 &&
          coord2.text.length > 1 &&
          pin1.text.isNotEmpty &&
          pin2.text.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }

    final cardController = Get.find<CardController>();

    void getCardtypeFrmNum() {
      if (cardNumberController.text.length > 8) {
        String cardNum = CardUtils.getCleanedNumber(cardNumberController.text);
        CardType type = CardUtils.getCardTypeFrmNumber(cardNum);
        bankCode = cardNum.substring(4, 6);
        log('Este es el bankCodeeeeeee==>$bankCode');
        cardController.update();
        if (type != cardType) {
          cardType = type;
          cardController.update();
        }
      }
    }

    Future<String> getCertificateBank() async {
      //Bank banks = Bank(name: 'empty', code: 'empty', certificate: 'empty');
      BankModel bank = BankModel(name: '', code: '', certificate: '');
      //late int total = 0;

      var listBank = await cardController.getBanks();
      List<BankModel> list = [];
      if (listBank.isRight()) {
        listBank.fold((l) => l.toString(), (r) => {list = r.getList()});
        for (var i = 0; i < list.length; i++) {
          bank = list[i];
          log('Este ese el bankCode que viene==> ${bank.code}');
          log('Este es el bankCode de variable==> $bankCode');
          if (bank.code == bankCode) {
            log('Este es el nombre del banco y el codigo${bank.name}${bank.code}');
            log('Este es el certificado por banco entrante==> ${bank.certificate}');
            return bank.certificate;
          }
        }
      }
      return bank.certificate;
    }

    Future<String> loadEncrypt() async {
      var crt = await getCertificateBank();
      final stringEncrypt =
          '${cordenate.c1}${coord1.text}${cordenate.c2}${coord2.text}${cordenate.p1}${pin1.text}${cordenate.p2}${pin2.text}';
      ////////Encrypt de Perci///////////////////////
      /* SslTlsService ssl = SslTlsService.getInstance;
      final pub = await ssl.getRsaPublicKeyFromStringCert(crt);
      var encryptedb64 = ssl
          .encryptWithRSA(stringEncrypt,
              publicKey: pub,
              privateKey: null,
              type: SslTlsEncodeType.base64,
              encoding: en.RSAEncoding.OAEP)
          .base64; */
      /////Encrypt de PErci cerrado//////////////
      var encryptedb64 = RSAEncrypt()
          .getEncryptCertBank(en.RSAEncoding.OAEP, crt, stringEncrypt);

      return encryptedb64;
    }
    /* Future<String> loadEncrypt() async {
      var crt = await getCertificateBank();
      final stringEncrypt =
          '${cordenate.c1}${coord1.text}${cordenate.c2}${coord2.text}${cordenate.p1}${pin1.text}${cordenate.p2}${pin2.text}';
      
      /* var encryptedb64 = await SslTlsService.cypher(
          data: stringEncrypt, certPath: crt, encoding: en.RSAEncoding.OAEP);
      String encryptb64 = encryptedb64!.base64; */
      return encryptb64;
    } */

    Future<String> loadEncryptPan() async {
      var stringEncrypt = cardNumberController.text;
      log('numero de la tarjeta==> $stringEncrypt');
      var stringReplace = stringEncrypt.replaceAll(' ', '');

      var encryptedb64 = await RSAEncrypt().getEncryptPublicKey(
          en.RSAEncoding.PKCS1,
          stringReplace,
          'assets/raw/enzona_assets_config_pubkey.pem');
      log('Este es el base 64 del loadEncryptPan=> $encryptedb64');
      //String encryptb64 = encrypt!.base64;
      return encryptedb64;
    }

    Future<Either<Failure, CardModel>> addCard() async {
      final datosPerfil = await cardController.getProfile();
      log(' Este es el Cardholder: ${datosPerfil.givenName} ${datosPerfil.familyName}');
      final addCardModel = AddCardModel(
        pan: await loadEncryptPan(),
        cardholder: '${datosPerfil.givenName} ${datosPerfil.familyName}',
        expdate: cardExpDateController.text.replaceAll("/", ""),
        cadenaEncript: await loadEncrypt(),
        cm: cardIDController.text,
      );
      return await cardController
          .addCard(AddUseCaseCardParams(id: addCardModel));

      /* var dd = card.fold((failure) => errorText = failure.message,
        (r) => errorText = 'Tarjeta añadida satisfactoriamente');
    log('ESte es card' + card.toString());
    //update();
    return dd; */
    }

    cardNumberController.addListener(() {
      store.set("cardNumber", cardNumberController.text);
      getCardtypeFrmNum();
    });
    store.getMapFields;
    store.flush();

    Size parentSize = MediaQuery.of(context).size;
    return GetBuilder<CardController>(builder: (controller) {
      log('Estas son las coordenadas que vienen del api?=> ${cordenate.c1 + cordenate.c2 + cordenate.p1 + cordenate.p2}');
      return AlertDialog(
        elevation: 15,
        title: Text(
          'Nueva tarjeta',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            height: parentSize.height * 0.65,
            width: parentSize.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: cardNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                            CardNumberInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            hintText: "Número de la tarjeta",
                            suffixIcon: CardUtils.gedCardIcon(cardType),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Icon(Icons.credit_card),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: cardExpDateController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Expira",
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Icon(Icons.calendar_month),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            CardExpDateInputFormatter(),
                          ],
                        ),
                        TextFormField(
                          controller: cardIDController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Carné militar | Pasaporte ",
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Icon(Icons.wallet),
                            ),
                          ),
                          inputFormatters: [
                            //FilteringTextInputFormatter.,
                            LengthLimitingTextInputFormatter(11),
                            //CardExpDateInputFormatter(),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Telebanca asociada",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  TextFormField(
                                    controller: coord1,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: cordenate.c1,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Icon(Icons.crop),
                                        )),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: coord2,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: cordenate.c2,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Icon(Icons.crop),
                                        )),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: pin1,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: "Pos ${cordenate.p1} del pin",
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Icon(Icons.pin),
                                        )),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: pin2,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: "Pos ${cordenate.p2} del pin",
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Icon(Icons.pin),
                                        )),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        actions: [
          RoundedButton(
            text: "Aceptar",
            press: () async {
              validateFill();
              // final data = store.getMapFields;
              if (validateFill() == true) {
                Navigator.pop(context);
                //var addC = await addCard();
                await showDialog(
                    context: context,
                    builder: (context) {
                      return FutureBuilder(
                          future: addCard(),
                          builder: ((context,
                              AsyncSnapshot<Either<Failure, CardModel>>
                                  snapshot) {
                            if (!snapshot.hasData) {
                              return Loading(
                                style: TextStyle(color: Colors.white),
                              );
                            } else {
                              //var asd = addCard();
                              String textErrorCard = '';
                              if (snapshot.data!.isRight()) {
                                snapshot.data!.fold((l) {
                                  log('Este es el mensaje==> ${l.toString()}');
                                  textErrorCard = l.toString();
                                },
                                    (r) => textErrorCard =
                                        'Tarjeta añadida satisfactoriamente');
                                return AlertDialog(
                                  title: textErrorCard !=
                                          'Tarjeta añadida satisfactoriamente'
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Alerta',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Icon(Icons.warning_amber_rounded,
                                                color: Colors.red)
                                          ],
                                        )
                                      : Container(),
                                  backgroundColor: textErrorCard ==
                                          'Tarjeta añadida satisfactoriamente'
                                      ? Colors.green
                                      : Colors.black,
                                  content: Text(
                                    textErrorCard,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              } else {
                                snapshot.data!.fold((l) {
                                  log('Este es el mensaje==> ${l.getMessage()}');
                                  textErrorCard = l.toString();
                                },
                                    (r) => textErrorCard =
                                        'Tarjeta añadida satisfactoriamente');
                                return AlertDialog(
                                  title: textErrorCard !=
                                              'Tarjeta añadida satisfactoriamente' &&
                                          textErrorCard ==
                                              'Error en el servidor'
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Alerta',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Icon(Icons.warning_amber_rounded,
                                                color: Colors.red)
                                          ],
                                        )
                                      : Container(),
                                  backgroundColor: textErrorCard ==
                                          'Tarjeta añadida satisfactoriamente'
                                      ? Colors.green
                                      : Colors.black,
                                  content: Text(
                                    'No se pudo añadir la tarjeta',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }
                            }
                          }));
                    });
                controller.update(['CardView']);
                cardExpDateController.text = '';
                cardNumberController.text = '';
                cardIDController.text = '';
                coord1.text = '';
                coord2.text = '';
                pin1.text = '';
                pin2.text = '';
              } else {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        insetPadding: EdgeInsets.all(parentSize.width * 0.20),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Alerta',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(Icons.warning_amber_rounded, color: Colors.red)
                          ],
                        ),
                        backgroundColor: Colors.black,
                        content: Text(
                          'Faltan dígitos por ingresar, por favor, revise los campos',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    });
              }
            },
          ),
          RoundedButton(
            text: "Cancelar",
            press: () {
              cardExpDateController.text = '';
              cardIDController.text = '';
              cardNumberController.text = '';
              coord1.text = '';
              coord2.text = '';
              pin1.text = '';
              pin2.text = '';
              Get.back();
            },
          ),
        ],
      );
    });
  }
}
