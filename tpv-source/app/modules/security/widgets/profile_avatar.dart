import 'package:flutter/material.dart';

import '../../../../app/widgets/ext/user_profile_avatar.dart';

class ProfileAvatar extends StatelessWidget {
  static final ProfileAvatar getInstance = ProfileAvatar._internal();
  ProfileAvatar._internal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserProfileAvatar();
  }
}
