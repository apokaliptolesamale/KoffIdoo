import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_routes.dart';
import '/app/core/config/assets.dart';
import '/app/core/helpers/store_short_cuts.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/modules/warranty/domain/models/warranty_model.dart';
import '/app/widgets/bar/custom_app_bar.dart';
import '/app/widgets/botton/custom_base_botton.dart';
import '/app/widgets/botton/custom_bottom_nav_bar.dart';
import '/app/widgets/ext/user_profile_avatar.dart';
import '/app/widgets/field/search_text.dart';
import '/app/widgets/images/background_image.dart';

class WarrantyListView extends StatefulWidget {
  final EntityModelList<WarrantyModel> items;
  WarrantyListView({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<WarrantyListView> createState() => _WarrantyListViewState();
}

class _WarrantyListViewState extends State<WarrantyListView> {
  List<WarrantyModel> items = [];
  List<WarrantyModel> _found = [];
  List<WarrantyModel> selected = [];

  bool activateSearch = false;
  SearchText? searchInput;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          BackGroundImage(
            backgroundImage: ASSETS_IMAGES_BACKGROUNDS_WARRANTY_DEFAULT_JPG,
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            bottomNavigationBar: CustomBotoonNavBar.fromRoute(
              Get.currentRoute,
              listOfPages: getListOfPages,
            ),
            appBar: CustomAppBar(
              leading: Icon(Icons.menu),
              keyStore: "garantia",
              title: Text('Garantías'),
              actions: [
                if (activateSearch) searchInput!,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CustomBaseBotton(
                    icon: Icon(Icons.search),
                    onHover: <CustomBaseBotton>(_, event, btn) {
                      /*setState(() {
                      activateSearch = true;
                    });*/
                    },
                    onExit: <CustomBaseBotton>(_, event, btn) {
                      /*setState(() {
                      activateSearch = false;
                    });*/
                    },
                    onTap: <CustomBaseBotton>(_, btn) {
                      setState(() {
                        //activateSearch = !activateSearch;
                      });
                    },
                  ),
                ),
                UserProfileAvatar()
              ],
              backgroundColor: Color(0xFF00b1a4),
            ),
            body: RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  /*SizeConstraints constraint =
                      SizeConstraints(context: context);
                  final item = items[index];*/
                  final WarrantyModel warranty = items.elementAt(index);
                  final daysLeft = warranty.getWarranttyInDays();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    key: ValueKey(index),
                    child: Draggable<WarrantyModel>(
                      childWhenDragging: Container(),
                      data: warranty,
                      feedback: Container(
                        height: 120.0,
                        width: 120.0,
                        child: Center(
                          child: Stack(
                            children: [
                              Image.asset(
                                ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_CERT_PNG,
                                color: Colors.teal,
                              ),
                              Positioned(
                                child: Text(
                                  "$daysLeft",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                left: 55,
                                top: 45,
                              )
                            ],
                          ),
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFf4f4f4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: Container(
                          color: Color(0xFFf4f4f4),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        ASSETS_IMAGES_ICONS_APP_WARRANTY_WARRANTY_CERT_PNG,
                                        color: Colors.teal,
                                      ),
                                      Positioned(
                                        child: Text(
                                          "$daysLeft",
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        left: 20,
                                        top: 13,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                      child: Text.rich(
                                    TextSpan(
                                        text: "Código de la garantía : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text:
                                                "${warranty.code.toString()}\n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                          TextSpan(
                                            text: "Vigente hasta: ",
                                          ),
                                          TextSpan(
                                            text: warranty.time != null
                                                ? DateFormat(
                                                        'yyyy-MM-dd - kk:mm')
                                                    .format(warranty.time!)
                                                : "Sin fecha",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          )
                                        ]),
                                  )),
                                ],
                              ),
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    Get.toNamed(
                                        Routes.getInstance.getPath(
                                            "WARRANTY_QR_WARRANTY_INFO"),
                                        parameters: {
                                          "warrantyId":
                                              warranty.warrantyId ?? "",
                                        });
                                  },
                                  icon: Icon(Icons.qr_code),
                                  color: const Color(0xFF00b1a4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      );

  bool filter(
    String enteredKeyword, {
    bool Function(WarrantyModel)? test,
  }) {
    test = test ??
        (WarrantyModel warranty) {
          return warranty.article!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.ci!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.status!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.clientName!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.code!
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.firstSerialNumber!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.secondSerialNumber!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.model!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.paymentType!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.phoneNumber!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.province!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.status!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              warranty.tradeName!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase());
        };
    List<WarrantyModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = items;
    } else {
      final list = items;
      results = list.where((warranty) => test!(warranty)).toList();
    }
    setState(() {
      _found = results;
      selected = _found;
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    items = widget.items.getList();
    searchInput = SearchText(
      onChanged: (context, textField, text) {
        filter(text);
      },
      width: 300,
      margin: EdgeInsets.only(left: 5, right: 1, top: 10, bottom: 10),
      containerDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
          width: 1.0,
        )),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.greenAccent,
            width: 1.0,
          ),
        ),
        hintText: "Buscar garantías...",
        //prefixIcon: icon,
        labelStyle: TextStyle(color: Colors.white70),
        hintStyle: TextStyle(color: Colors.white70),
      ),
    );
  }

  Future<void> refresh() {
    setState(() {
      items = items;
    });
    return Future.value(true);
  }
}
