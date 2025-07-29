import 'package:flutter/material.dart';

import '../../../app/core/types/custom_types.dart';

class CustomDragTarget<T extends Object> extends StatelessWidget {
  final DragTargetBuilder<T>? builder;
  final DragTargetAccept<T>? onAccept;
  final DragTargetWillAccept<T>? onWillAccept;
  final DragTargetAcceptWithDetails<T>? onAcceptWithDetails;
  final DragTargetLeave<T>? onLeave;
  final DragTargetMove<T>? onMove;
  final HitTestBehavior hitTestBehavior;
  final Widget? child;
  final onTapCallBack? onTap;
  final onEnterCallBack? onEnter;
  final onExitCallBack? onExit;
  final onHoverCallBack? onHover;

  CustomDragTarget({
    Key? key,
    this.builder,
    this.child,
    this.onAccept,
    this.onWillAccept,
    this.onAcceptWithDetails,
    this.onLeave,
    this.onMove,
    this.hitTestBehavior = HitTestBehavior.translucent,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap != null ? onTap!(context, this) : false;
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          onHover != null ? onHover!(context, event, this) : false;
        },
        onEnter: (event) {
          onEnter != null ? onEnter!(context, event, this) : false;
        },
        onExit: (event) {
          onExit != null ? onExit!(context, event, this) : false;
        },
        child: DragTarget<T>(
          builder: builder ??
              (context, candidateData, rejectedData) {
                return child ??
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 10),
                      child: Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                          ),
                          child: child,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Color(0xFFd7d7d7), width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      height: 50,
                      width: 100,
                    );
              },
          onAccept: onAccept,
          onAcceptWithDetails: onAcceptWithDetails,
          onLeave: onLeave,
          onMove: onMove,
          onWillAccept: onWillAccept,
          hitTestBehavior: hitTestBehavior,
        ),
      ),
    );
  }
}
