// ignore_for_file: overridden_fields, must_be_immutable, unused_element
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

import '/app/widgets/patterns/publisher_subscriber.dart';
import '../../../app/core/interfaces/data_table_source.dart';
import '../../../app/widgets/utils/encapsulate.dart';
import '../../core/interfaces/entity_model.dart';
import '../layout/layout.dart';

typedef FunctionGetCells = Encapsulate<int, EntityModel, List<DataCell>>
    Function(CustomDataTableSource source, int index);

typedef FunctionGetRows = DataRow Function(
    CustomDataTableSource source, int index);

/// A material design data table that shows data using multiple pages.
///
/// A paginated data table shows [rowsPerPage] rows of data per page and
/// provides controls for showing other pages.
///
/// Data is read lazily from a [DataTableSource]. The widget is presented
/// as a [Card].
///
/// See also:
///
///  * [DataTable], which is not paginated.
///  * <https://material.io/go/design-data-tables#data-tables-tables-within-cards>
class CustomDataTable extends Layout<CustomDataTable> {
  /// The default value for [rowsPerPage].
  ///
  /// Useful when initializing the field that will hold the current
  /// [rowsPerPage], when implemented [onRowsPerPageChanged].
  static const int defaultRowsPerPage = 10;

  /// The table card's optional header.
  ///
  /// This is typically a [Text] widget, but can also be a [Row] of
  /// [TextButton]s. To show icon buttons at the top end side of the table with
  /// a header, set the [actions] property.
  ///
  /// If items in the table are selectable, then, when the selection is not
  /// empty, the header is replaced by a count of the selected items. The
  /// [actions] are still visible when items are selected.
  @override
  final Widget? header;

  /// Icon buttons to show at the top end side of the table. The [header] must
  /// not be null to show the actions.
  ///
  /// Typically, the exact actions included in this list will vary based on
  /// whether any rows are selected or not.
  ///
  /// These should be size 24.0 with default padding (8.0).
  final List<Widget>? actions;

  /// The configuration and labels for the columns in the table.
  List<DataColumn>? columns;

  /// The current primary sort key's column.
  ///
  /// See [DataTable.sortColumnIndex].
  final int? sortColumnIndex;

  /// Whether the column mentioned in [sortColumnIndex], if any, is sorted
  /// in ascending order.
  ///
  /// See [DataTable.sortAscending].
  final bool sortAscending;

  /// Invoked when the user selects or unselects every row, using the
  /// checkbox in the heading row.
  ///
  /// See [DataTable.onSelectAll].
  final ValueSetter<bool?>? onSelectAll;

  /// The height of each row (excluding the row that contains column headings).
  ///
  /// This value is optional and defaults to kMinInteractiveDimension if not
  /// specified.
  final double dataRowHeight;

  /// The height of the heading row.
  ///
  /// This value is optional and defaults to 56.0 if not specified.
  final double headingRowHeight;

  /// The horizontal margin between the edges of the table and the content
  /// in the first and last cells of each row.
  ///
  /// When a checkbox is displayed, it is also the margin between the checkbox
  /// the content in the first data column.
  ///
  /// This value defaults to 24.0 to adhere to the Material Design specifications.
  ///
  /// If [checkboxHorizontalMargin] is null, then [horizontalMargin] is also the
  /// margin between the edge of the table and the checkbox, as well as the
  /// margin between the checkbox and the content in the first data column.
  final double horizontalMargin;

  /// The horizontal margin between the contents of each data column.
  ///
  /// This value defaults to 56.0 to adhere to the Material Design specifications.
  final double columnSpacing;

  /// {@macro flutter.material.dataTable.showCheckboxColumn}
  final bool showCheckboxColumn;

  /// Flag to display the pagination buttons to go to the first and last pages.
  final bool showFirstLastButtons;

  /// The index of the first row to display when the widget is first created.
  final int? initialFirstRowIndex;

  /// Invoked when the user switches to another page.
  ///
  /// The value is the index of the first row on the currently displayed page.
  final ValueChanged<int>? onPageChanged;

  /// The number of rows to show on each page.
  ///
  /// See also:
  ///
  ///  * [onRowsPerPageChanged]
  ///  * [defaultRowsPerPage]
  final int rowsPerPage;

  /// The options to offer for the rowsPerPage.
  ///
  /// The current [rowsPerPage] must be a value in this list.
  ///
  /// The values in this list should be sorted in ascending order.
  final List<int> availableRowsPerPage;

  /// Invoked when the user selects a different number of rows per page.
  ///
  /// If this is null, then the value given by [rowsPerPage] will be used
  /// and no affordance will be provided to change the value.
  final ValueChanged<int?>? onRowsPerPageChanged;

  /// The data source which provides data to show in each row. Must be non-null.
  ///
  /// This object should generally have a lifetime longer than the
  /// [CustomDataTable] widget itself; it should be reused each time the
  /// [CustomDataTable] constructor is called.
  IDataTableSource? source;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// Horizontal margin around the checkbox, if it is displayed.
  ///
  /// If null, then [horizontalMargin] is used as the margin between the edge
  /// of the table and the checkbox, as well as the margin between the checkbox
  /// and the content in the first data column. This value defaults to 24.0.
  final double? checkboxHorizontalMargin;

  /// Defines the color of the arrow heads in the footer.
  final Color? arrowHeadColor;

  //List<EntityModel> listModel = [];

  Color? backGroundColor;

  Decoration? tableDecoration;

  bool showBottomBorder = true;

  CustomDataTableState? state;

  bool selectAllOnStart = false;

  Widget Function(BuildContext context, BoxConstraints constraints,
      CustomDataTable scope)? builder;

  Widget Function(BuildContext context, CustomDataTable scope)? buildFunction;

  EdgeInsetsGeometry? margin;

  final GlobalKey _tableKey = GlobalKey();

  DataTable? dataTable;

  List<DataRow>? dataRows;

  int page = 0;

  EntityModelList<EntityModel> models;

  /// Creates a widget describing a paginated [DataTable] on a [Card].
  ///
  /// The [header] should give the card's header, typically a [Text] widget.
  ///
  /// The [columns] argument must be a list of as many [DataColumn] objects as
  /// the table is to have columns, ignoring the leading checkbox column if any.
  /// The [columns] argument must have a length greater than zero and cannot be
  /// null.
  ///
  /// If the table is sorted, the column that provides the current primary key
  /// should be specified by index in [sortColumnIndex], 0 meaning the first
  /// column in [columns], 1 being the next one, and so forth.
  ///
  /// The actual sort order can be specified using [sortAscending]; if the sort
  /// order is ascending, this should be true (the default), otherwise it should
  /// be false.
  ///
  /// The [source] must not be null. The [source] should be a long-lived
  /// [DataTableSource]. The same source should be provided each time a
  /// particular [CustomDataTable] widget is created; avoid creating a new
  /// [DataTableSource] with each new instance of the [CustomDataTable]
  /// widget unless the data table really is to now show entirely different
  /// data from a new source.
  ///
  /// The [rowsPerPage] and [availableRowsPerPage] must not be null (they
  /// both have defaults, though, so don't have to be specified).
  ///
  /// Themed by [DataTableTheme]. [DataTableThemeData.decoration] is ignored.
  /// To modify the border or background color of the [CustomDataTable], use
  /// [CardTheme], since a [Card] wraps the inner [DataTable].
  CustomDataTable({
    Key? key,
    this.header,
    this.actions,
    this.columns,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSelectAll,
    this.dataRowHeight = kMinInteractiveDimension,
    this.headingRowHeight = 56.0,
    this.horizontalMargin = 24.0,
    this.columnSpacing = 10.0,
    this.showCheckboxColumn = true,
    this.showFirstLastButtons = true,
    this.initialFirstRowIndex = 0,
    this.onPageChanged,
    this.rowsPerPage = defaultRowsPerPage,
    this.availableRowsPerPage = const <int>[
      defaultRowsPerPage,
      defaultRowsPerPage * 2,
      defaultRowsPerPage * 5,
      defaultRowsPerPage * 10,
      defaultRowsPerPage * 20,
      defaultRowsPerPage * 40,
      defaultRowsPerPage * 50
    ],
    this.onRowsPerPageChanged,
    this.dragStartBehavior = DragStartBehavior.start,
    this.arrowHeadColor,
    this.checkboxHorizontalMargin,
    this.backGroundColor,
    this.showBottomBorder = true,
    this.tableDecoration,
    this.selectAllOnStart = false,
    this.buildFunction,
    this.builder,
    this.margin =
        const EdgeInsets.only(top: 0, left: 0.0, bottom: 1.0, right: 1.0),
    this.dataTable,
    this.source,
    this.dataRows,
    required this.models,
    //this.listModel = const [],
  }) : super(key: key) {
    /* assert(actions == null || (header != null));
    assert(columns!.isNotEmpty);
    assert(sortColumnIndex == null ||
        (sortColumnIndex! >= 0 && sortColumnIndex! < columns!.length));
    assert(rowsPerPage > 0);
    assert(() {
      if (onRowsPerPageChanged != null) {
        assert(availableRowsPerPage.contains(rowsPerPage));
      }
      return true;
    }());*/
    autoObservation();
    //listModel = models.getList();
    source = source ??
        buildSource(
            root: "data",
            data: models.getList().isNotEmpty ? models.getList() : [],
            selectAllOnStart: selectAllOnStart,
            dataTable: this);
    final EntityModel? model =
        models.getList().isNotEmpty ? models.getList().elementAt(0) : null;
    columns = columns ??
        (models.getList().isNotEmpty ? buildColumnsFromModel(model!) : []);
    state = state ?? CustomDataTableState();
  }

  factory CustomDataTable.buildFrom(
      {EntityModelList<EntityModel> models =
          const DefaultEntityModelList<EntityModel>(),
      List<Widget> actions = const [],
      double dataRowHeight = 38.0,
      bool showCheckboxColumn = true,
      void Function(bool?)? onSelectAll,
      Widget Function(BuildContext context, BoxConstraints constraints,
              CustomDataTable scope)?
          builder,
      Widget Function(BuildContext context, CustomDataTable scope)?
          buildFunction,
      EdgeInsetsGeometry? margin,
      IDataTableSource? source,
      DataTable? dataTable,
      List<DataRow>? dataRows,
      List<DataColumn>? columns,
      double? horizontalMargin,
      double? headingRowHeight,
      ValueChanged<int>? onPageChanged,
      ValueChanged<int?>? onRowsPerPageChanged}) {
    List<Widget> actions = <Widget>[];

    final grid = CustomDataTable(
      models: models,
      actions: actions,
      horizontalMargin: horizontalMargin ?? 24,
      headingRowHeight: headingRowHeight ?? 56,
      dataRowHeight: dataRowHeight,
      showCheckboxColumn: showCheckboxColumn,
      onSelectAll: onSelectAll,
      onPageChanged: onPageChanged,
      onRowsPerPageChanged: onRowsPerPageChanged,
      buildFunction: buildFunction,
      builder: builder,
      margin: margin,
      source: source,
      dataTable: dataTable,
      dataRows: dataRows,
      columns: columns,
    );
    return grid;
  }

  @override
  CustomDataTableState get getState => state ?? createState();

  @override
  Map<String, List<void Function(Publisher<Subscriber<CustomDataTable>> event)>>
      get getSubscriptionsFunction => subscriptionsFunction;

  @override
  CustomDataTableState createState() => state = CustomDataTableState();

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    models.getList().forEach((element) {
      element.updateColumnMetaModel("visible", true, false);
      //log(element);
    });
    /*getState.update(() {
      models.getList().forEach((element) {
        log(element);
      });
    });*/
    //fireEvent("onWindowResize", {"queryData": queryData, "Size": _lastSize});
  }

  CustomDataTable setModels(EntityModelList<EntityModel> listModel) {
    if (state != null) {
      state!.setModels(listModel);
    }
    return this;
  }

  @override
  CustomDataTable update(Function() func) {
    if (getState.mounted) {
      getState.update(func);
    }
    return this;
  }

  static List<DataColumn> buildColumnsFromModel(EntityModel model) {
    List<DataColumn> list = [];
    model.getVisibleColumnNames().forEach((key, value) {
      list.add(DataColumn(label: Text(value)));
    });
    return list;
  }

  static CustomDataTableSource buildSource(
      {String root = "root",
      List<EntityModel> data = const [],
      bool selectAllOnStart = false,
      CustomDataTable? dataTable}) {
    return CustomDataTableSource(
      dataSource: {root: data},
      dataTable: dataTable,
      selectAllOnStart: selectAllOnStart,
      root: root,
    );
  }
}

class CustomDataTableSource extends IDataTableSource {
  final bool isRowCountApproximated;
  int count;
  int selectedRows;
  late CustomDataTable? dataTable;
  final Map<String, dynamic> dataSource;
  final String root;
  final Map<int, bool> mapSelections = {};
  bool isAllSelected;
  final bool selectAllOnStart;
  FunctionGetCells? funcGetCells;
  FunctionGetRows? funcGetRows;

  CustomDataTableSource(
      {required this.dataSource,
      this.dataTable,
      this.root = "data",
      this.isRowCountApproximated = false,
      this.count = 10,
      this.selectedRows = 0,
      this.isAllSelected = false,
      this.selectAllOnStart = false,
      this.funcGetCells,
      this.funcGetRows})
      : super() {
    List<EntityModel> data = dataSource[root];
    count = data.length;
  }

  @override
  bool get isRowCountApproximate => isRowCountApproximated;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => selectedRows;

  Encapsulate<int, EntityModel, List<DataCell>> getCells(int index) {
    if (funcGetCells != null) return funcGetCells!(this, index);

    mapSelections[index] = selectAllOnStart;
    if (dataSource.isEmpty || !dataSource.containsKey(root)) {
      return Encapsulate<int, EntityModel, List<DataCell>>(data: {});
    }

    List<EntityModel> data = dataSource[root];
    EntityModel row = data.elementAt(index);
    Map<String, dynamic> obj = row.toJson();
    List<DataCell> cells = row.getVisibleColumnNames().keys.map((key) {
      final value =
          obj.isNotEmpty && obj.containsKey(key) ? obj[key] ?? "-" : "-";
      final render = row.getColumnMetaModel()[key]!.getRender();
      final container = render(key, value.toString());
      return DataCell(container is Widget
          ? container
          : Container(
              child: FittedBox(child: Text(value.toString())),
            ));
    }).toList();
    return Encapsulate<int, EntityModel, List<DataCell>>(data: {
      index: {row: cells}
    });
  }

  @override
  DataRow getRow(int index) {
    if (funcGetRows != null) funcGetRows!(this, index);

    Encapsulate<int, EntityModel, List<DataCell>> capsule = getCells(index);
    List<DataCell> cells = capsule.getRigth(index) ?? [];
    //EntityModel? model = capsule.getLeft(index);
    DataRow row = DataRow.byIndex(
      selected: isSelected(index),
      index: index,
      cells: cells,
      onSelectChanged: (bool? isSelected) {
        bool value = isSelected ?? isSelected!;
        bool has = hasIndexSelection(index);
        mapSelections[index] = has ? !mapSelections[index]! : !value;
        int selected = 0;
        mapSelections.forEach((key, value) {
          if (value) selected++;
        });
        selectedRows = selected;
        /*if (dataTable != null) {
          dataTable!.update();
        }*/
      },
    );
    return row;
  }

  bool hasIndexSelection(int index) {
    return mapSelections.isNotEmpty && mapSelections.containsKey(index);
  }

  bool isSelected(int index) {
    return mapSelections.isNotEmpty && mapSelections[index] == true;
  }

  @override
  void selectAll(bool isAllSelected) {
    this.isAllSelected =
        this.isAllSelected == isAllSelected ? !isAllSelected : isAllSelected;
    mapSelections.forEach((key, value) {
      mapSelections[key] = this.isAllSelected;
    });
  }
}

/// Holds the state of a [CustomDataTable].
///
/// The table can be programmatically paged using the [pageTo] method.
class CustomDataTableState extends LayoutState<CustomDataTable> {
  //List<EntityModel>? listModel;
  late EntityModelList<EntityModel> models;
  late int _firstRowIndex;
  late int _rowCount;
  late bool _rowCountApproximate;
  int _selectedRowCount = 0;
  final Map<int, DataRow?> _rows = <int, DataRow?>{};

  CustomDataTableState();

  @override
  Widget build(BuildContext context) {
    // TODO(ianh): This whole build function doesn't handle RTL yet.

    if (widget.buildFunction != null) {
      return widget.buildFunction!(context, widget);
    }

    if (widget.models.getList().isEmpty) {
      return Text("No existen datos a mostrar...",
          style: TextStyle(fontSize: 20));
    }
    final color = widget.backGroundColor ?? Color.fromARGB(255, 231, 233, 245);
    assert(debugCheckHasMaterialLocalizations(context));

    final ThemeData themeData = Theme.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    // HEADER
    final List<Widget> headerWidgets = <Widget>[];
    if (_selectedRowCount == 0 && widget.header != null) {
      headerWidgets.add(
        Expanded(
          child: widget.header!,
        ),
      );
    } else if (widget.header != null) {
      headerWidgets.add(Expanded(
        child: Text(
          localizations.selectedRowCountTitle(_selectedRowCount),
        ),
      ));
    }
    if (widget.actions != null) {
      headerWidgets.addAll(
        widget.actions!.map<Widget>((Widget action) {
          return Padding(
            // 8.0 is the default padding of an icon button
            padding: const EdgeInsetsDirectional.only(start: 24.0 - 8.0 * 2.0),
            child: action,
          );
        }).toList(),
      );
    }

    // FOOTER
    final TextStyle? footerTextStyle = themeData.textTheme.bodySmall;
    final List<Widget> footerWidgets = <Widget>[];
    if (widget.onRowsPerPageChanged != null) {
      final List<Widget> availableRowsPerPage = widget.availableRowsPerPage
          .where(
              (int value) => value >= _rowCount || value == widget.rowsPerPage)
          .map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value'),
        );
      }).toList();
      footerWidgets.addAll(<Widget>[
        Container(
            width:
                14.0), // to match trailing padding in case we overflow and end up scrolling
        Text(localizations.rowsPerPageTitle),
        ConstrainedBox(
          constraints: const BoxConstraints(
              minWidth: 64.0), // 40.0 for the text, 24.0 for the icon
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                items: availableRowsPerPage.cast<DropdownMenuItem<int>>(),
                value: widget.rowsPerPage,
                onChanged: widget.onRowsPerPageChanged,
                style: footerTextStyle,
              ),
            ),
          ),
        ),
      ]);
    }
    footerWidgets.addAll(<Widget>[
      Container(width: 32.0),
      Text(
        localizations.pageRowsInfoTitle(
          _firstRowIndex + 1,
          _firstRowIndex + widget.rowsPerPage,
          _rowCount,
          _rowCountApproximate,
        ),
      ),
      Container(width: 32.0),
      if (widget.showFirstLastButtons)
        IconButton(
          icon: Icon(Icons.skip_previous, color: widget.arrowHeadColor),
          padding: EdgeInsets.zero,
          tooltip: localizations.firstPageTooltip,
          onPressed: _firstRowIndex <= 0 ? null : _handleFirst,
        ),
      IconButton(
        icon: Icon(Icons.chevron_left, color: widget.arrowHeadColor),
        padding: EdgeInsets.zero,
        tooltip: localizations.previousPageTooltip,
        onPressed: _firstRowIndex <= 0 ? null : _handlePrevious,
      ),
      Container(width: 24.0),
      IconButton(
        icon: Icon(Icons.chevron_right, color: widget.arrowHeadColor),
        padding: EdgeInsets.zero,
        tooltip: localizations.nextPageTooltip,
        onPressed: _isNextPageUnavailable() ? null : _handleNext,
      ),
      if (widget.showFirstLastButtons)
        IconButton(
          icon: Icon(Icons.skip_next, color: widget.arrowHeadColor),
          padding: EdgeInsets.zero,
          tooltip: localizations.lastPageTooltip,
          onPressed: _isNextPageUnavailable() ? null : _handleLast,
        ),
      Container(width: 14.0),
    ]);

    // CARD
    final dataRows =
        widget.dataRows ?? _getRows(_firstRowIndex, widget.rowsPerPage);

    widget.dataTable = DataTable(
      key: widget._tableKey,
      columns: widget.columns!,
      sortColumnIndex: widget.sortColumnIndex,
      sortAscending: widget.sortAscending,
      onSelectAll: widget.onSelectAll,
      // Make sure no decoration is set on the DataTable
      // from the theme, as its already wrapped in a Card.
      decoration: widget.tableDecoration ??
          BoxDecoration(
            color: color,
          ),
      dataRowHeight: widget.dataRowHeight,
      headingRowHeight: widget.headingRowHeight,
      horizontalMargin: widget.horizontalMargin,
      checkboxHorizontalMargin: widget.checkboxHorizontalMargin,
      columnSpacing: widget.columnSpacing,
      showCheckboxColumn: widget.showCheckboxColumn,
      showBottomBorder: widget.showBottomBorder,
      rows: dataRows,
    );

    return Card(
      semanticContainer: true,
      margin: widget.margin ??
          EdgeInsets.only(top: 0, left: 0.0, bottom: 1.0, right: 1.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (headerWidgets.isNotEmpty)
                Semantics(
                  container: true,
                  child: DefaultTextStyle(
                    // These typographic styles aren't quite the regular ones. We pick the closest ones from the regular
                    // list and then tweak them appropriately.
                    // See https://material.io/design/components/data-tables.html#tables-within-cards
                    style: _selectedRowCount > 0
                        ? themeData.textTheme.titleMedium!
                            .copyWith(color: themeData.colorScheme.secondary)
                        : themeData.textTheme.titleLarge!
                            .copyWith(fontWeight: FontWeight.w400),
                    child: IconTheme.merge(
                      data: const IconThemeData(
                        opacity: 0.54,
                      ),
                      child: Ink(
                        height: 64.0,
                        color: _selectedRowCount > 0
                            ? themeData.secondaryHeaderColor
                            : null,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 24, end: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: headerWidgets,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Container(
                //TODO pasar el decoration por parámetro
                decoration: BoxDecoration(
                    /*borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),*/
                    border: Border.all(
                  color: Colors.indigo.withOpacity(0.4),
                )),
                constraints: constraints,
                width: double.infinity,
                child: widget.dataTable
                /*Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 1.0, end: 1.0, bottom: 0, top: 1.0),
                  child: dataTable,
                )*/
                /*SingleChildScrollView(
                  padding: EdgeInsetsDirectional.only(start: 1, end: 1.0),
                  scrollDirection: Axis.horizontal,
                  dragStartBehavior: widget.dragStartBehavior,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    dragStartBehavior: widget.dragStartBehavior,
                    child: ConstrainedBox(
                      constraints:
                          constraints, //        BoxConstraints(minWidth: constraints.minWidth),
                      child: dataTable,
                    ),
                  ),
                )*/
                /*SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                dragStartBehavior: widget.dragStartBehavior,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.minWidth),
                  child: dataTable,
                ),
              ),*/
                ,
              ),
              if (_rowCount <
                  widget
                      .rowsPerPage) //Solo si la cantidad de filas es menor que las filas por páginas
                SizedBox(
                  height:
                      widget.dataRowHeight * (widget.rowsPerPage - _rowCount),
                  //width: 400,
                  child: Container(
                    constraints: constraints,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.indigo.withOpacity(0.4),
                        )),
                  ),
                ),
              DefaultTextStyle(
                style: footerTextStyle!,
                child: IconTheme.merge(
                  data: const IconThemeData(
                    opacity: 0.54,
                  ),
                  child: SizedBox(
                    // TODO(bkonyi): this won't handle text zoom correctly,
                    //  https://github.com/flutter/flutter/issues/48522
                    height: 56.0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          border: Border.all(
                            color: Colors.indigo.withOpacity(0.4),
                          )),
                      constraints: constraints,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        dragStartBehavior: widget.dragStartBehavior,
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Row(
                          children: footerWidgets,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void didUpdateWidget(CustomDataTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source != widget.source) {
      oldWidget.source!.removeListener(_handleDataSourceChanged);
      widget.source!.addListener(_handleDataSourceChanged);
      _handleDataSourceChanged();
    }
  }

  @override
  void dispose() {
    widget.source!.removeListener(_handleDataSourceChanged);
    widget.removeAutoObservation();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.state = this;
    models = widget.models;
    _firstRowIndex = PageStorage.of(context).readState(context) as int? ??
        widget.initialFirstRowIndex ??
        0;
    // _handleModelChanged();
    widget.source!.addListener(_handleDataSourceChanged);
    _handleDataSourceChanged();
  }

  /// Ensures that the given row is visible.
  void pageTo(int rowIndex) {
    final int oldFirstRowIndex = _firstRowIndex;
    _firstRowIndex = (rowIndex ~/ widget.rowsPerPage) * widget.rowsPerPage;
    if ((widget.onPageChanged != null) &&
        (oldFirstRowIndex != _firstRowIndex)) {
      widget.onPageChanged!(_firstRowIndex);
    }
  }

  setModels(EntityModelList<EntityModel> newListModel) {
    setState(() {
      models = widget.models = newListModel;
      // _handleModelChanged();
    });
  }

  @override
  update(Function() func) {
    setState(func);
  }

  DataRow _getBlankRowFor(int index) {
    return DataRow.byIndex(
      index: index,
      cells: widget.columns!
          .map<DataCell>((DataColumn column) => DataCell.empty)
          .toList(),
    );
  }

  DataRow _getProgressIndicatorRowFor(int index) {
    bool haveProgressIndicator = false;
    final List<DataCell> cells =
        widget.columns!.map<DataCell>((DataColumn column) {
      if (!column.numeric) {
        haveProgressIndicator = true;
        return const DataCell(CircularProgressIndicator());
      }
      return DataCell.empty;
    }).toList();
    if (!haveProgressIndicator) {
      haveProgressIndicator = true;
      cells[0] = const DataCell(CircularProgressIndicator());
    }
    return DataRow.byIndex(
      index: index,
      cells: cells,
    );
  }

  List<DataRow> _getRows(int firstRowIndex, int rowsPerPage) {
    final List<DataRow> result = <DataRow>[];
    final int nextPageFirstRowIndex = firstRowIndex + rowsPerPage;
    bool haveProgressIndicator = false;
    for (int index = firstRowIndex; index < nextPageFirstRowIndex; index += 1) {
      DataRow? row;
      if (index < _rowCount || _rowCountApproximate) {
        row = _rows.putIfAbsent(index, () => widget.source!.getRow(index));
        if (row == null && !haveProgressIndicator) {
          row ??= _getProgressIndicatorRowFor(index);
          haveProgressIndicator = true;
        }
      }
      //row ??= _getBlankRowFor(index);
      if (row != null && !result.contains(row)) {
        result.add(row);
      }
    }
    return result;
  }

  /*void _handleModelChanged() {
    final EntityModel? model =
        listModel.isNotEmpty ? listModel.elementAt(0) : null;
    widget.columns = CustomDataTable.buildColumnsFromModel(model!);
    widget.source = CustomDataTable.buildSource(
      root: "data",
      data: listModel,
      selectAllOnStart: widget.selectAllOnStart,
      dataTable: widget,
    );

    setState(() {
      _rowCount = widget.source!.rowCount;
      _rowCountApproximate = widget.source!.isRowCountApproximate;
      _selectedRowCount = widget.source!.selectedRowCount;
      _rows.clear();
      _handleFirst();
    });
  }*/

  void _handleDataSourceChanged() {
    setState(() {
      _rowCount = widget.source!.rowCount;
      _rowCountApproximate = widget.source!.isRowCountApproximate;
      _selectedRowCount = widget.source!.selectedRowCount;
      _rows.clear();
    });
  }

  void _handleFirst() {
    pageTo(0);
  }

  void _handleLast() {
    pageTo(((_rowCount - 1) / widget.rowsPerPage).floor() * widget.rowsPerPage);
  }

  void _handleNext() {
    pageTo(_firstRowIndex + widget.rowsPerPage);
  }

  void _handlePrevious() {
    pageTo(math.max(_firstRowIndex - widget.rowsPerPage, 0));
  }

  bool _isNextPageUnavailable() =>
      !_rowCountApproximate &&
      (_firstRowIndex + widget.rowsPerPage >= _rowCount);
}
