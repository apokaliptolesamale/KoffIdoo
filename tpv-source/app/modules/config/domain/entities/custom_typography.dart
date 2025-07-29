// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/foundation.dart' as fun;
import 'package:flutter/material.dart';

class CustomTypography extends Typography {
  factory CustomTypography({
    fun.TargetPlatform? platform,
    TextTheme? black,
    TextTheme? white,
    TextTheme? englishLike,
    TextTheme? dense,
    TextTheme? tall,
  }) = CustomTypography.material2018;

  factory CustomTypography.material2018({
    TargetPlatform? platform = TargetPlatform.android,
    TextTheme? black,
    TextTheme? white,
    TextTheme? englishLike,
    TextTheme? dense,
    TextTheme? tall,
  }) {
    assert(platform != null || (black != null && white != null));
    return CustomTypography._withPlatform(
      platform,
      black,
      white,
      englishLike ?? Typography.englishLike2018,
      dense ?? Typography.dense2018,
      tall ?? Typography.tall2018,
    );
  }

  factory CustomTypography._withPlatform(
    TargetPlatform? platform,
    TextTheme? black,
    TextTheme? white,
    TextTheme englishLike,
    TextTheme dense,
    TextTheme tall,
  ) {
    assert(platform != null || (black != null && white != null));
    switch (platform) {
      case TargetPlatform.iOS:
        black ??= Typography.blackCupertino;
        white ??= Typography.whiteCupertino;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        black ??= Typography.blackMountainView;
        white ??= Typography.whiteMountainView;
        break;
      case TargetPlatform.windows:
        black ??= Typography.blackRedmond;
        white ??= Typography.whiteRedmond;
        break;
      case TargetPlatform.macOS:
        black ??= Typography.blackRedwoodCity;
        white ??= Typography.whiteRedwoodCity;
        break;
      case TargetPlatform.linux:
        black ??= Typography.blackHelsinki;
        white ??= Typography.whiteHelsinki;
        break;
      case null:
        break;
    }
    return CustomTypography(
      black: black,
      dense: dense,
      englishLike: englishLike,
      platform: platform,
      tall: tall,
      white: white,
    );
  }
}
