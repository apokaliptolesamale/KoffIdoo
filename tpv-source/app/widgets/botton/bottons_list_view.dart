import 'package:flutter/material.dart';

import '../../../app/widgets/botton/custom_bottons.dart';

class BottonListView extends StatelessWidget {
  final List<CustomButtonsInterface> buttons;
  final Widget? separator;
  final Axis? scrollDirection;
  BottonListView(
      {Key? key, this.buttons = const [], this.separator, this.scrollDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buttons.isEmpty
        ? Container()
        : Container(
            width: double.infinity,
            height: 40,
            child: ListView.separated(
              scrollDirection: scrollDirection ?? Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return separator ??
                    SizedBox(
                      height: 5,
                      width: 5,
                    );
              },
              itemCount: buttons.length,
              itemBuilder: (_, i) {
                return buttons[i];
              },
            ));
  }
}
