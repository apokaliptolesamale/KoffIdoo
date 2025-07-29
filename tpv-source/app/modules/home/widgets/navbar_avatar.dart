// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class NavBarAvatar extends StatelessWidget {
  final String? avatarImagURL;
  NavBarAvatar({Key? key, this.avatarImagURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        child: (avatarImagURL == null)
            ? (Icon(Icons.admin_panel_settings_outlined))
            : Image.network(avatarImagURL!),
        width: 30,
        height: 30,
      ),
    );
  }
}
