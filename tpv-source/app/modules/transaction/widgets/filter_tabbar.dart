import 'dart:developer';
import '/app/core/services/store_service.dart';
import '/app/modules/transaction/widgets/date_filter_widget.dart';

import '/app/modules/transaction/widgets/type_filter_widget.dart';
import 'status_filter_widget.dart';
import 'package:flutter/material.dart';

class FilterTabbar extends StatelessWidget {
  BuildContext? context;
  FilterTabbar({Key? key, this.context});

  @override
  Widget build(BuildContext context) {
    final form = StoreService().getStore("filterTransactions");
    log(form.getKey);
    log(form.getMapFields.entries.toString());
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: MediaQuery.of(context).size.height / 30,
            bottom: TabBar(
              padding: EdgeInsets.zero,
              tabs: [
                Tab(
                  text: "Estado",
                ),
                Tab(
                  text: "Fecha",
                ),
                Tab(text: "Categoria"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              StatusFilter(context: context),
              DateFilter(context: context),
              TypeFilterWidget(context: context)
            ],
          ),
        ));
  }
}
