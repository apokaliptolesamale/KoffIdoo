// ignore_for_file: must_be_immutable, prefer_final_fields, unused_field

import 'package:flutter/material.dart';

import '../../../app/widgets/patterns/publisher_subscriber.dart';

typedef HeaderBuilderType = Widget Function(Layout scope);

class Layout<T> extends StatefulWidget
    with WidgetsBindingObserver, SubscriberMixinImpl<T>, PublisherMixinImpl<T> {
  int? index;
  dynamic data;
  LayoutState? _state = LayoutState();
  Widget? header;
  Widget? body;
  HeaderBuilderType? headerBuilder;
  bool isVisible;
  bool isHeaderVisible;
  Color? color;
  double? height;
  double? width;
  MediaQueryData? queryData;
  late Size _lastSize;

  Layout({
    Key? key,
    this.body,
    this.index,
    this.data,
    this.header,
    this.headerBuilder,
    this.isVisible = true,
    this.isHeaderVisible = true,
    this.height,
    this.width,
    this.color,
  }) : super(key: key) {
    header =
        headerBuilder != null && header == null ? headerBuilder!(this) : null;
    body = body ?? Container();
  }
  LayoutState get getState => _state ?? createState();

  @override
  Map<String, List<void Function(Publisher<Subscriber<T>> event)>>
      get getSubscriptionsFunction => subscriptionsFunction;

  bool get hasHeader => header != null;

  void addObserver(WidgetsBindingObserver observer) =>
      WidgetsBinding.instance.addObserver(observer);

  void autoObservation() => addObserver(this);

  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.topCenter,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.center,
            child: header,
          ),
          body ?? Container()
        ],
      ),
    );
  }

  @override
  LayoutState<Layout> createState() => _state = LayoutState();

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    getState.update(() {
      _lastSize = WidgetsBinding.instance.window.physicalSize;
    });
    fireEvent("onWindowResize", {"queryData": queryData, "Size": _lastSize});
  }

  Widget doLayout(BuildContext context, dynamic args) {
    queryData = MediaQuery.of(context);
    return this;
  }

  Widget paint(BuildContext context) {
    queryData = MediaQuery.of(context);
    return build(context);
  }

  void removeAutoObservation() => removeObserver(this);

  void removeObserver(WidgetsBindingObserver observer) =>
      WidgetsBinding.instance.removeObserver(observer);

  setBody(Widget body) {
    if (getState.mounted) getState.setBody(body);
  }

  setColor(Color newColor) {
    if (_state!.mounted) {
      _state!.setColor(newColor);
    }
  }

  setData(dynamic newData) {
    if (getState.mounted) {
      getState.setData(newData);
    }
  }

  setHeader(Widget? header) {
    if (getState.mounted) {
      getState.setHeader(header);
    }
  }

  setHeaderVisible(bool visible) {
    if (_state!.mounted) {
      _state!.update(() {
        isHeaderVisible = visible;
      });
    }
  }

  setHeight(double? newHeight) {
    if (getState.mounted) {
      getState.setHeight(newHeight);
    }
  }

  setVisible(bool visible) {
    if (_state!.mounted) {
      _state!.update(() {
        isVisible = visible;
      });
    }
  }

  setWidth(double? newWidth) {
    if (getState.mounted) {
      getState.setWidth(newWidth);
    }
  }

  update(Function() func) {
    if (getState.mounted) {
      func();
    }
  }
}

class LayoutState<LayoutType extends Layout> extends State<LayoutType> {
  dynamic data;
  int? index;
  Widget? header;
  Widget? body;
  bool? isVisible;
  bool? isHeaderVisible;
  Color? color;
  double? height;
  double? width;

  dynamic get getData => data;

  @override
  void activate() {
    super.activate();
  }

  @override
  Widget build(BuildContext context) => widget.build(context);

  @override
  void didUpdateWidget(covariant LayoutType oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(widget);
  }

  @override
  void initState() {
    super.initState();
    widget._lastSize = WidgetsBinding.instance.window.physicalSize;
    WidgetsBinding.instance.addObserver(widget);
    widget._state = widget._state ?? this;
    setState(() {
      header = widget.header;
      body = widget.body;
      index = widget.index;
      data = widget.data;
      isVisible = widget.isVisible;
      isHeaderVisible = widget.isHeaderVisible;
      color = widget.color;
      height = widget.height;
      width = widget.width;
    });
  }

  void onWindowResize() {}

  setBody(Widget newBody) {
    if (mounted) {
      setState(() {
        widget.body = body = newBody;
      });
    }
  }

  setColor(Color newColor) {
    if (mounted) {
      color = newColor;
    }
  }

  setData(dynamic newData) {
    setState(() {
      widget.data = data = newData;
    });
  }

  setHeader(Widget? newHeader) {
    if (mounted) {
      setState(() {
        widget.header = header = newHeader;
      });
    }
  }

  setHeight(double? newHeight) {
    if (mounted) {
      setState(() {
        height = widget.height = newHeight;
      });
    }
  }

  setWidth(double? newWidth) {
    if (mounted) {
      setState(() {
        width = widget.width = newWidth;
      });
    }
  }

  update(Function() func) {
    if (mounted) {
      setState(() {
        func();
      });
    }
  }
}
