// Copyright 2013 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:collection';

/// A base class for [Iterable]s of infinite length that throws
/// [UnsupportedError] for methods that would require the Iterable to
/// terminate.
abstract class InfiniteIterable<T> extends IterableBase<T> {
  @override
  bool get isEmpty => false;

  @override
  bool get isNotEmpty => true;

  @override
  T get last => throw UnsupportedError('last');

  @override
  int get length => throw UnsupportedError('length');

  @override
  T get single => throw StateError('single');

  @override
  bool every(bool Function(T element) test) => throw UnsupportedError('every');

  @override
  T1 fold<T1>(T1 initialValue, T1 Function(T1 previousValue, T element) combine) =>
      throw UnsupportedError('fold');

  @override
  void forEach(void Function(T element) action) => throw UnsupportedError('forEach');

  @override
  String join([String separator = '']) => throw UnsupportedError('join');

  @override
  T lastWhere(bool Function(T value) test, {T Function()? orElse}) =>
      throw UnsupportedError('lastWhere');

  @override
  T reduce(T Function(T value, T element) combine) => throw UnsupportedError('reduce');

  @override
  T singleWhere(bool Function(T value) test, {T Function()? orElse}) =>
      throw UnsupportedError('singleWhere');

  @override
  List<T> toList({bool growable = true}) => throw UnsupportedError('toList');

  @override
  Set<T> toSet() => throw UnsupportedError('toSet');
}
