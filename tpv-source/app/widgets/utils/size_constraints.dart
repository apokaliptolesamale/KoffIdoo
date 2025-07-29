// ignore_for_file: unused_element, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FitterContainer extends StatefulWidget {
  double? width;
  double? height;
  double? widthPercent = 100;
  double? heightPercent = 100;
  BuildContext? parentContext;

  /// The [child] contained by the container.
  ///
  /// If null, and if the [constraints] are unbounded or also null, the
  /// container will expand to fill all available space in its parent, unless
  /// the parent provides unbounded constraints, in which case the container
  /// will attempt to be as small as possible.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  Widget? child;

  /// Align the [child] within the container.
  ///
  /// If non-null, the container will expand to fill its parent and position its
  /// child within itself according to the given value. If the incoming
  /// constraints are unbounded, then the child will be shrink-wrapped instead.
  ///
  /// Ignored if [child] is null.
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  AlignmentGeometry? alignment;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the [decoration];
  /// see [Decoration.padding].
  EdgeInsetsGeometry? padding;

  /// The color to paint behind the [child].
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the [decoration]
  /// property.
  ///
  /// If the [decoration] is used, this property must be null. A background
  /// color may still be painted by the [decoration] even if this property is
  /// null.
  Color? color;

  /// The decoration to paint behind the [child].
  ///
  /// Use the [color] property to specify a simple solid color.
  ///
  /// The [child] is not clipped to the decoration. To clip a child to the shape
  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  Decoration? decoration;

  /// The decoration to paint in front of the [child].
  Decoration? foregroundDecoration;

  /// Additional constraints to apply to the child.
  ///
  /// The constructor `width` and `height` arguments are combined with the
  /// `constraints` argument to set this property.
  ///
  /// The [padding] goes inside the constraints.
  BoxConstraints? constraints;

  /// Empty space to surround the [decoration] and [child].
  EdgeInsetsGeometry? margin;

  /// The transformation matrix to apply before painting the container.
  Matrix4? transform;

  /// The alignment of the origin, relative to the size of the container, if [transform] is specified.
  ///
  /// When [transform] is null, the value of this property is ignored.
  ///
  /// See also:
  ///
  ///  * [Transform.alignment], which is set by this property.
  AlignmentGeometry? transformAlignment;

  /// The clip behavior when [Container.decoration] is not null.
  ///
  /// Defaults to [Clip.none]. Must be [Clip.none] if [decoration] is null.
  ///
  /// If a clip is to be applied, the [Decoration.getClipPath] method
  /// for the provided decoration must return a clip path. (This is not
  /// supported by all decorations; the default implementation of that
  /// method throws an [UnsupportedError].)
  Clip clipBehavior;

  FitterContainer({
    Key? key,
    this.child,
    this.parentContext,
    this.widthPercent = 100,
    this.heightPercent = 100,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
  })  : assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(constraints == null || constraints.debugAssertIsValid()),
        assert(decoration != null || clipBehavior == Clip.none),
        assert(
          color == null || decoration == null,
          'Cannot provide both a color and a decoration\n'
          'To provide both, use "decoration: BoxDecoration(color: color)".',
        ),
        width = (width != null && widthPercent != null)
            ? width * widthPercent / 100
            : width,
        height = (height != null && heightPercent != null)
            ? height * heightPercent / 100
            : height,
        constraints = (width != null || height != null)
            ? constraints?.tighten(width: width, height: height) ??
                BoxConstraints.tightFor(width: width, height: height)
            : constraints,
        super(key: key);

  EdgeInsetsGeometry? get _paddingIncludingDecoration {
    if (decoration == null) {
      return padding;
    }
    final EdgeInsetsGeometry decorationPadding = decoration!.padding;
    if (padding == null) {
      return decorationPadding;
    }
    return padding!.add(decorationPadding);
  }

  @override
  State<FitterContainer> createState() => _FitterContainerState();
}

class SizeConstraints {
  BuildContext context;

  SizeConstraints({
    required this.context,
  });

  double get getHeight => getSize.height;
  Size get getSize => MediaQuery.of(context).size;
  double get getWidth => getSize.width;

  bool get horizontalShow => !verticalShow;
  bool get verticalShow => getSize.height > getSize.width;

  double getHeightByPercent(double percent, {double? vheight, double? hwidth}) {
    if (vheight != null && verticalShow) {
      percent = vheight;
    } else if (hwidth != null && horizontalShow) {
      percent = hwidth;
    }
    return getHeight * percent / 100;
  }

  double getWidthByPercent(double percent, {double? vheight, double? hwidth}) {
    if (vheight != null && verticalShow) {
      percent = vheight;
    } else if (hwidth != null && horizontalShow) {
      percent = hwidth;
    }
    return getWidth * percent / 100;
  }
}

class _DecorationClipper extends CustomClipper<Path> {
  final TextDirection textDirection;

  final Decoration decoration;
  _DecorationClipper({
    TextDirection? textDirection,
    required this.decoration,
  }) : textDirection = textDirection ?? TextDirection.ltr;

  @override
  Path getClip(Size size) {
    return decoration.getClipPath(Offset.zero & size, textDirection);
  }

  @override
  bool shouldReclip(_DecorationClipper oldClipper) {
    return oldClipper.decoration != decoration ||
        oldClipper.textDirection != textDirection;
  }
}

class _FitterContainerState extends State<FitterContainer> {
  Widget? child;

  @override
  Widget build(BuildContext context) {
    BuildContext parentContext = widget.parentContext ?? context;

    final constraint = SizeConstraints(context: parentContext);
    Widget? current = widget.child;
    widget.width = constraint.getWidth;
    widget.height = constraint.getHeight;

    if (child == null &&
        (widget.constraints == null || !widget.constraints!.isTight)) {
      current = LimitedBox(
        maxWidth: 0.0,
        maxHeight: 0.0,
        child: ConstrainedBox(constraints: const BoxConstraints.expand()),
      );
    }

    if (widget.alignment != null) {
      current = Align(alignment: widget.alignment!, child: current);
    }

    final EdgeInsetsGeometry? effectivePadding =
        widget._paddingIncludingDecoration;
    if (effectivePadding != null) {
      current = Padding(padding: effectivePadding, child: current);
    }

    if (widget.color != null) {
      current = ColoredBox(color: widget.color!, child: current);
    }

    if (widget.clipBehavior != Clip.none) {
      assert(widget.decoration != null);
      current = ClipPath(
        clipper: _DecorationClipper(
          textDirection: Directionality.maybeOf(parentContext),
          decoration: widget.decoration!,
        ),
        clipBehavior: widget.clipBehavior,
        child: current,
      );
    }

    if (widget.decoration != null) {
      current = DecoratedBox(decoration: widget.decoration!, child: current);
    }

    if (widget.foregroundDecoration != null) {
      current = DecoratedBox(
        decoration: widget.foregroundDecoration!,
        position: DecorationPosition.foreground,
        child: current,
      );
    }

    if (widget.constraints != null) {
      current =
          ConstrainedBox(constraints: widget.constraints!, child: current);
    }

    if (widget.margin != null) {
      current = Padding(padding: widget.margin!, child: current);
    }

    if (widget.transform != null) {
      current = Transform(
          transform: widget.transform!,
          alignment: widget.transformAlignment,
          child: current);
    }

    return current!;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>(
        'alignment', widget.alignment,
        showName: false, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>(
        'padding', widget.padding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Clip>(
        'clipBehavior', widget.clipBehavior,
        defaultValue: Clip.none));
    if (widget.color != null) {
      properties.add(DiagnosticsProperty<Color>('bg', widget.color));
    } else {
      properties.add(DiagnosticsProperty<Decoration>('bg', widget.decoration,
          defaultValue: null));
    }
    properties.add(DiagnosticsProperty<Decoration>(
        'fg', widget.foregroundDecoration,
        defaultValue: null));
    properties.add(DiagnosticsProperty<BoxConstraints>(
        'constraints', widget.constraints,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>(
        'margin', widget.margin,
        defaultValue: null));
    properties
        .add(ObjectFlagProperty<Matrix4>.has('transform', widget.transform));
  }

  @override
  void initState() {
    super.initState();
  }

  FitterContainer setDimension(double newWidth, double newHeight) {
    if (mounted) {
      setState(() {
        widget.height = newHeight;
        widget.height = (widget.height != null && widget.heightPercent != null)
            ? widget.height! * widget.heightPercent! / 100
            : widget.height!;
        widget.width = newWidth;
        widget.width = (widget.width != null && widget.widthPercent != null)
            ? widget.width! * widget.widthPercent! / 100
            : widget.width;
        widget.constraints = (widget.width != null || widget.height != null)
            ? widget.constraints
                    ?.tighten(width: widget.width, height: widget.height) ??
                BoxConstraints.tightFor(
                    width: widget.width, height: widget.height)
            : widget.constraints;
      });
    }
    return widget;
  }

  FitterContainer setHeight(double newHeight) {
    if (mounted) {
      setState(() {
        widget.height = (widget.height != null && widget.heightPercent != null)
            ? widget.height! * widget.heightPercent! / 100
            : widget.height!;
        widget.constraints = (widget.width != null || widget.height != null)
            ? widget.constraints
                    ?.tighten(width: widget.width, height: widget.height) ??
                BoxConstraints.tightFor(
                    width: widget.width, height: widget.height)
            : widget.constraints;
      });
    }
    return widget;
  }

  FitterContainer setSize(Size newSize) {
    if (mounted) {
      setState(() {
        widget.height = newSize.height;
        widget.width = newSize.width;
        widget.height = (widget.height != null && widget.heightPercent != null)
            ? widget.height! * widget.heightPercent! / 100
            : widget.height!;
        widget.width = (widget.width != null && widget.widthPercent != null)
            ? widget.width! * widget.widthPercent! / 100
            : widget.width;
        widget.constraints = (widget.width != null || widget.height != null)
            ? widget.constraints
                    ?.tighten(width: widget.width, height: widget.height) ??
                BoxConstraints.tightFor(
                    width: widget.width, height: widget.height)
            : widget.constraints;
      });
    }
    return widget;
  }

  FitterContainer setWidth(double newWidth) {
    if (mounted) {
      setState(() {
        widget.width = (widget.width != null && widget.widthPercent != null)
            ? widget.width! * widget.widthPercent! / 100
            : widget.width;
        widget.constraints = (widget.width != null || widget.height != null)
            ? widget.constraints
                    ?.tighten(width: widget.width, height: widget.height) ??
                BoxConstraints.tightFor(
                    width: widget.width, height: widget.height)
            : widget.constraints;
      });
    }
    return widget;
  }
}
