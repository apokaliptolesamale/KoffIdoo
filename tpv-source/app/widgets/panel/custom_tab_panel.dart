// ignore_for_file: must_be_immutable
/*
import 'package:flutter/material.dart';

import '../../../app/core/interfaces/entity_model.dart';
//import '../../../../app/modules/operation/domain/models/user_model.dart';
import '../../widgets/layout/layout.dart';

class CustomCardListPanel extends StatefulWidget {
  List<EntityModel> listado;
  CustomCardListPanel({this.listado = const [], Key? key}) : super(key: key);

  @override
  State<CustomCardListPanel> createState() => _CustomCardListPanelState();
}

class CustomCardPanel extends StatelessWidget {
  final EntityModel? cardcase;

  const CustomCardPanel({required this.cardcase, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final UserModel c = cardcase as UserModel;
    return Container(
      child: Card(
          child: Row(
        children: [
          Column(
            children: [],
          ),
          Column(
            children: [
              //Text()
            ],
          ),
          Column(
            children: [],
          ),
          Column(
            children: [],
          ),
          Column(
            children: [],
          )
        ],
      )),
    );
  }
}

class CustomExpansionCard extends StatefulWidget {
  UserModel user;
  CustomExpansionCard({Key? key, required this.user}) : super(key: key);

  @override
  State<CustomExpansionCard> createState() => _CustomExpansionCardState();
}

class CustomTabPanel extends StatefulWidget {
  int currentIndex;
  Map<int, Layout> panels = {};

  CustomTabPanel({
    this.panels = const {},
    Key? key,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  State<CustomTabPanel> createState() => _CustomTabPanelState();
}

class _CustomCardListPanelState extends State<CustomCardListPanel> {
  List<EntityModel> listado = const [];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: listado.map((e) {
        final UserModel user = e as UserModel;
        return CustomExpansionCard(user: user);
      }).toList(),
    ));
  }

  @override
  initState() {
    super.initState();
    listado = [];
  }
}

class _CustomExpansionCardState extends State<CustomExpansionCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(10),
            color: Colors.green,
            child: ExpansionPanelList(
              animationDuration: Duration(milliseconds: 2000),
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text("clic to expand",
                          style: TextStyle(color: Colors.black)),
                    );
                  },
                  body: ListTile(
                    title: Text("descripcion",
                        style: TextStyle(color: Colors.black)),
                  ),
                  isExpanded: _expanded,
                  canTapOnHeader: true,
                )
              ],
              dividerColor: Colors.grey,
              expansionCallback: (panelIndex, isExpanded) {
                _expanded = !_expanded;
                setState(() {});
              },
            )),
      ],
    );
  }
}

class _CustomTabPanelState extends State<CustomTabPanel> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/
