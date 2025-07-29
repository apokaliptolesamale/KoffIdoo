import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef EntryCollector<Type> = Stream<Type> Function(Future<Type> futureEntity);

typedef onEnterCallBack = void Function<T>(
    BuildContext context, PointerEnterEvent event, T scope);

typedef onExitCallBack = void Function<T>(
    BuildContext context, PointerExitEvent event, T scope);

typedef onHoverCallBack = void Function<T>(
    BuildContext context, PointerHoverEvent event, T scope);

typedef onPressedCallBack = void Function<T>(BuildContext context, T scope);

typedef onTapCallBack = void Function<T>(BuildContext context, T scope);

typedef TestForMap = bool Function(dynamic, dynamic);
