import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/app/core/services/store_service.dart';
import '/app/modules/transaction/domain/models/payment_model.dart';
import '/app/modules/transaction/views/search_invoice_view.dart';
import '../../views/get_list_factura_gas_view.dart';

class PayElectricityInvoiceWidget extends StatefulWidget {
  BuildContext context;
  int? serviceCode;
  PayElectricityInvoiceWidget(
      {Key? key, required this.context, this.serviceCode});

  @override
  State<PayElectricityInvoiceWidget> createState() =>
      _PayElectricityInvoiceWidgetState();
}

class _PayElectricityInvoiceWidgetState
    extends State<PayElectricityInvoiceWidget> {
  final _formKey = GlobalKey<FormState>();
  final controllerEdit = TextEditingController();
  bool _isButtonEnabled = false;
  final _regExp = RegExp(r'^\d{0,13}$');

  void _onTextChanged() {
    final text = controllerEdit.text;
    setState(() {
      _isButtonEnabled = _regExp.hasMatch(text) && text.length == 13;
    });
  }

  /* Future<dart.Either<Failure, EntityModelList<ClientInvoiceModel>>> getClientId(ClientInvoiceController controller) async{
         var invoiceCharge =  await controller.getClient();
       
    }*/
  @override
  Widget build(BuildContext context) {
    final form = StoreService().getStore("InvoiceForm");
    return AlertDialog(
      actions: [
        Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () async {
                  int? codeE = ServicesPayment.byCodeName("Electricidad");
                  int? codeG = ServicesPayment.byCodeName("Gas");
                  if (_formKey.currentState!.validate() &&
                      widget.serviceCode == 2222) {
                    String value = controllerEdit.text;
                    form.add("clientId", value);
                    form.add("serviceCode", 2222);
                    // Get.to(()=> SearchInvoiceView);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => SearchInvoiceView(
                          codeService: codeG,
                        ),
                      ),
                    );
                  } else if (_formKey.currentState!.validate() &&
                      widget.serviceCode == 1111) {
                    String value = controllerEdit.text;
                    form.add("clientId", value);
                    form.add("serviceCode", 1111);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            GetListFacturaGasView(
                          map: form.getMapFields,
                          code: 1111,
                        ),
                      ),
                    );
                  } else if (_formKey.currentState!.validate() &&
                      widget.serviceCode == 3333) {
                    String value = controllerEdit.text;
                    form.add("clientId", value);
                    form.add("serviceCode", 3333);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            GetListFacturaGasView(
                          map: form.getMapFields,
                          code: 3333,
                        ),
                      ),
                    );
                  }
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
                )))
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
            key: _formKey,
            child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(_regExp),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es requerido';
                  } else if (!_regExp.hasMatch(value)) {
                    return 'insuficiente cantidad de caracteres';
                  } else if (value.length >= 13) {
                    return 'El número debe tener mas de 11 caracteres';
                  }

                  return null;
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  value = controllerEdit.text;
                },
                controller: controllerEdit,
                decoration: InputDecoration(
                    errorBorder: InputBorder.none,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          controllerEdit.clear();
                        },
                        child: Icon(Icons.close)),
                    label: Text("Id Cliente"),
                    border: OutlineInputBorder())),
          )),
    );
  }
}
