import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '/app/core/config/assets.dart';
import '/app/core/helpers/functions.dart';
import '/app/core/helpers/idp.dart';
import '/app/core/helpers/store_short_cuts.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/services/logger_service.dart';
import '/app/modules/order/domain/models/order_model.dart';
import '/app/modules/security/domain/models/profile_model.dart';
import '/app/modules/warranty/controllers/warranty_controller.dart';
import '/app/modules/warranty/domain/models/warranty_model.dart';
import '/app/modules/warranty/views/pages/warranty_info_page.dart';
import '/app/widgets/bar/custom_app_bar.dart';
import '/app/widgets/botton/custom_base_botton.dart';
import '/app/widgets/botton/custom_bottom_nav_bar.dart';
import '/app/widgets/event/custom_drag_target.dart';
import '/app/widgets/ext/user_profile_avatar.dart';
import '/app/widgets/field/search_text.dart';
import '/app/widgets/images/background_image.dart';
import '/app/widgets/panel/custom_item_counter.dart';
import '/app/widgets/utils/size_constraints.dart';
import '/app/widgets/view/scrollable_list_view.dart';
import '../../../routes/app_routes.dart';

class WarrantyInfoView extends StatefulWidget {
  final EntityModelList<WarrantyModel> warrantyList;

  const WarrantyInfoView({
    Key? key,
    required this.warrantyList,
  }) : super(key: key);

  @override
  _WarrantyInfoViewState createState() => _WarrantyInfoViewState();
}

class _WarrantyInfoViewState extends State<WarrantyInfoView> {
  bool activateSearch = false;
  SearchText? searchInput;

  // At the beginning, we fetch the first 20 posts
  int _page = 0;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the warranties fetched from the server
  List<WarrantyModel> _found = [];
  List<WarrantyModel> _selected = [];

  Color onEnterDropZoneColor = Colors.transparent;

  CustomItemCounter? counter;

  // The controller for the ListView
  late ScrollController _controller;

  ProfileModel? profile;

  late EntityModelList<WarrantyModel> warrantyList;

  @override
  Widget build(BuildContext context) {
    // final constraint = SizeConstraints(context: context);
    return Stack(
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
            title: Text('Garantías'),
            keyStore: "garantia",
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
                      activateSearch = !activateSearch;
                    });
                  },
                ),
              ),
              UserProfileAvatar()
            ],
            backgroundColor: Color(0xFF00b1a4),
          ),
          body: /*createScrollableListView(constraint,
              context)*/
              _isFirstLoadRunning
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: CustomDragTarget<WarrantyModel>(
                              child: Container(
                                margin: EdgeInsets.only(top: 20, bottom: 10),
                                child: Center(
                                  child: counter!,
                                ),
                                decoration: BoxDecoration(
                                  color: onEnterDropZoneColor,
                                  border: Border.all(
                                      color: Color(0xFFd7d7d7), width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onEnter: <CustomBaseBotton>(_, event, btn) {
                                setState(() {
                                  onEnterDropZoneColor = Colors.black12;
                                });
                              },
                              onExit: <CustomBaseBotton>(_, event, btn) {
                                setState(() {
                                  onEnterDropZoneColor = Colors.transparent;
                                });
                              },
                              onWillAccept: (data) {
                                return data is OrderModel;
                              },
                              onAccept: (data) {
                                _itemDroppedOn(warranty: data);
                              },
                              onLeave: (data) {
                                setState(() {
                                  onEnterDropZoneColor = Colors.transparent;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: createScrollableListView(context),
                          ),
                        ],
                      ),
                    )),
        )
      ],
    );
  }

  ScrollableListView<WarrantyModel> createScrollableListView(
      BuildContext context) {
    SizeConstraints constraint = SizeConstraints(context: context);
    return ScrollableListView<WarrantyModel>(
      builder: (context, index, items, item, controller) {
        if (_found.isEmpty && items.isNotEmpty) _found = items;
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
                        Text(
                          warranty.code.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            warranty.time != null
                                ? DateFormat('yyyy-MM-dd - kk:mm')
                                    .format(warranty.time!)
                                : "Sin fecha",
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.roboto(
                              fontSize: constraint.getWidthByPercent(2),
                              color: Colors.black.withOpacity(0.8),
                            ),
                            //textScaleFactor: 1,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(
                              Routes.getInstance
                                  .getPath("WARRANTY_QR_WARRANTY_INFO"),
                              parameters: {
                                "warrantyId": warranty.warrantyId ?? "",
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
      onRefresh: (view, page, limit) async {
        final ctl = Get.find<WarrantyController>();
        String? ci = Get.parameters.containsKey("ci")
            ? Get.parameters["ci"]!.toString()
            : null;
        final result = await ctl.filterUseWarranty.setParamsFromMap({
          "ci": ci,
          "page": page,
          "count": limit,
        }).call(null);
        return result.fold((l) => [], (list) {
          List<WarrantyModel> tmp = [];
          list.getList().forEach((e1) {
            bool esta = false;
            warrantyList.getList().forEach((e2) {
              esta = e1.code == e2.code;
            });
            if (!esta) tmp.add(e1);
          });
          setState(() {
            warrantyList = WarrantyList(
              warrantys: tmp,
            );
          });
          return list.getList();
        });
      },
      searcherController: TextEditingController(),
      controller: _controller,
      groupBy: (warranty) {
        return warranty.clientName ?? "";
      },
      groupComparator: (value1, value2) {
        return value2.compareTo(value1);
      },
      includeSearcher: true,
      isGroup: true,
      isInfinity: true,
      itemComparator: (item1, item2) {
        return item1.toString().compareTo(item2.toString());
      },
      items: warrantyList.getList(),
      searcher: (warranty, enteredKeyword) {
        test(WarrantyModel warranty) {
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
        }

        return filter(enteredKeyword, test: test);
      },
      limit: 15,
      page: 0,
      itemTransformCallBack: (view, model) {
        final clone = WarrantyModel.fromJson(model.toJson());
        clone.code = "Código:${clone.code}";
        return clone;
      },
      stickyTransformToWidget: (view, index) {
        //final item = view.getItems.elementAt(index);
        return ListTile(
          key: ValueKey(index),
          title:
              Text('Item $index', style: const TextStyle(color: Colors.white)),
          tileColor: index % 2 == 0 ? Colors.pinkAccent : Colors.purple,
        );
        //return Text("Garantía ${item.createdAt.toLocal().toIso8601String()}");
      },
      /*stickyConf: StickyConfig(
        context: context,
        sticky: Text("Sticky"),
        primaryColor: Colors.lightBlue,
        secundaryColor: Colors.white,
      ),*/
      onReorder: (view, oldIndex, newIndex) {},
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

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
      results = warrantyList.getList();
    } else {
      final list = warrantyList.getList();
      results = list.where((warranty) => test!(warranty)).toList();
    }
    setState(() {
      _found = results;
      _selected = _found;
    });
    return true;
  }

  @override
  initState() {
    super.initState();
    warrantyList = widget.warrantyList; //DefaultEntityModelList();
    profile = getAuthenticatedUserProfile();
    //_firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
    activateSearch = false;
    _found = warrantyList.getList();
    _selected = [];
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

    counter = CustomItemCounter(
      value: _selected.isEmpty ? "" : _selected.length.toString(),
      padding: EdgeInsets.only(left: 6, top: 9),
      margin: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
    );
  }

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      gParams.addAll({
        "ci": profile?.identification ?? "",
        "page": _page.toString(),
        "count": _limit.toString(),
      }, replace: true);
      //Get.parameters.addAll();

      final uc = WarrantyInfoPage().usecase;
      final res = await WarrantyInfoPage().getFutureByUseCase(uc);

      setState(() {
        if (res is dartz.Right) {
          warrantyList = res.value;
        }
      });
    } catch (err) {
      if (kDebugMode) {
        log('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _itemDroppedOn({
    required WarrantyModel warranty,
  }) {
    setState(() {
      _found
          .removeWhere((element) => warranty.warrantyId == element.warrantyId);
      _selected.add(warranty);
      counter!.setValue(_selected.length.toString());
      counter!.start();
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        gParams.addAll({
          "ci": profile?.identification ?? "",
          "page": _page.toString(),
          "count": _limit.toString(),
        }, replace: true);
        final uc = WarrantyInfoPage().usecase;
        final fetchedPosts = await WarrantyInfoPage().getFutureByUseCase(uc);

        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _found.addAll(fetchedPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {}
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
}
