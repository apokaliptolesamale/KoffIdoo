// ignore_for_file: must_be_immutable, camel_case_types, library_private_types_in_public_api, overridden_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/types/custom_types.dart';
import '../components/custom_widget.dart';
import '../patterns/publisher_subscriber.dart';

typedef onCancelType<T> = Function(
    DefaultCustomIconButton<T> scope, dynamic args);

typedef onSelectedType<T> = Function(
    DefaultCustomIconButton<T> scope, dynamic args);

typedef onTapType<T> = Function(DefaultCustomIconButton<T> scope, dynamic args);

typedef PopupMenuItemBuilder<T> = List<PopupMenuEntry<T>> Function(
    BuildContext context, DefaultCustomIconButton<T> scope);

class CustomOutlinedIconButton<T> extends GetResponsiveWidget
    with WidgetsBindingObserver, SubscriberMixinImpl<T>, PublisherMixinImpl<T>
    implements CustomWidgetInterface {
  final onPressedCallBack onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final Widget icon;
  Widget? rigthActionButton;
  MouseCursor? cursor;
  bool? opaque;
  HitTestBehavior? hitTestBehavior;
  onTapCallBack? onTap;
  onEnterCallBack? onEnter;
  onExitCallBack? onExit;
  onHoverCallBack? onHover;
  EdgeInsetsGeometry? margin;
  @override
  Map<String, void Function(Publisher<Subscriber<T>> event)> listeners;

  @override
  CustomWidgetInterface? container;

  CustomOutlinedIconButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.listeners = const {},
    this.color = Colors.indigo,
    this.isFilled = false,
    this.rigthActionButton,
    this.cursor,
    this.opaque,
    this.hitTestBehavior,
    this.onTap,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.margin,
  }) : super(
          key: key,
        ) {
    applyListeners();
  }

  @override
  Map<String, List<void Function(Publisher<Subscriber<T>> event)>>
      get getSubscriptionsFunction => subscriptionsFunction;

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    final shape = screen.isDesktop ? StadiumBorder() : CircleBorder();

    return _Button(
      refBotton: this,
      onTap: <CustomOutlinedIconButton>(ctx, btn) {
        onTap != null ? onTap!(ctx, this) : false;
      },
      onHover: <CustomOutlinedIconButton>(ctx, event, btn) {
        onHover != null ? onHover!(ctx, event, this) : false;
      },
      onEnter: <CustomOutlinedIconButton>(ctx, event, btn) {
        onEnter != null ? onEnter!(ctx, event, this) : false;
      },
      onExit: <CustomOutlinedIconButton>(ctx, event, btn) {
        onExit != null ? onExit!(ctx, event, this) : false;
      },
      cursor: cursor,
      hitTestBehavior: hitTestBehavior,
      shape: shape,
      color: color,
      onPressed: onPressed,
      icon: icon,
      text: text,
      screen: screen,
      margin: margin,
      actions: _getActions(),
    );
  }

  @override
  CustomWidgetInterface setContainer(CustomWidgetInterface container) {
    this.container = container;
    return this;
  }

  List<Widget> _getActions() {
    List<Widget> list = [];
    if (rigthActionButton != null) list.add(rigthActionButton!);
    return list;
  }
}

class DefaultCustomIconButton<T> extends StatefulWidget
    implements CustomWidgetInterface {
  onTapType<T> onTab;
  onCancelType<T>? onCanceled;
  onSelectedType<T>? onSelected;
  Color? color;
  bool isFilled;
  Widget icon;
  Widget? child;
  Widget? rigthActionButton;
  BoxDecoration? decoration;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  double? elevation;
  bool enabled;
  _DefaultCustomIconButtonState? _state;

  final List<T> menuItems;
  final ShapeBorder? shape;
  final T? initialValue;
  final Offset offset;
  final PopupMenuItemBuilder<T>? itemBuilder;
  final bool? enableFeedback;
  final String? tooltip;
  late BuildContext _context;

  @override
  CustomWidgetInterface? container;
  DefaultCustomIconButton({
    Key? key,
    required this.onTab,
    required this.icon,
    this.menuItems = const [],
    this.tooltip,
    this.child,
    this.onCanceled,
    this.onSelected,
    this.enableFeedback,
    this.shape,
    this.initialValue,
    this.elevation,
    this.itemBuilder,
    this.offset = Offset.zero,
    this.color = Colors.white,
    this.isFilled = false,
    this.rigthActionButton,
    this.decoration,
    this.margin,
    this.padding,
    this.enabled = false,
  }) : super(key: key) {
    _state = _state ?? _DefaultCustomIconButtonState();
  }
  _DefaultCustomIconButtonState get getState =>
      _state ?? createState() as _DefaultCustomIconButtonState;
  @override
  State<DefaultCustomIconButton> createState() => getState;

  @override
  CustomWidgetInterface setContainer(CustomWidgetInterface container) {
    this.container = container;
    return this;
  }

  void showButtonMenu() {
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(_context);
    final RenderBox button = _context.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(_context)
        .overlay!
        .context
        .findRenderObject()! as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomCenter(Offset.zero) + offset,
            ancestor: overlay),
        button.localToGlobal(button.size.bottomLeft(Offset.zero) + offset,
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final List<PopupMenuEntry<T>> items = itemBuilder!(_context, this);

    // Only show the menu if there is something to show
    if (items.isNotEmpty) {
      showMenu<T?>(
        context: _context,
        elevation: elevation ?? popupMenuTheme.elevation,
        items: items,
        initialValue: initialValue,
        position: position,
        shape: shape ?? popupMenuTheme.shape,
        color: color ?? popupMenuTheme.color,
      ).then<void>((T? newValue) {
        if (_state!.mounted) return null;
        if (newValue == null && onCanceled != null) {
          onCanceled?.call(this, newValue);
          return null;
        }
        if (onSelected != null) {
          onSelected?.call(this, newValue);
        }
      });
    }
  }

  update(Function() func) {
    if (getState.mounted) {
      getState.update(func);
    }
  }
}

class _Button extends StatefulWidget {
  final CustomOutlinedIconButton refBotton;
  final onTapCallBack? onTap;
  final onHoverCallBack? onHover;
  final onEnterCallBack? onEnter;
  final onExitCallBack? onExit;
  final MouseCursor? cursor;
  final HitTestBehavior? hitTestBehavior;
  final OutlinedBorder shape;
  final Color color;
  final onPressedCallBack onPressed;
  final ResponsiveScreen screen;
  final Widget icon;
  final String text;
  List<Widget> actions;
  EdgeInsetsGeometry? margin;
  _Button({
    Key? key,
    required this.refBotton,
    required this.onTap,
    required this.onHover,
    required this.onEnter,
    required this.onExit,
    required this.cursor,
    required this.hitTestBehavior,
    required this.shape,
    required this.color,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.screen,
    this.margin,
    this.actions = const [],
  }) : super(key: key);
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<_Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onTap != null ? widget.onTap!(context, widget.refBotton) : false;
      },
      child: MouseRegion(
        onHover: (event) {
          widget.onHover != null
              ? widget.onHover!(context, event, widget.refBotton)
              : false;
        },
        onEnter: (event) {
          widget.onEnter != null
              ? widget.onEnter!(context, event, widget.refBotton)
              : false;
        },
        onExit: (event) {
          widget.onExit != null
              ? widget.onExit!(context, event, widget.refBotton)
              : false;
        },
        cursor: widget.cursor ?? SystemMouseCursors.click,
        opaque: false,
        hitTestBehavior: widget.hitTestBehavior ?? HitTestBehavior.deferToChild,
        child: Container(
          margin: widget.margin ?? EdgeInsets.all(5),
          child: OutlinedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(widget.shape),
                padding: MaterialStateProperty.all(EdgeInsets.all(2.0)),
                backgroundColor:
                    MaterialStateProperty.all(widget.color.withOpacity(0.8)),
                alignment: Alignment.center,
                overlayColor:
                    MaterialStateProperty.all(widget.color.withOpacity(0.6))),
            onPressed: () => widget.onPressed(context, widget.refBotton),
            child: widget.screen.isDesktop
                ? Row(
                    children: [
                      Center(child: widget.icon),
                      if (widget.screen.isDesktop)
                        Text(widget.text,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ...widget.actions
                    ],
                  )
                : Column(
                    children: [
                      Center(child: widget.icon),
                      if (widget.screen.isDesktop)
                        Text(widget.text,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ...widget.actions
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _DefaultCustomIconButtonState<T>
    extends State<DefaultCustomIconButton<T>> {
  bool enabled = false;
  Color color = Colors.transparent;
  Color defaultColor = Colors.transparent;
  Color onHoverColor = Colors.transparent;
  Widget? icon;
  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeOf(context)?.navigationMode ??
        NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return widget.enabled;
      case NavigationMode.directional:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget._context = context;
    //final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final bool enableFeedback = widget.enableFeedback ??
        PopupMenuTheme.of(context).enableFeedback ??
        true;

    //assert(debugCheckHasMaterialLocalizations(context));

    if (widget.child != null) {
      return Tooltip(
        message:
            widget.tooltip ?? MaterialLocalizations.of(context).showMenuTooltip,
        child: InkWell(
          onTap: widget.enabled
              ? () {
                  widget.showButtonMenu();
                }
              : null,
          canRequestFocus: _canRequestFocus,
          enableFeedback: enableFeedback,
          child: widget.child,
        ),
      );
    }

    //Color color = (widget.color ?? popupMenuTheme.color)!;
    return MouseRegion(
      onHover: (phe) {
        setState(() {
          color = onHoverColor;
        });
      },
      onExit: (phe) {
        setState(() {
          color = defaultColor;
        });
      },
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: widget.padding ?? EdgeInsets.all(0),
        margin: widget.margin ?? EdgeInsets.all(0),
        decoration: widget.decoration ??
            BoxDecoration(
              color: color != widget.color ? color : Colors.transparent,
              shape: BoxShape.circle,
            ),
        child: widget.child ??
            GestureDetector(
              child: Row(
                children: [icon!, ..._getActions()],
              ),
              onTap: () => widget.onTab(widget, context),
              onTapDown: (TapDownDetails details) {
                setState(() {
                  widget.enabled = enabled = !enabled;
                });
              },
              onTapCancel: () {
                setState(() {
                  widget.enabled = enabled = false;
                });
              },
            ),
      ),
    );

    /*return OutlinedButton(
      child: icon,
      style: ButtonStyle(
          shape: MaterialStateProperty.all(StadiumBorder()),
          padding: MaterialStateProperty.all(EdgeInsets.all(2.0)),
          backgroundColor: MaterialStateProperty.all(color.withOpacity(0.8)),
          alignment: Alignment.center,
          overlayColor: MaterialStateProperty.all(color.withOpacity(0.6))),
      onPressed: () => onTab(),
    );*/
  }

  @override
  void dispose() {
    super.dispose();
    color = Colors.transparent;
  }

  @override
  void initState() {
    super.initState();
    color = defaultColor = widget.color ?? Colors.white;
    onHoverColor = color.withOpacity(0.8);
    enabled = widget.enabled;
    icon = widget.icon;
  }

  update(Function() func) {
    setState(func);
  }

  List<Widget> _getActions() {
    List<Widget> list = [];
    if (widget.rigthActionButton != null) list.add(widget.rigthActionButton!);
    return list;
  }
}
