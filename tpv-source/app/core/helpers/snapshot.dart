import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

bool isDone<T>(AsyncSnapshot snapshot) {
  return snapshot.connectionState == ConnectionState.done &&
      snapshot.hasData &&
      snapshot.data != null &&
      snapshot.data is T;
}

bool isError<T>(AsyncSnapshot snapshot) {
  return snapshot.connectionState == ConnectionState.none &&
          snapshot.hasData &&
          snapshot.data == null ||
      snapshot.data is Left ||
      snapshot.error != null;
}

bool isWaiting(AsyncSnapshot snapshot) {
  return snapshot.connectionState == ConnectionState.waiting;
}
