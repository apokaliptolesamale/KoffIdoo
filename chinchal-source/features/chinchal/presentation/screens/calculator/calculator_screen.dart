import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

import '../../../../../config/router/app_router.dart';
import '../../../../shared/qrflutter/qr_flutter.dart';
import '../../../../shared/widgets/custom_dialog.dart';
import '../../../domain/models/merchant_model.dart';
import '../../../domain/models/qr_code_model.dart';
import '../../providers/merchant_provider.dart';
import 'dynamic_qr_screen.dart';

class CalculatorScreen extends StatelessWidget {
  static const String name = 'calculator';

  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return const Scaffold(body: CalculatorView());
  }
}

class CalculatorView extends ConsumerStatefulWidget {
  // final ChinchalController controller;
  const CalculatorView({
    super.key,
    /*required this.controller*/
  });

  @override
  CalculatorViewState createState() => CalculatorViewState();
}

class CalculatorViewState extends ConsumerState<CalculatorView> {
  String result = '0';
  double toPay = 0.00;
  String toParseInputUser = '';
  String realInputUser = '';
  bool qrVisibility = false;
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;
  bool isSelected = false;
  bool error = false;
  bool hasFloatingActionButton = false;
  final TextEditingController _operationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(child: _displayCalculator());
  }

  Widget _displayCalculator() {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.01),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        // color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.1,
              width: double.infinity,
              child: operationDisplay(height),
            ),
            SizedBox(
              height: height * 0.1,
              width: double.infinity,
              child: evalResultDisplay(context, result),
            ),
            Divider(
              height: height * 0.05,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      acButton(),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('7'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('4'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('1'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('00'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Column(
                    children: [
                      backspaceButton(),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('8'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('5'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('2'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('0'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Column(
                    children: [
                      inputButton('/', color: colors.primary),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('9'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('6'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('3'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('.'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Column(
                    children: [
                      inputButton('*', color: colors.primary),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('-', color: colors.primary),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      inputButton('+', color: colors.primary),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      RawMaterialButton(
                          fillColor: colors.primary,
                          constraints: BoxConstraints(
                            minHeight: height * 0.17,
                            minWidth: width * 0.21,
                          ),
                          onPressed: () async {
                            final numberFormat = NumberFormat.currency(
                                locale: 'en_US', symbol: "\$");
                            final merchantSelected =
                                ref.read(merchantSelectedProvider);
                            if (!result.contains('-') &&
                                result != '\$0.00' &&
                                result != '0') {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              );

                              AddQrCodeModel model = AddQrCodeModel(
                                  amount: result,
                                  currency: merchantSelected!.moneda,
                                  merchantUuid: merchantSelected.uuid,
                                  returnUrl:
                                      'https://nyfycore.enzona.net/ntfy/payment-merchant?user=m${merchantSelected.uuid}&message=completed-$result',
                                  notifyUrl:
                                      'https://nyfycore.enzona.net/ntfy/payment-merchant?user=m${merchantSelected.uuid}&message=scaned');

                              final qrCodeModel = await ref
                                  .read(addQrCodeProvider(model).future);
                              if (qrCodeModel != null) {
                                log(qrCodeModel.toJson().toString());
                                ref.read(goRouterProvider).pop();
                                ref.read(goRouterProvider).pushNamed(
                                    'DynamicQrCode',
                                    pathParameters: {
                                      'amount': numberFormat
                                          .format(double.parse(result)),
                                      'image': qrCodeModel
                                          .image!, //8merchantSelected!.receiveCode!,
                                      'qrcode': qrCodeModel.qrCode!,
                                    });
                              }
                            } else {
                              ref
                                  .read(goRouterProvider)
                                  .pushNamed('DynamicQrCode', pathParameters: {
                                'amount': null.toString(),
                                'image':
                                    'apkenzona/assets/ez.png', //8merchantSelected!.receiveCode!,
                                'qrcode': merchantSelected!.receiveCode!
                              });
                            }
                          },
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            shadows: const [
                              Shadow(
                                  color: Colors.black,
                                  offset: Offset(1, 1),
                                  blurRadius: 10.0)
                            ],
                            Icons.qr_code_2,
                            size: height * 0.07,
                            color: Colors.white,
                          ))
                      //qrButton(ref.read(merchantSelectedProvider.notifier).state!),
                    ],
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget acButton() {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return RawMaterialButton(
      fillColor: colors.primary,
      constraints: BoxConstraints(
        minHeight: height * 0.075,
        minWidth: width * 0.21,
      ),
      onPressed: () {
        setState(() {
          error = false;
          qrVisibility = false;
          hasFocus = false;
          isSelected = false;
          toParseInputUser = '';
          realInputUser = '';
          result = '0';
          _operationController.text = '';
        });
      },
      elevation: 2.0,
      // fillColor: getBackgroundColor(text1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'AC',
        textScaler: TextScaler.noScaling,
        style: GoogleFonts.orbitron(
            shadows: [
              const Shadow(
                  color: Colors.black, offset: Offset(1, 1), blurRadius: 10.0)
            ],
            color: Colors.white,
            fontSize: height * 0.035,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget inputButton(String text, {Color? color}) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return RawMaterialButton(
      fillColor: color ?? colors.primaryContainer,
      constraints: BoxConstraints(
        minHeight: height * 0.075,
        minWidth: width * 0.21,
      ),
      onPressed: () => buttonPressed(text),
      elevation: 2.0,
      // fillColor: getBackgroundColor(text1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        textScaler: TextScaler.noScaling,
        style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: height * 0.035,
            shadows: [
              const Shadow(
                  color: Colors.black, offset: Offset(1, 1), blurRadius: 10.0)
            ],
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget backspaceButton() {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return RawMaterialButton(
        fillColor: colors.primary,
        constraints: BoxConstraints(
          minHeight: height * 0.075,
          minWidth: width * 0.21,
        ),
        onPressed: () {
          setState(() {
            if (toParseInputUser.isNotEmpty) {
              toParseInputUser =
                  toParseInputUser.substring(0, toParseInputUser.length - 1);
            }
            if (realInputUser.isNotEmpty) {
              realInputUser =
                  realInputUser.substring(0, realInputUser.length - 1);
            }
            if (_operationController.text.isNotEmpty) {
              _operationController.text = _operationController.text
                  .substring(0, _operationController.text.length - 1);
            }
            if (toParseInputUser.isEmpty) {
              result = '0';
            } else if (toParseInputUser[toParseInputUser.length - 1] != '/' &&
                toParseInputUser[toParseInputUser.length - 1] != '-' &&
                toParseInputUser[toParseInputUser.length - 1] != '+' &&
                toParseInputUser[toParseInputUser.length - 1] != '*') {
              Parser parser = Parser();
              Expression expression = parser.parse(toParseInputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              result = eval.toString();
              if (!eval.isNaN) {
                error = false;
              }
            }
          });
        },
        elevation: 2.0,
        // fillColor: getBackgroundColor(text2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Icon(
          shadows: const [
            Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 10.0)
          ],
          Icons.backspace,
          color: Colors.white,
          size: height * 0.04,
        ));
  }

  Widget qrButton(MerchantModel? merchantSelected) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return RawMaterialButton(
        fillColor: colors.primary,
        constraints: BoxConstraints(
          minHeight: height * 0.17,
          minWidth: width * 0.21,
        ),
        onPressed: () async {
          final numberFormat =
              NumberFormat.currency(locale: 'en_US', symbol: "\$");
          if (!result.contains('-') && result != '\$0.00' && result != '0') {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const Center(child: CircularProgressIndicator());
              },
            );

            AddQrCodeModel model = AddQrCodeModel(
                amount: result,
                currency: merchantSelected!.moneda,
                merchantUuid: merchantSelected.uuid,
                returnUrl:
                    'https://nyfycore.enzona.net/ntfy/payment-merchant?user=m${merchantSelected.uuid}&message=completed-$result',
                notifyUrl:
                    'https://nyfycore.enzona.net/ntfy/payment-merchant?user=m${merchantSelected.uuid}&message=scaned');

            final qrCodeModel = ref.read(addQrCodeProvider.call(model));
            qrCodeModel.when(
                data: (data) {
                  return DynamicQrCodeScreen(
                    amount: numberFormat.format(double.parse(result)),
                    image: data!.image!,
                    qrcode: data.qrCode!,
                  );
                  /* showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                
                
              },
            ); */
                },
                error: (error, stracktrace) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                        message: error.toString(),
                      );
                    },
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()));
          } else {
            showDialog(
              context: context,
              builder: (context) {
                Size size = MediaQuery.of(context).size;
                return ElasticIn(
                    child: AlertDialog(
                  content: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QrImage(
                          embeddedImageStyle: QrEmbeddedImageStyle(
                            size: const Size(50, 50),
                          ),
                          embeddedImage:
                              const AssetImage('apkenzona/assets/ez.png'),
                          data: merchantSelected!
                              .receiveCode!, //ChinchalController().merchantSelected.receiveCode!,
                          //accountModel.receiveCode,
                          version: QrVersions.auto,
                          size: size.height * 0.3,
                        ),
                        const Text('Qr de comercio ENZONA'),
                      ],
                    ),
                  ),
                ));
              },
            );

            //generateStaticQrCode(merchantSelected!.receiveCode!);
          }
        },
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Icon(
          shadows: const [
            Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 10.0)
          ],
          Icons.qr_code_2,
          size: height * 0.07,
          color: Colors.white,
        ));
  }

  //TODO: Separar el Card en widget independiente reutilizable
  Widget evalResultDisplay(BuildContext context, String result) {
    final numberFormat = NumberFormat.currency(locale: 'en_US', symbol: "\$");
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    if (error == false) {
      if (numberFormat.format(double.parse(result)).length < 12) {
        return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(height * 0.02)),
            child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: Text(
                  //
                  numberFormat.format(double.parse(result)),
                  textScaler: TextScaler.noScaling,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: textTheme.displaySmall,
                )));
      } else {
        return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(height * 0.02)),
            child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: Text(numberFormat.format(double.parse(result)),
                    textScaler: TextScaler.noScaling,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge)));
      }
    } else {
      return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(height * 0.02)),
          child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: Text('Error',
                  maxLines: 1,
                  textScaler: TextScaler.noScaling,
                  overflow: TextOverflow.visible,
                  style: textTheme.displaySmall)));
    }
  }

  Card operationDisplay(double height) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(height * 0.02)),
      child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: realInputUser.length < 13
              ? TextField(
                  textAlign: TextAlign.right,
                  controller: _operationController,
                  focusNode: focusNode,
                  enabled: false,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                    hintStyle: TextStyle(color: Color(0xFF414141)),
                  ),
                  style: textTheme.displaySmall,
                  onChanged: (text) {
                    // Actualizar el resultado en tiempo real
                    _updateResult(text);
                  },
                )
              // color: const Color(0xFF414141),
              //   fontSize: height / 26,
              : TextField(
                  textAlign: TextAlign.right,
                  controller: _operationController,
                  focusNode: focusNode,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                    hintStyle: textTheme.displaySmall,
                  ),
                  style: textTheme.displaySmall,
                  onChanged: (text) {
                    // Actualizar el resultado en tiempo real
                    _updateResult(text);
                  },
                )),
    );
  }

  void _updateResult(String lastCharacter) {
    setState(() {
      // Verifica que el último carácter sea un dígito
      if (RegExp(r'^[0-9]$').hasMatch(lastCharacter)) {
        toParseInputUser += lastCharacter;
        realInputUser += lastCharacter;
        _operationController.text =
            realInputUser; // Aquí usamos realInputUser que es el que muestra la operación completa al usuario.

        try {
          // Intentamos parsear y evaluar la expresión cada vez que se añade un nuevo dígito.
          Parser parser = Parser();
          Expression expression = parser.parse(toParseInputUser);
          ContextModel contextModel = ContextModel();
          double eval = expression.evaluate(EvaluationType.REAL, contextModel);

          error = false;
          result = eval.toString();
          hasFocus = true;
          isSelected = true;
          qrVisibility = !result.contains('-');
          hasFloatingActionButton = qrVisibility;
        } catch (e) {
          setState(() {
            error = true;
            result = 'Error';
          });
        }
      }
    });
  }

  void buttonPressed(String buttonText) {
    setState(() {
      if (RegExp(r'^[0-9]$').hasMatch(buttonText)) {
        // Si es un número, actualiza el resultado y añade el texto al controlador
        _updateResult(buttonText);
      } else {
        // Aquí manejarías si se presionó un operador o cualquier otro botón que no sea número
        if (buttonText == '+' ||
            buttonText == '-' ||
            buttonText == '*' ||
            buttonText == '/' ||
            buttonText == '.') {
          toParseInputUser += buttonText;
          realInputUser += buttonText;
          _operationController.text = realInputUser;
          // No llamar a _updateResult ya que no es un dígito
        }
        // Manejar otros botones como 'AC' o 'backspace' de acuerdo a su lógica específica.
      }
    });
  }

  generateStaticQrCode(String receiveCode) {
    showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return ElasticIn(
            child: AlertDialog(
          content: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImage(
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: const Size(50, 50),
                  ),
                  embeddedImage: const AssetImage('apkenzona/assets/ez.png'),
                  data:
                      receiveCode, //ChinchalController().merchantSelected.receiveCode!,
                  //accountModel.receiveCode,
                  version: QrVersions.auto,
                  size: size.height * 0.3,
                ),
                const Text('Qr de comercio ENZONA'),
              ],
            ),
          ),
        ));
      },
    );
  }
}
