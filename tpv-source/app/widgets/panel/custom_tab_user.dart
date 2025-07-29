// ignore_for_file: must_be_immutable
/*
import 'package:dartz/dartz.dart' as dart;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/modules/operation/domain/models/case_model.dart';
import '/app/modules/operation/domain/usecases/filter_histories_usecase.dart';
import '/app/modules/operation/widgets/layout_user_general_info.dart';
import '../../../app/modules/card/bindings/card_binding.dart';
import '../../../app/modules/card/controllers/card_controller.dart';
import '../../../app/modules/card/domain/models/card_model.dart';
import '../../../app/modules/operation/bindings/histories_binding.dart';
import '../../../app/modules/operation/bindings/transactions_binding.dart';
import '../../../app/modules/operation/controllers/histories_controller.dart';
import '../../../app/modules/operation/controllers/transactions_controller.dart';
import '../../../app/modules/operation/domain/models/history_model.dart';
import '../../../app/modules/operation/domain/models/transactions_model.dart';
import '../../../app/modules/operation/domain/models/user_model.dart';
import '../../../app/modules/operation/widgets/layout_exporting.dart';
import 'custom_tab_cards.dart';
import 'custom_tab_info_user.dart';
import 'custom_tab_transactions.dart';

class TabUser extends StatefulWidget {
  EntityModelList<TransactionsModel>? transacciones;
  EntityModelList<CardModel>? tarjetas;
  EntityModelList<HistoryModel>? inciden;
  EntityModelList<CaseModel>? cases;
  //EntityModelList<HistoryModel> historiales;
  UserModel user;
  HistoryModel? incidenn;

  TabUser({Key? key, required this.user, this.inciden}) : super(key: key);

  @override
  TabUserState createState() => TabUserState();
}

class TabUserState extends State<TabUser> with SingleTickerProviderStateMixin {
  int? selectedpage = 0;
  TabController? controller;
  bool selected = false;
  Color? color = Colors.blue;
  Color? color1 = Colors.blue;
  Color? color2 = Colors.blue;
  int? value = 1;
  EntityModelList<TransactionsModel>? transacciones;
  EntityModelList<CardModel>? tarjetas;
  EntityModelList<HistoryModel>? history;
  EntityModelList<CaseModel>? cases;

  @override
  Widget build(BuildContext context) => rebuild(context);

  AsyncWidgetBuilder<dynamic> getBuilder() {
    return (context, snapshot) {
      if (snapshot.hasData && snapshot.data is dart.Right) {
        final dart.Right data = snapshot.data as dart.Right;
        history = data.value; // log(data);
        final viewTransactions = transacciones! is! DefaultEntityModelList
            ? CustomTransaction(list: transacciones!)
            : Container();
        final viewHistory = TabHistorial(history: history!);
        final listHistoryModel = history!.getList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                  //border: Border(bottom: BorderSide(width: 1, color: Colors.greenAccent))
                  ),
              child: TabBar(
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.black,
                  controller: controller,
                  labelColor: Colors.black,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  labelStyle: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 15.4),
                  tabs: [
                    Container(
                        decoration: BoxDecoration(
                            color: controller!.index == 0
                                ? Colors.white
                                : Colors.blue,
                            border: Border.all(color: Colors.grey, width: 1.5)),
                        width: double.infinity,
                        child: Tab(
                          height: 30,
                          child: Container(child: Text("Información General")),
                        )),
                    Container(
                        decoration: BoxDecoration(
                            color: controller!.index == 1
                                ? Colors.white
                                : Colors.blue,
                            border: Border.all(color: Colors.grey, width: 1.5)),
                        width: double.infinity,
                        child: Tab(
                          height: 30,
                          child: Container(child: Text("Targetas")),
                        )),
                    Container(
                      decoration: BoxDecoration(
                          color: controller!.index == 2
                              ? Colors.white
                              : Colors.blue,
                          border: Border.all(color: Colors.grey, width: 1.5)),
                      width: double.infinity,
                      child: Tab(
                        height: 30,
                        child: Container(child: Text("Transacciones")),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: controller!.index == 3
                              ? Colors.white
                              : Colors.blue,
                          border: Border.all(color: Colors.grey, width: 1.5)),
                      width: double.infinity,
                      child: Tab(
                        height: 30,
                        child: Container(child: Text("Casos")),
                      ),
                    ),
                  ]),
            ),
            Container(
                margin: EdgeInsets.zero,
                width: 1500,
                height: 450,
                child: TabBarView(
                  controller: controller,
                  children: [
                    reloadInfoGeneral(),
                    CustomTabCard(
                      list: tarjetas!,
                    ),
                    viewTransactions,
                    viewHistory
                  ],
                ))
          ],
        );
      } else if (snapshot.hasData && snapshot.data is dart.Left) {
        final fail = FailureExtractor.message(snapshot.data as dart.Left);
        return Text(fail);
      }
      return Loading.fromText(text: "Cargando historial...");
    };
  }

  getHistory<T>() {
    final ctl = Get.find<HistoryController>();
    final params = FilterUseCaseHistoryParams();
    params.userName = widget.user.userName;
    return ctl.filterHistoriesUseCase.setParams(params).call(params);
  }

  @override
  void initState() {
    super.initState();
    transacciones = DefaultEntityModelList();
    tarjetas = DefaultEntityModelList();
    history = DefaultEntityModelList();
    cases = DefaultEntityModelList();
    TransactionBinding().dependencies();
    CardBinding().dependencies();
    HistoryBinding().dependencies();
    selected = false;
    controller = TabController(length: 4, vsync: this);
    controller!.addListener(updateView);
  }

  Widget rebuild(BuildContext context) => CustomFutureBuilder(
        future: getHistory(),
        builder: getBuilder(),
      );

  reloadCards() {
    final ctl = Get.find<CardController>();
    final response = ctl.getByFieldCard.getCardByUser(widget.user.userName);
    response.then((value) {
      value.fold((l) => null, (r) {
        tarjetas = r;
      });
    });
  }

  reloadHistory() {
    final ctl = Get.find<HistoryController>();
    final params = FilterUseCaseHistoryParams();
    params.userName = widget.user.userName;
    final response = ctl.filterHistoriesUseCase.setParams(params).call(params);
    response.then((value) {
      value.fold((l) => null, (r) {
        history = r;
      });
    });
  }

  Widget reloadInfoGeneral() {
    return TabHistorialUser(
      history: history!,
      user: widget.user,
    );
  }

  reloadTransactions() {
    final ctl = Get.find<TransactionsController>();
    final response = ctl.filterTransactionsUseCase
        .getByUserId(widget.user.identificationNumber);
    response.then((value) {
      value.fold((l) => null, (r) {
        transacciones = r as EntityModelList<TransactionsModel>;
      });
    });
  }

  updateView() {
    switch (controller!.index) {
      case 0:
        reloadInfoGeneral();
        break;
      case 1:
        reloadCards();
        break;
      case 2:
        reloadTransactions();
        break;
      case 3:
        reloadHistory();
        break;
      default:
    }
    setState(() {});
  }
}*/
