import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/services/store_service.dart';
import '../../controllers/gift_controller.dart';
import 'filter_tabbar.dart';

class FilterGiftWidget extends StatefulWidget {
  const FilterGiftWidget({Key? key}) : super(key: key);

  @override
  State<FilterGiftWidget> createState() => _FilterGiftWidgetState();
}

class _FilterGiftWidgetState extends State<FilterGiftWidget> {
  @override
  Widget build(BuildContext context) {
    //Size contextsize = MediaQuery.of(context).size;
    GiftController giftController = Get.find<GiftController>();
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.7,
      child: AlertDialog(
        contentPadding: EdgeInsets.only(left: 5, right: 5, top: 2),
        elevation: 10,
        //title: Text('Material Dialog'),
        // ignore: sized_box_for_whitespace
        content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: FilterTabbar()),
        actions: [
          TextButton(
            onPressed: () {
              final form = StoreService().getStore("filterGifts");
              form.getMapFields.remove("giftStatus");
              form.getMapFields.remove("startDate");
              form.getMapFields.remove("endDate");
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.height * 0.070,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.blue),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Volver',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                //log("OK");
                //log("${Routes.getInstance.getRouteMap.entries}");
                final form = StoreService().getStore("filterGifts");
                if (form.getMapFields.keys.toString().contains("giftStatus") &&
                    form.getMapFields.keys.toString().contains("startDate") &&
                    form.getMapFields.keys.first.toString() == "giftStatus") {
                  form.getMapFields.remove("giftStatus");
                } else if (form.getMapFields.keys
                        .toString()
                        .contains("giftStatus") &&
                    form.getMapFields.keys.toString().contains("startDate") &&
                    (form.getMapFields.keys.first.toString() == "startDate" ||
                        form.getMapFields.keys.first.toString() == "endDate")) {
                  form.getMapFields.remove("startDate");
                  form.getMapFields.remove("endDate");
                }
                giftController.update(['historial', 'loadListGift']);

                /* Get.to(() => GiftView(),
                    binding: GiftBinding(), arguments: 'filterGift'); */

                Navigator.pop(context);
                /* Get.to(
                    () => HistorialGiftView(),binding: GiftBinding()
                  );  */
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
              ))
        ],
      ),
    );
  }
}
