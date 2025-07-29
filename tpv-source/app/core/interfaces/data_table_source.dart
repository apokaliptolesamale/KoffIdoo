import 'package:flutter/material.dart';

abstract class IDataTableSource extends DataTableSource {
  void selectAll(bool isAllSelected);
}
