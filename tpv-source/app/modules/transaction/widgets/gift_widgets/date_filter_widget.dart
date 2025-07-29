import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '/app/core/services/logger_service.dart';
import '/app/core/services/store_service.dart';

class DateFilterGift extends StatefulWidget {
  const DateFilterGift({Key? key});

  @override
  State<DateFilterGift> createState() => _DateFilterGiftState();
}

class _DateFilterGiftState extends State<DateFilterGift> {
  bool updated = false;
  var currentInitSelectedDate = DateTime.now();
  var currentOffSetSelectedDate = DateTime.now();
  DateFormat formatter = DateFormat().add_yMd();

  @override
  Widget build(BuildContext context) {
    DateFormat formatterDmy = DateFormat().add_yMd();
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* Container(
              
              width: MediaQuery.of(context).size.width*0.30,
              height: MediaQuery.of(context).size.height*0.070,
               child: Expanded(
                child: InputDatePickerFormField(
                  keyboardType: TextInputType.datetime,
                  firstDate: DateTime.now(),
                   lastDate: DateTime(2023)),
               ),
             ),
             Expanded(
              child: InputDatePickerFormField(
                keyboardType: TextInputType.datetime,
                firstDate: DateTime.now(),
                 lastDate: DateTime(2023)),
             ),*/
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            TextButton(
                onPressed: callDatePicker,
                child: Container(
                    padding: EdgeInsets.only(top: 7, left: 5),
                    // constraints: BoxConstraints(),
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.height * 0.050,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                    child: Text(
                      formatterDmy.format(currentInitSelectedDate),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.037,
                          color: Colors.white),
                    ) /*:
                 Text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                 textAlign: TextAlign.center,
                 style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width*0.037,
                  color: Colors.white
                 ),
                 ),*/
                    )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            TextButton(
                onPressed: callOffSetDatePicker,
                child: Container(
                    padding: EdgeInsets.only(top: 7, left: 5),
                    //constraints: BoxConstraints(),
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.height * 0.050,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                    child: Text(
                      formatterDmy.format(currentOffSetSelectedDate),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.037,
                          color: Colors.white),
                    ))),
          ],
        ),
      ],
    );
  }

  void callDatePicker() async {
    var initselectedDate = await getDateInitialPickerWidget();
    //FilterTransactionsParamsUseCase paramsa = Get.find();
    //String initselectedDateS = formatter.format(initselectedDate!);
    final typeFilterFormField = StoreService().getStore("filterGifts");
    typeFilterFormField.add("startDate",
        "${initselectedDate!.year}-${initselectedDate.month}-${initselectedDate.day}");
    log("fecha init seteada....${typeFilterFormField.getMapFields.values}");
    /*paramsa.startDate =
        "${initselectedDate.year}-${initselectedDate.month}-${initselectedDate.day}";*/
    //String dateParsed = '${initselectedDate.year}-${initselectedDate.month}-${initselectedDate.day}T${initselectedDate.hour}%3A${initselectedDate.minute}%3A${initselectedDate.second}-04%3A00}';
    //log("fecha inicial seteada....${paramsa.startDate}");
    setState(() {
      currentInitSelectedDate = initselectedDate;
    });
  }

  void callOffSetDatePicker() async {
    var offSetSelectedDate = await getDateOffSetPickerWidget();
    final typeFilterFormField = StoreService().getStore("filterGifts");
    typeFilterFormField.add("endDate",
        "${offSetSelectedDate!.year}-${offSetSelectedDate.month}-${offSetSelectedDate.day}");
    log(typeFilterFormField.getMapFields.values.toString());
    // FilterTransactionsParamsUseCase paramsa = Get.find();
    //String offSetSelectedDateO = formatter.format(offSetSelectedDate);
    //paramsa.endDate ="${offSetSelectedDate!.year}-${offSetSelectedDate.month}-${offSetSelectedDate.day}";
    log("fecha end seteada....${typeFilterFormField.getMapFields.values}");
    setState(() {
      currentOffSetSelectedDate = offSetSelectedDate;
    });
  }

  Future<DateTime?> getDateInitialPickerWidget() {
    //TODO buscar como perzonalizar el boton de cancelar en showDatePicker
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime(2200),
        builder: (context, child) {
          return Theme(data: ThemeData.light(), child: child!);
        });
  }

  Future<DateTime?> getDateOffSetPickerWidget() {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime(2200),
        builder: (context, child) {
          return Theme(data: ThemeData.light(), child: child!);
        });
  }

  Future<DateTimeRange?> getDateRangePickerWidget() {
    return showDateRangePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2022));
  }
}
