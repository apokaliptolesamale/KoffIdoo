// ignore_for_file: public_member_api_docs, sort_constructors_first, overridden_fields, must_be_immutable, unused_shown_name
import 'dart:ui' as ui
    show
        FontFeature,
        FontVariation,
        ParagraphStyle,
        Shadow,
        StrutStyle,
        TextHeightBehavior,
        TextLeadingDistribution,
        TextStyle,
        lerpDouble;

import 'package:flutter/material.dart';

class CustomTextStyle extends TextStyle {
  String? styleId;
  String styleName;
  double opacity;

  @override
  final bool inherit = true;
  @override
  final Color? color;
  @override
  final Color? backgroundColor;
  @override
  final double? fontSize;
  @override
  final FontWeight? fontWeight;
  @override
  final FontStyle? fontStyle;
  @override
  final double? letterSpacing;
  @override
  final double? wordSpacing;
  @override
  final TextBaseline? textBaseline;
  @override
  final double? height;
  @override
  final ui.TextLeadingDistribution? leadingDistribution;
  @override
  final Locale? locale;
  @override
  final Paint? foreground;
  @override
  final Paint? background;
  @override
  final List<ui.Shadow>? shadows;
  @override
  final List<ui.FontFeature>? fontFeatures;
  @override
  final List<ui.FontVariation>? fontVariations;
  @override
  final TextDecoration? decoration;
  @override
  final Color? decorationColor;
  @override
  final TextDecorationStyle? decorationStyle;
  @override
  final double? decorationThickness;
  @override
  final String? debugLabel;
  @override
  String? fontFamily;
  @override
  List<String>? fontFamilyFallback;
  String? package;
  @override
  final TextOverflow? overflow;

  CustomTextStyle({
    required this.styleName,
    required this.styleId,
    this.opacity = 0.0,
    this.color,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.leadingDistribution,
    this.locale,
    this.foreground,
    this.background,
    this.shadows,
    this.fontFeatures,
    this.fontVariations,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.debugLabel,
    this.fontFamily,
    this.fontFamilyFallback,
    this.package,
    this.overflow,
  }) : super(
          color: color,
          backgroundColor: backgroundColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          textBaseline: textBaseline,
          height: height,
          leadingDistribution: leadingDistribution,
          locale: locale,
          foreground: color != null ? null : foreground,
          background: backgroundColor != null ? null : background,
          shadows: shadows,
          fontFeatures: fontFeatures,
          fontVariations: fontVariations,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,
          debugLabel: debugLabel,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          package: package,
          overflow: overflow,
        );
}
