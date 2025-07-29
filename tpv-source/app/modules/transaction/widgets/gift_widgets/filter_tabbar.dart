import 'dart:developer';
import '/app/core/services/store_service.dart';

import 'date_filter_widget.dart';
import 'status_filter_gift_widget.dart';

import 'package:flutter/material.dart';

class FilterTabbar extends StatelessWidget {
  const FilterTabbar({Key? key});

  @override
  Widget build(BuildContext context) {
    final form = StoreService().getStore("filterGifts");
    log(form.getKey);
    log(form.getMapFields.entries.toString());
    return DefaultTabController(
        length: 2,
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
              ],
            ),
          ),
          body: TabBarView(
            children: [StatusGiftFilter(), DateFilterGift()],
          ),
        ));
  }
}
