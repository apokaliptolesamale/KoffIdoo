// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/theme_model.dart';
import 'custom_shadow.dart';
import 'custom_text_style.dart';

class Design {
  final String name;
  final String clientId;
  final DateTime createAt;
  final DateTime updateAt;
  final List<CustomShadow> shadows;
  final List<Color> colors;
  final List<ThemeModel> themes;
  final List<TextTheme> textThemes;
  final List<CustomTextStyle> styles;
  Design({
    required this.name,
    required this.clientId,
    required this.createAt,
    required this.updateAt,
    required this.colors,
    required this.shadows,
    required this.themes,
    required this.textThemes,
    required this.styles,
  });
}
