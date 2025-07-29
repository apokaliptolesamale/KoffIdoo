// ignore_for_file: must_be_immutable, overridden_fields, avoid_function_literals_in_foreach_calls, prefer_function_declarations_over_variables, prefer_final_fields, unused_element, library_private_types_in_public_api
/*
import '/app/widgets/utils/size_constraints.dart';
import 'package:flutter/material.dart';

import '../../../../app/core/services/logger_service.dart';
import '../../../core/interfaces/entity_model.dart';
import '../layout.dart';

//import '../../../../../app/modules/operation/domain/models/case_model.dart';
//import '../../../../app/modules/operation/widgets/layout_exporting.dart';

typedef FilterCardFunction = bool Function(CardItem<EntityModel> item);

class CardItem<EntityModelType extends EntityModel>
    extends Layout<CardItem<EntityModelType>> {
  static const double defaultHeight = 38.0;
  EntityModel item;
  EntityModel? caseModel;
  Widget? currentChild;
  @override
  double? height;
  @override
  double? width;
  @override
  int? index;
  @override
  Widget? body;
  bool onDetailView = false;
  bool isChecked = false;
  Color defaultColor = Colors.indigo[100]!;
  CardItemList? _collector;
  _CardItemState? _state = _CardItemState();
  CardViewStates viewState = CardViewStates.normal;

  BoxDecoration decoration;

  CardItem({
    Key? key,
    required this.item,
    this.caseModel,
    this.currentChild,
    this.decoration = const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    this.body,
    this.height = CardItem.defaultHeight,
    this.width = double.infinity,
    this.onDetailView = false,
    this.defaultColor = Colors.transparent,
    this.viewState = CardViewStates.normal,
    this.index,
    this.isChecked = false,
  }) : super(
            key: key,
            body: body ?? Container(),
            height: height,
            width: width,
            index: index) {
    _state = _CardItemState();

    if (defaultColor == Colors.transparent) {
      defaultColor = Colors.indigo[100]!;
    }
    on("hide", (event) {
      final target = event.getFiredArgs()["target"];
      if (target != this && !getState.onDetailView) {
        getState.hide();
      }
    }, this);
    on("show", (event) {
      if (!getState.onDetailView) {
        getState.show();
      }
    }, this);
    on("checked", (event) {
      event.getFiredArgs();
      getState.setChecked(true);
    }, this);
    on("unchecked", (event) {
      event.getFiredArgs();
      getState.setChecked(false);
    }, this);
  }

  CardItemList get getCollector => _collector ?? CardItemList();

  @override
  _CardItemState get getState => _state ?? createState();

  @override
  _CardItemState createState() => _state = _CardItemState();
  detail() {
    if (getState.mounted) {
      getState.update(() {
        viewState = CardViewStates.detail;
      });
    }
  }

  hide() {
    if (getState.mounted) {
      getState.update(() {
        viewState = CardViewStates.hidden;
      });
    }
  }

  setChecked(bool checked) {
    if (getState.mounted) {
      getState.setChecked(checked);
    }
  }

  setCollector(CardItemList newCollector) {
    _collector = newCollector;
  }

  @override
  setHeight(double? newHeight) {
    if (getState.mounted) {
      getState.setHeight(newHeight);
    }
  }

  show() {
    if (getState.mounted) {
      getState.update(() {
        viewState = CardViewStates.normal;
      });
    }
  }
}

class CardItemList extends Layout<CardItem> {
  List<CardItem> items = <CardItem>[];
  List<EntityModel> _selectedItems = <EntityModel>[];

  @override
  int? index;

  @override
  dynamic data;

  @override
  Widget? header;

  @override
  Widget? body;

  @override
  double? height;
  @override
  double? width;

  bool multiselect = false;

  FilterCardFunction filter = (CardItem<EntityModel> item) {
    return true;
  };

  _CardItemListState? _state;

  CardItemList({
    Key? key,
    Widget? body,
    this.items = const <CardItem>[],
    this.index,
    this.data,
    this.header,
    this.height = 60,
    this.width,
    this.multiselect = false,
  })  : body = body ?? Container(),
        super(
          key: key,
          index: index,
          data: data,
          body: body,
          header: header,
          height: height,
          width: width,
        ) {
    _state = _CardItemListState();
    int c = 0;
    on("loaded", (event) {
      log("Todos los items han sido cargados...");
    }, this);
    on("notifyChild", (event) {
      notifySubscribers(getFiredArgs()["action"]);
    }, this);
    on("unCheckAll", (event) {
      items.forEach((element) {
        element.setChecked(false);
      });
      _selectedItems = [];
    }, this);
    on("CheckAll", (event) {
      _selectedItems = [];
      items.forEach((element) {
        element.setChecked(true);
        _selectedItems.add(element.item);
      });
    }, this);
    on("unCheckOthers", (event) {
      final target = getFiredArgs()["target"];
      items.where((element) => element != target).forEach((el) {
        el.setChecked(false);
      });
      _selectedItems = [(target as CardItem).item];
    }, this);
    on("select", (event) {
      onSelectedItem(getFiredArgs()["target"]);
    }, this);
    on("deselect", (event) {
      onDeselectedItem(getFiredArgs()["target"]);
    }, this);
    items.forEach((element) {
      if (multiselect && element.isChecked) _selectedItems.add(element.item);
      element.setCollector(this);
      element.index = c++;
      subscribe(element);
    });
    fireEvent("loaded", {});
  }

  factory CardItemList.fromEntityList(List<EntityModel> list) => CardItemList(
        items: list.map((e) {
          return CardItem(item: e);
        }).toList(),
      );

  factory CardItemList.fromEntityModelListList(
          EntityModelList entityModelList) =>
      CardItemList(
        items: entityModelList.getList().map((e) {
          return CardItem(item: e);
        }).toList(),
      );

  @override
  _CardItemListState get getState => _state ?? createState();

  List<EntityModel> get selectedItems => _selectedItems;

  bool canShowAll() {
    for (var item in items) {
      if (item.onDetailView == true) return false;
    }
    return true;
  }

  @override
  _CardItemListState createState() => _state = _CardItemListState();

  Iterable<CardItem> filterAll(bool Function(CardItem element) test) =>
      items.where((item) {
        final value = test(item);
        value ? item.show() : item.hide();
        return value;
      });

  Iterable<EntityModel> filterSelected(
          bool Function(EntityModel element) test) =>
      _selectedItems.where(test);

  List<EntityModel> getSelectedItems() => selectedItems;
  onDeselectedItem(CardItem<EntityModel> item) {
    if (_selectedItems.contains(item.item)) {
      _selectedItems.remove(item.item);
    }
  }

  onSelectedItem(CardItem<EntityModel> item) {
    if (_selectedItems.isEmpty || !_selectedItems.contains(item.item)) {
      _selectedItems.add(item.item);
    }
  }

  setFilter(FilterCardFunction newFilter) {
    if (getState.mounted) {
      getState.setFilter(newFilter);
    }
  }
}

enum CardViewStates { normal, detail, hidden }

class _CardItemListState extends LayoutState<CardItemList> {
  FilterCardFunction filter = (CardItem<EntityModel> item) {
    return true;
  };

  @override
  Widget build(BuildContext context) {
    final constraint = SizeConstraints(context: context);
    height = height ?? constraint.getHeightByPercent(100);
    width = width ?? double.infinity;
    int canOnlyShow = (height! / (CardItem.defaultHeight + 10)).round();
    canOnlyShow =
        canOnlyShow > widget.items.length ? widget.items.length : canOnlyShow;

    List<CardItem> filteredItems =
        widget.items.where((element) => filter(element)).toList();

    return Container(
      margin: EdgeInsets.all(1),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          border: Border.all(
            color: Colors.indigo.withOpacity(0.8),
          )),
      //width: width,
      //height: height,
      child: Wrap(
        children: filteredItems,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    width = widget.width;
    height = widget.height;
  }

  setFilter(FilterCardFunction newFilter) {
    setState(() {
      if (mounted) filter = newFilter;
    });
  }

  _onChange(CardItemList list) {
    list.update(list.onUpdate);
  }
}

class _CardItemState<EntityModelType extends EntityModel>
    extends LayoutState<CardItem<EntityModelType>> {
  bool onDetailView = false;
  bool onHover = false;
  bool onClicked = false;
  bool isChecked = false;
  Color defaultColor = Colors.indigo[50]!;
  Color onHoverDefaultColor = Colors.indigo[50]!;
  CardViewStates viewState = CardViewStates.normal;
  CaseModel? caseModel;
  Widget? currentChild;

  @override
  Widget build(BuildContext context) {
    //ConfigApp appConf = ConfigApp.instance;
    //ConfigModel appConfService = appConf.getValue<ConfigModel>("sys_config")!;
    //Color color = appConfService.themes.elementAt(0).getPrimaryColor();
    final constraint = SizeConstraints(context: context);
    final decoration = widget.decoration;
    final checkColumn = Checkbox(
        value: isChecked,
        onChanged: (bool? newValue) {
          if (widget.getCollector.multiselect == false) {
            widget.getCollector.fireEvent("unCheckOthers", {});
          }
          setState(() {
            isChecked = newValue ?? false;
            if (isChecked == true) {
              widget.getCollector.fireEvent("select", {
                "target": widget,
              });
            } else {
              widget.getCollector.fireEvent("deselect", {
                "target": widget,
              });
            }
          });
        });
    // height=viewState == CardViewStates.normal?height:600;

    return viewState == CardViewStates.hidden
        ? Container()
        : Container(
            margin: EdgeInsets.all(5),
            decoration: decoration,
            height: height,
            width: widget.width,
            child: Row(
              children: [
                Container(
                  alignment: onClicked ? Alignment.topCenter : Alignment.center,
                  child: checkColumn,
                  //width: constraint.getWidthByPercent(2),
                  height: height,
                  decoration: BoxDecoration(
                    color: !onHover ? defaultColor : onHoverDefaultColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    border: Border.all(color: Colors.transparent),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        onClicked = !onClicked;
                        onDetailView = onClicked;
                        height =
                            onDetailView ? constraint.getHeight : widget.height;
                        widget.getCollector.fireEvent("notifyChild", {
                          "target": widget,
                          "onDetailView": onDetailView,
                          "action": onDetailView ? "hide" : "show",
                        });
                      });
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onExit: (_) {
                        setState(() {
                          defaultColor = widget.defaultColor;
                          onHover = false;
                        });
                      },
                      onHover: (_) {
                        setState(() {
                          defaultColor = onHoverDefaultColor.withOpacity(0.1);
                          onHover = true;
                        });
                      },
                      child: Container(
                        color: !onHover ? defaultColor : onHoverDefaultColor,
                        height: height,
                        child: widget.body ?? Container(),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  alignment: onClicked ? Alignment.topCenter : Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        onClicked = !onClicked;
                        onDetailView = onClicked;
                        height =
                            onDetailView ? constraint.getHeight : widget.height;
                        widget.getCollector.fireEvent("notifyChild", {
                          "target": widget,
                          "onDetailView": onDetailView,
                          "action": onDetailView ? "hide" : "show",
                        });
                      });
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onExit: (_) {
                        setState(() {
                          defaultColor = widget.defaultColor;
                          onHover = false;
                        });
                      },
                      onHover: (_) {
                        setState(() {
                          defaultColor = onHoverDefaultColor.withOpacity(0.1);
                          onHover = true;
                        });
                      },
                      child: Icon(
                        onDetailView == false
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                      ),
                    ),
                  ),
                  //width: constraint.getWidthByPercent(2),
                  height: height,
                  decoration: BoxDecoration(
                    color: !onHover ? defaultColor : onHoverDefaultColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                )
              ],
            ),
          );
  }

  detail() {
    setState(() {
      viewState = CardViewStates.detail;
    });
  }

  @override
  void dispose() {
    widget.closeSubscriptions();
    super.dispose();
  }

  hide() {
    setState(() {
      viewState = CardViewStates.hidden;
    });
  }

  @override
  void initState() {
    super.initState();
    height = widget.height;
    width = widget.width;
    onDetailView = widget.onDetailView;
    isChecked = widget.isChecked;
    defaultColor = widget.defaultColor;
    onHoverDefaultColor = defaultColor.withOpacity(0.5);
    onHover = false;
    onClicked = false;
    viewState = CardViewStates.normal;
    caseModel = widget.caseModel as CaseModel?;
  }

  setChecked(bool checked) {
    setState(() {
      isChecked = checked;
    });
  }

  @override
  setHeight(double? newHeight) {
    if (mounted) {
      setState(() {
        height = newHeight;
      });
    }
  }

  show() {
    setState(() {
      viewState = CardViewStates.normal;
    });
  }
}*/
