// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GiftListTitleWidget extends StatelessWidget {
  String text;
  String imageAsset;
  void Function() onTap;
  GiftListTitleWidget(this.onTap, this.imageAsset, this.text, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: Image.asset(imageAsset, height: size.height / 25),
      title: Text(text),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: size.height / 40,
      ),
      onTap: onTap,
    );
  }
}
