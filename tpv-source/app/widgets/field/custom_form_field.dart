import 'package:flutter/material.dart';

import '../../core/patterns/publisher.dart';

abstract class CustomFormField<T> extends Widget implements Subscriber<T> {
  String? get getValue => null;
  update(String newValue, void Function() callback);
}
