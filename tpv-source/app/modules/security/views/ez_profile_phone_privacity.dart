import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/security/domain/models/account_model.dart';
import '../../../widgets/utils/loading.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../controllers/account_controller.dart';

class EzPhonePrivacity extends StatefulWidget {
  @override
  State<EzPhonePrivacity> createState() => _EzPhonePrivacityState();
}

class _EzPhonePrivacityState extends State<EzPhonePrivacity> {
  var account = Get.find<AccountModel>();
  var publicPhone = "";
  late var todos;
  late var amigos;

  @override
  void initState() {
    publicPhone = account.publicPhone;

    if (publicPhone == "true") {
      todos = true;
      // amigos = false;
    } else {
      todos = false;
      // amigos = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    return AlertDialog(
        elevation: 15,
        backgroundColor: Colors.white,
        scrollable: true,
        title: Center(
          child: Text(
            "¿Quién puede ver mi teléfono?",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: size.getWidthByPercent(5),
              color: Colors.black,
            ),
            // textAlign: TextAlign.start,
            textAlign: TextAlign.center,
          ),
        ),
        content: Container(
            child: Column(
          children: [
            CheckboxListTile(
              title: Text(
                "Todos",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: size.getWidthByPercent(5),
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
              subtitle: Text(
                "(Su teléfono será público)",
              ),
              value: todos,
              onChanged: (value) async {
                setState(() {
                  todos = !todos;

                  // amigos = !amigos;
                });
                Navigator.pop(context);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Loading(
                        text: "Actualizando la privacidad de su teléfono...",
                        backgroundColor: Colors.lightBlue.shade700,
                        animationColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightBlue.withOpacity(0.8)),
                        containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                      );
                    });
                await updateEmailPrivacity(todos);
                Get.back();
              },
            ),
            CheckboxListTile(
              title: Text(
                "Privado",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: size.getWidthByPercent(5),
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
              subtitle: Text("(Su teléfono será visto solo por sus amigos)"),
              value: !todos,
              onChanged: (value) async {
                setState(() {
                  // amigos = !amigos;
                  todos = !todos;
                });
                Navigator.pop(context);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Loading(
                        text: "Actualizando la privacidad de su teléfono...",
                        backgroundColor: Colors.lightBlue.shade700,
                        animationColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightBlue.withOpacity(0.8)),
                        containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                      );
                    });
                await updateEmailPrivacity(todos);
                Get.back();
                // controller.update(["InfoView"]);
              },
            ),
          ],
        )));
  }

  updateEmailPrivacity(bool tmp) async {
    AccountController accountController = Get.find<AccountController>();
    Map<String, dynamic> params = {};
    log("ESTE ES TMP A STRING>>>>>>>>>${tmp.toString()}");
    params = {"public_phone": tmp.toString()};
    log("ESTE ES PARAMS >>>>>>>>>$params");
    accountController.updateAccount.setParamsFromMap(params);
    await accountController.getFutureByUseCase(accountController.updateAccount);
  }
}
