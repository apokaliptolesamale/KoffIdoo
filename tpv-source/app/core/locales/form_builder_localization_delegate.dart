// ignore_for_file: unused_element
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../app/core/services/logger_service.dart';

class FormBuilderLocalizationsDelegate
    extends LocalizationsDelegate<FormBuilderLocalizations> {
  static LocalizationsDelegate<FormBuilderLocalizations> delegate =
      FormBuilderLocalizationsDelegate();

  FormBuilderLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<FormBuilderLocalizations> load(Locale locale) {
    log("Inicializando locale:${locale.toLanguageTag()}");
    try {
      return load(locale);
    } catch (e) {}
    return load(locale);
  }

  @override
  bool shouldReload(FormBuilderLocalizationsDelegate old) => true;
}
