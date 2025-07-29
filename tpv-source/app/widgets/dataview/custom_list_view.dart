// ignore_for_file: must_be_immutable, unused_field

import 'package:flutter/material.dart';

import '../../../app/core/services/logger_service.dart';
import '../../../app/widgets/botton/short_cut_botton.dart';

class CustomListView extends StatefulWidget {
  late double _width;
  late double _height;
  late double _columnWidth;
  late double _spaceBetween;
  late int _numColumns;
  late Color _backGroundColor;
  late double _horizontalMargin;
  late double _verticalMargin;

  late List<ShortCut> _widgets;

  CustomListView({
    List<ShortCut> widgets = const [],
    double width = 150,
    double height = 200,
    double horizontalMargin = 10,
    double verticalMargin = 30,
    int numColumns = 1,
    double columnWidth = 150,
    double spaceBetween = 20,
    Color backGroundColor = Colors.transparent,
    Key? key,
  }) : super(key: key) {
    _columnWidth = columnWidth;
    _width = width;
    _height = height;
    _numColumns = numColumns;
    _columnWidth = columnWidth;
    _spaceBetween = spaceBetween;
    _backGroundColor = backGroundColor;
    _horizontalMargin = horizontalMargin;
    _verticalMargin = verticalMargin;
    _widgets = widgets;
  }

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  late double _width;
  late double _height;
  late double _columnWidth;
  late double _spaceBetween;
  late int _numColumns;
  late Color _backGroundColor;
  late double _horizontalMargin;
  late double _verticalMargin;
  late List<ShortCut> _widgets;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final widthContainer = _columnWidth + _spaceBetween;
    final horizontalSize = _horizontalMargin * 2;

    int cantColumn = (size.width / (widthContainer + horizontalSize)).round();
    int cantRows = (_widgets.length / cantColumn).round() + 3;
    log("Widgets=${_widgets.length} Filas=$cantRows and Columns=$cantColumn");
    final List<Widget> columns = _buildMatrix(cantColumn);

    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
              top: _verticalMargin,
              left: _horizontalMargin,
              right: _horizontalMargin),
          color: Colors.amber,
          width: double.infinity,
          child: Row(
            children: columns,
          ),
        );
      },
      itemCount: cantRows,
    );

    /*return Container(
      color: Colors.amber,
      width: double.infinity,
      child: Row(
        children: columns,
      ),
    );*/
  }

  @override
  void initState() {
    _width = widget._width;
    _height = widget._height;
    _columnWidth = widget._columnWidth;
    _spaceBetween = widget._spaceBetween;
    _numColumns = widget._numColumns;
    _backGroundColor = widget._backGroundColor;
    _horizontalMargin = widget._horizontalMargin;
    _verticalMargin = widget._verticalMargin;
    _widgets = widget._widgets;
    super.initState();
  }

  List<Widget> _buildMatrix(int cant) {
    List<Widget> columns = [];
    /*List<Widget> rows = [];
    for (var j = 0; j < _widgets.length; j++){

      
     }*/
    for (var i = 0; i < cant; i++) {
      columns.add(Container(
        height: _columnWidth,
        color: Colors.red,
        margin: EdgeInsets.symmetric(horizontal: _spaceBetween),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ShortCut(
              text: "SchorCut #$i",
              icon: Icon(Icons.abc),
              margin: EdgeInsets.symmetric(vertical: _verticalMargin),
              width: _columnWidth,
              height: _columnWidth,
              color: Colors.blue,
            )
          ],
        ),
      ));
    }

    return columns;
  }
}
