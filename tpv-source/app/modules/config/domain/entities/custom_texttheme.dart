// ignore_for_file: overridden_fields, must_be_immutable

import 'package:flutter/material.dart';

import '../models/custom_text_style_model.dart';

class CustomTextTheme extends TextTheme {
  String themeName;
  String? themeId;

  // Estilos de texto para títulos grandes
  @override
  CustomTextStyleModel? headlineLarge;

  // Estilos de texto para etiquetas medianas
  @override
  CustomTextStyleModel? labelMedium;

  // Estilos de texto para visualización grande
  @override
  CustomTextStyleModel? displayLarge;

  // Estilos de texto para visualización media
  @override
  CustomTextStyleModel? displayMedium;

  // Estilos de texto para visualización pequeña
  @override
  CustomTextStyleModel? displaySmall;

  // Estilos de texto para títulos medianos
  @override
  CustomTextStyleModel? headlineMedium;

  // Estilos de texto para títulos pequeños
  @override
  CustomTextStyleModel? headlineSmall;

  // Estilos de texto para títulos grandes
  @override
  CustomTextStyleModel? titleLarge;

  // Estilos de texto para títulos medianos
  @override
  CustomTextStyleModel? titleMedium;

  // Estilos de texto para títulos pequeños
  @override
  CustomTextStyleModel? titleSmall;

  // Estilos de texto para cuerpos grandes
  @override
  CustomTextStyleModel? bodyLarge;

  // Estilos de texto para cuerpos medianos
  @override
  CustomTextStyleModel? bodyMedium;

  // Estilos de texto para cuerpos pequeños
  @override
  CustomTextStyleModel? bodySmall;

  // Estilos de texto para etiquetas grandes
  @override
  CustomTextStyleModel? labelLarge;

  // Estilos de texto para etiquetas pequeñas
  @override
  CustomTextStyleModel? labelSmall;

  CustomTextTheme({
    required this.themeName,
    this.themeId,
    this.headlineLarge,
    this.labelMedium,
    this.displayLarge,
    this.displayMedium,
    this.displaySmall,
    this.headlineMedium,
    this.headlineSmall,
    this.titleLarge,
    this.titleMedium,
    this.titleSmall,
    this.bodyLarge,
    this.bodyMedium,
    this.bodySmall,
    this.labelLarge,
    this.labelSmall,
  }) : super(
          displayLarge: displayLarge ??
              CustomTextStyleModel(
                styleId: "displayLarge",
                styleName: "displayLarge",
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
          displayMedium: displayMedium ??
              CustomTextStyleModel(
                styleId: "displayMedium",
                styleName: "displayMedium",
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.25,
              ),
          displaySmall: displaySmall ??
              CustomTextStyleModel(
                styleId: "displaySmall",
                styleName: "displaySmall",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.25,
              ),
          headlineLarge: headlineLarge ??
              CustomTextStyleModel(
                styleId: "headlineLarge",
                styleName: "headlineLarge",
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.25,
              ),
          headlineMedium: headlineMedium ??
              CustomTextStyleModel(
                styleId: "headlineMedium",
                styleName: "headlineMedium",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.25,
              ),
          headlineSmall: headlineSmall ??
              CustomTextStyleModel(
                styleId: "headlineSmall",
                styleName: "headlineSmall",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
          titleLarge: titleLarge ??
              CustomTextStyleModel(
                styleId: "titleLarge",
                styleName: "titleLarge",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.15,
              ),
          titleMedium: titleMedium ??
              CustomTextStyleModel(
                styleId: "titleMedium",
                styleName: "titleMedium",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.15,
              ),
          titleSmall: titleSmall ??
              CustomTextStyleModel(
                styleId: "titleSmall",
                styleName: "titleSmall",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.15,
              ),
          bodyLarge: bodyLarge ??
              CustomTextStyleModel(
                styleId: "bodyLarge",
                styleName: "bodyLarge",
                fontSize: 20,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.5,
              ),
          bodyMedium: bodyMedium ??
              CustomTextStyleModel(
                styleId: "bodyMedium",
                styleName: "bodyMedium",
                fontSize: 16,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.5,
              ),
          bodySmall: bodySmall ??
              CustomTextStyleModel(
                styleId: "bodySmall",
                styleName: "bodySmall",
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.25,
              ),
          labelLarge: labelLarge ??
              CustomTextStyleModel(
                styleId: "labelLarge",
                styleName: "labelLarge",
                fontSize: 16,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.5,
              ),
          labelMedium: labelMedium ??
              CustomTextStyleModel(
                styleId: "labelMedium",
                styleName: "labelMedium",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
          labelSmall: labelSmall ??
              CustomTextStyleModel(
                styleId: "labelSmall",
                styleName: "labelSmall",
                fontSize: 12,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.4,
              ),
        ) {
    headlineLarge = headlineLarge ??
        CustomTextStyleModel(
          styleId: "headlineLarge",
          styleName: "headlineLarge",
          fontSize: 36,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.25,
        );
  }
}
