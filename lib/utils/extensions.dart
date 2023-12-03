import 'dart:math';

import 'package:collection/collection.dart' show IterableIntegerExtension;

import 'enums.dart';

export 'package:collection/collection.dart' show IterableIntegerExtension;

extension Windowed<T> on List<T> {
  List<List<T>> windowed(int size) => [for (int i = 0; i <= length - size; i++) sublist(i, i + size)];

  List<List<T>> windowedExclusive(int size) => [for (int i = 0; i <= length - size; i += size) sublist(i, i + size)];
}

extension Sum on Iterable<int> {
  int get sumOnlyPositive {
    final result = sum;
    return result > 0 ? result : 0;
  }

  int get mul => length == 0 ? 0 : reduce((a, b) => a * b);
}

extension MapToList<E> on Iterable<E> {
  List<T> mapL<T>(T Function(E e) toElement) => map(toElement).toList();
}

extension MapIndexed<E> on List<E> {
  List<T> mapIndexed<T>(T Function(E e, int index) toElement) => asMap()
      .map(
        (index, row) => MapEntry(
          index,
          toElement(row, index),
        ),
      )
      .values
      .toList();
}

extension IterableLogging<T> on Iterable<T> {
  Iterable<T> get logIterable {
    forEach(print);
    return this;
  }
}

extension Logging<T> on T {
  T get log {
    print(this);
    return this;
  }
}

extension BinaryToDecimal on String {
  int get binaryToDecimal => int.parse(this, radix: 2);
}

extension StringToNumbers on String {
  int get asInt => int.parse(this);
}

extension FlipListOfLists<T> on List<List<T>> {
  List<List<T>> flipped() {
    List<List<T>> flipped = [];

    for (int i = 0; i < this[1].length; i++) {
      final row = <T>[];

      for (int j = 0; j < length; j++) {
        row.add(this[j][i]);
      }

      flipped.add(row);
    }

    return flipped;
  }
}

extension AllItemsUnique<T> on List<T> {
  bool get allItemsUnique => toSet().length == length;
}

extension ApplyDirection on Point<int> {
  Point<int> moveInDirection(Direction direction, [int distance = 1]) {
    switch (direction) {
      case Direction.up:
        return Point(x, y - distance);
      case Direction.down:
        return Point(x, y + distance);
      case Direction.left:
        return Point(x - distance, y);
      case Direction.right:
        return Point(x + distance, y);
    }
  }
}

extension Neighbors<T> on List<List<T>> {
  List<(int, int)> neighbors(int x, int y) {
    final gridSize = length;

    final neighbors = [
      (x - 1, y - 1),
      (x - 1, y),
      (x - 1, y + 1),
      (x, y - 1),
      (x, y + 1),
      (x + 1, y - 1),
      (x + 1, y),
      (x + 1, y + 1),
    ]
        .where(
          (n) => n.$1 >= 0 && n.$2 >= 0 && n.$1 < gridSize && n.$2 < gridSize,
        )
        .toList();

    return neighbors;
  }
}
