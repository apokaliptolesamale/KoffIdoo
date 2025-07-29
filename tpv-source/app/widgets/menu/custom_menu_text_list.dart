import 'package:flutter/material.dart';

class CustomMenuTextList extends StatelessWidget {
  final Map<String, String> menu;
  final String title;
  CustomMenuTextList({
    Key? key,
    required this.title,
    required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        children: menu.entries.map((e) {
          return TextSpan(
            text: e.key,
            children: [
              TextSpan(
                  text: "${e.value}\n\n",
                  style: TextStyle(fontWeight: FontWeight.normal))
            ],
            style: TextStyle(fontWeight: FontWeight.bold),
          );
        }).toList(),
      ),
    );
  }
}
