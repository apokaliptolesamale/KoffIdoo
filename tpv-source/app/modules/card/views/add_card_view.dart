import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart' as en;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../widgets/utils/size_constraints.dart';
import '/app/core/services/logger_service.dart';
import '/app/modules/card/domain/usecases/add_card_usecase.dart';
import '/app/modules/card/widgets/encrypt/encryptFromCrt.dart';
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

class AddCardView extends GetResponsiveView<CardController> {
  final CordenateModel cordenate;

  AddCardView({
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
    Size size = MediaQuery.of(context).size;
    SizeConstraints sizeC = SizeConstraints(context: context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return GetBuilder<CardController>(builder: (controller) {
      log('Estas son las coordenadas que vienen del api?=> ${cordenate.c1 + cordenate.c2 + cordenate.p1 + cordenate.p2}');
      return Scaffold(
        appBar: AppBar(
          leadingWidth: size.width / 20,
          title: Text(
            'Adicionar tarjeta',
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: sizeC.getWidthByPercent(5),
              fontWeight: FontWeight.w500,
            ),
          ), //const Text("Tarjetas de banco"),
          leading: IconButton(
              iconSize: size.width / 20,
              splashRadius: 25,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height / 60),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cardNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                            CardNumberInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            label: Text('Número de la tarjeta'),
                            border: OutlineInputBorder(),
                            hintText: "**** **** **** ****",
                            suffixIcon: CardUtils.gedCardIcon(cardType),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Icon(Icons.credit_card),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Campo requerido";
                            }
                            if (value.length < 16) {
                              return "Introduzca un número de tarjeta válido";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cardExpDateController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text('Expira'),
                            border: OutlineInputBorder(),
                            hintText: "12/21",
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo requerido';
                            }
                            if (value.length < 4) {
                              return 'Faltan dígitos por ingresar';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cardIDController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text('Carné militar | Pasaporte (Opcional)'),
                            border: OutlineInputBorder(),
                            hintText: "***********",
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
                          validator: (value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                value.length < 11) {
                              return 'Este campo requiere de mas dígitos';
                            }
                            return null;
                          },
                        ),
                      ),
                      /* SizedBox(
                        height: size.height / 80,
                      ), */
                      Container(
                        decoration: BoxDecoration(
                            // border: Border.all(width: 3, color: Colors.grey),
                            ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: size.width / 20,
                            left: size.width / 20,
                            top: size.height / 80,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Telebanca asociada",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width / 20,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height / 50,
                                  ),
                                  child: TextFormField(
                                    controller: coord1,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        label:
                                            Text('Coordenada ${cordenate.c1}'),
                                        border: OutlineInputBorder(),
                                        hintText: '**',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Icon(Icons.crop),
                                        )),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo requerido';
                                      }
                                      if (value.length < 2) {
                                        return 'Faltan dígitos por ingresar';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height / 80),
                                  child: TextFormField(
                                    controller: coord2,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        label:
                                            Text('Coordenada ${cordenate.c2}'),
                                        border: OutlineInputBorder(),
                                        hintText: '**',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Icon(Icons.crop),
                                        )),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo requerido';
                                      }
                                      if (value.length < 2) {
                                        return 'Faltan dígitos por ingresar';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height / 80),
                                  child: TextFormField(
                                    controller: pin1,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        label: Text(
                                            'Posición ${cordenate.p1} del pin'),
                                        border: OutlineInputBorder(),
                                        hintText: "*",
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Icon(Icons.pin),
                                        )),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo requerido';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height / 80),
                                  child: TextFormField(
                                    controller: pin2,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        label: Text(
                                            'Posición ${cordenate.p2} del pin'),
                                        border: OutlineInputBorder(),
                                        hintText: "*",
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Icon(Icons.pin),
                                        )),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo requerido';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('CANCELAR'),
                    onPressed: () {
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
                  SizedBox(
                    width: size.width / 40,
                  ),
                  ElevatedButton(
                    child: Text('ACEPTAR'),
                    onPressed: () async {
                      //validateFill();
                      if (formKey.currentState!.validate()) {
                        final data = store.getMapFields;
                        Navigator.pop(context);
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
                                        text: "Adicionando Tarjeta...",
                                        backgroundColor:
                                            Colors.lightBlue.shade700,
                                        animationColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Colors.lightBlue.withOpacity(0.8)),
                                        containerColor: Colors.lightBlueAccent
                                            .withOpacity(0.2),
                                      );
                                    } else {
                                      String textErrorCard = '';
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
                                                  Icon(
                                                      Icons
                                                          .warning_amber_rounded,
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
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }
                                  }));
                            });
                      }
                      controller.update(['CardView']);
                      cardExpDateController.text = '';
                      cardNumberController.text = '';
                      cardIDController.text = '';
                      coord1.text = '';
                      coord2.text = '';
                      pin1.text = '';
                      pin2.text = '';
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
