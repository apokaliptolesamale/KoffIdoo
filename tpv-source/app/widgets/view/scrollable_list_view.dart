// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
// ignore_for_file: must_be_immutable, unused_field

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '/app/core/config/assets.dart';
import '/app/core/helpers/snapshot.dart';
import '/app/core/services/logger_service.dart';
import '../../../../app/widgets/promise/custom_future_builder.dart';

class ScrollableListView<ItemType> extends StatefulWidget {
  // late List<ItemType> _items;
  Widget? Function(
          BuildContext, int, List<ItemType>, ItemType item, ScrollController)
      builder;
  int Function(ItemType, ItemType)? itemComparator;
  int Function(String, String)? groupComparator;
  String Function(ItemType)? groupBy;
  bool Function(ItemType, dynamic compareTo)? searcher;
  void Function(ScrollableListView<ItemType>, int, int)? onReorder;
  late ScrollController _controller;
  late TextEditingController _searcherController;
  Future<List<ItemType>> Function(
      ScrollableListView<ItemType>, int page, int limit) onRefresh;
  ItemType Function(ScrollableListView<ItemType>, ItemType)?
      itemTransformCallBack;
  Widget Function(ScrollableListView<ItemType>, int index)?
      stickyTransformToWidget;
  bool isInfinity;
  bool isGroup;
  bool includeSearcher;
  int page, limit;
  StickyConfig? stickyConf;

  _ScrollableListViewState<ItemType>? _state;

  ScrollableListView({
    Key? key,
    required this.builder,
    required this.onRefresh,
    required TextEditingController searcherController,
    this.groupComparator,
    this.itemComparator,
    this.groupBy,
    this.onReorder,
    this.searcher,
    this.itemTransformCallBack,
    this.stickyTransformToWidget,
    this.page = 0,
    this.limit = 15,
    this.isInfinity = true,
    this.includeSearcher = true,
    this.isGroup = false,
    this.stickyConf,
    List<ItemType>? items,
    ScrollController? controller,
  }) {
    //_items = items ?? [];
    _controller = controller ?? ScrollController();
    _searcherController = searcherController;
    _state = getState;
  }
  List<ItemType> get getItems => getState._items;
  _ScrollableListViewState<ItemType> get getState => _state ?? createState();

  @override
  _ScrollableListViewState<ItemType> createState() =>
      _ScrollableListViewState<ItemType>();

  void initGroupBy() {
    if (isGroup && groupBy == null) {
      groupBy = (ItemType item) {
        return "";
      };
    }
  }
}

class StickyConfig {
  BuildContext context;
  Widget sticky;
  Color primaryColor;
  Color secundaryColor;
  EdgeInsets? padding;
  StickyConfig({
    required this.context,
    required this.sticky,
    required this.primaryColor,
    required this.secundaryColor,
    this.padding,
  });
}

class _ScrollableListViewState<ItemType>
    extends State<ScrollableListView<ItemType>> {
  List<ItemType> items = [];
  final controller = ScrollController();
  int page = 1;
  bool hasMore = true;
  bool isLoading = false;

  late List<ItemType> _items;
  late ScrollController _controller;

  int limit = 15;
  double stuckAmount = 1;
  bool includeSearcher = true;
  late TextEditingController _searcherController;
  bool isGroup = false;
  int Function(ItemType, ItemType)? itemComparator;
  int Function(String, String)? groupComparator;

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      context: context,
      future: refreshWith((view) => widget.onRefresh(view, page, limit)),
      builder: (context, snapshot) {
        if (isWaiting(snapshot)) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //
        else if (isError(snapshot)) {
          return Text("Error del servicio...");
        }
        builder(BuildContext context, int index, ItemType element) {
          Color color = (Color.lerp(
                    widget.stickyConf!.primaryColor,
                    widget.stickyConf!.secundaryColor,
                    stuckAmount,
                  ) ??
                  widget.stickyConf!.primaryColor)
              .withOpacity(0.5 + stuckAmount * 0.5);
          //final ItemType element = _items.elementAt(index);
          if (index < _items.length) {
            return widget.stickyConf == null
                ? widget.builder(
                    context,
                    index,
                    _items,
                    element,
                    widget._controller,
                  )
                : StickyHeaderBuilder(
                    overlapHeaders: true,
                    builder: (context, double amount) {
                      setState(() {
                        stuckAmount = 1 - amount.clamp(0, 1);
                      });
                      return widget.builder(
                        context,
                        index,
                        _items,
                        element,
                        widget._controller,
                      )!;
                    },
                    content: Container(
                      color: color,
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: widget.stickyTransformToWidget != null
                          ? widget.stickyTransformToWidget!(widget, index)
                          : Image.asset(
                              ASSETS_IMAGES_ICONS_APP_EMPTYIMG_JPEG,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200.0,
                            ),
                    ),
                  );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: hasMore
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text("No existen más datos a cargar."),
            );
          }
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              if (includeSearcher) createSearcher(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => refreshWith((view) {
                    return widget.onRefresh(view, page, limit);
                  }),
                  child: buildListViewType(builder),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ReorderableListView buildListViewType(
    Widget? Function(BuildContext context, int index, ItemType element) builder,
  ) {
    GroupedListView<ItemType, String>(
      elements: _items,
      useStickyGroupSeparators: true,
      itemComparator: itemComparator ??
          (element1, element2) {
            return element1.toString().compareTo(element2.toString());
          },
      groupComparator: groupComparator ??
          (value1, value2) {
            return value2.compareTo(value1);
          },
      groupSeparatorBuilder: (value) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          color: Colors.blueAccent,
          child: Text(value),
        );
      },
      groupBy: widget.groupBy ??
          (ItemType item) {
            return "";
          },
      itemBuilder: (context, element) {
        var index = _items.indexOf(element);
        return builder(context, index, element)!;
      },
    );

    return ReorderableListView.builder(
      scrollController: widget._controller,
      itemBuilder: (context, index) {
        var element = _items.elementAt(index);
        return builder(context, index, element)!;
      },
      itemCount: _items.length + (widget.isInfinity ? 1 : 0),
      onReorder: (oldIndex, newIndex) {
        if (widget.onReorder != null) {
          setState(() {
            widget.onReorder!(
              widget,
              oldIndex,
              newIndex,
            );
          });
        } else {
          setState(() {
            newIndex = newIndex > oldIndex ? newIndex-- : newIndex;
            final item = _items.elementAt(oldIndex);
            _items.insert(newIndex, item);
          });
        }
      },
    );
  }

  Widget createSearcher() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: TextField(
        controller: _searcherController,
        onChanged: search,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Buscar...",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black12, width: 0.3))),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<List<ItemType>> fetch() async {
    if (isLoading) return [];
    isLoading = true;
    final result = await widget.onRefresh(widget, page, limit);
    setState(() {
      page++;
      isLoading = false;
      final list = result.map<ItemType>((item) {
        return widget.itemTransformCallBack != null
            ? widget.itemTransformCallBack!(widget, item)
            : item;
      }).toList();
      if (list.length < limit || list.isEmpty) hasMore = false;
      list.isNotEmpty ? _items.addAll(list) : null;
    });
    return result;
  }

  @override
  void initState() {
    super.initState();
    itemComparator = widget.itemComparator;
    groupComparator = widget.groupComparator;
    includeSearcher = widget.includeSearcher;
    page = widget.page;
    limit = widget.limit;
    _items = []; //widget._items;

    _controller = widget._controller;
    _searcherController = widget._searcherController;
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset &&
          hasMore) {
        fetch();
      }
    });
    _searcherController.addListener(() {
      log(_searcherController.text);
      search(_searcherController.text);
    });
    fetch();
  }

  insertItems(List<ItemType> newItems, int index) {
    if (index < newItems.length && index > 0) {
      setState(() {
        items.insertAll(index, newItems);
      });
    }
  }

  Future<bool> refresh(
    List<ItemType>? newItems, {
    bool replace = false,
  }) async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 1;
      if (replace) {
        _items.clear();
      }
      replace
          ? _items = newItems ?? []
          : newItems != null && newItems.isNotEmpty
              ? _items.addAll(newItems)
              : null;
    });
    if (hasMore) fetch();
    return Future.value(true);
  }

  Future refreshWith(
    Future<List<ItemType>> Function(ScrollableListView<ItemType> view) call, {
    bool replace = false,
  }) async {
    if (replace) {
      setState(() {
        _items.clear();
      });
    }
    List<ItemType> newItems = hasMore ? await call(widget) : [];
    final result = await refresh(
      newItems,
      replace: replace,
    );
    return result;
  }

  void search(String value) {
    final hasSearcher = widget.searcher != null;
    final result = _items
        .where((element) =>
            hasSearcher ? widget.searcher!(element, value) : hasSearcher)
        .toList();
    setState(() {
      _items = result;
    });
  }
}
