import 'dart:math';

import 'package:aoc/2023/day11.dart';
import 'package:test/test.dart';

void main() {
  final testInput1 = '''...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....''';

  final ps1 = Universe.fromString(testInput1);

  test('galaxies', () {
    expect(ps1.galaxies, [
      Point(0, 3),
      Point(1, 7),
      Point(2, 0),
      Point(4, 6),
      Point(5, 1),
      Point(6, 9),
      Point(8, 7),
      Point(9, 0),
      Point(9, 4),
    ]);
  });

  test('universe size', () {
    expect(ps1.grow(2), [
      Point(0, 4),
      Point(1, 9),
      Point(2, 0),
      Point(5, 8),
      Point(6, 1),
      Point(7, 12),
      Point(10, 9),
      Point(11, 0),
      Point(11, 5),
    ]);
  });

  test('getDistanceBetweenAllCoords', () => expect(ps1.getDistanceBetweenAllCoords(2), 374));

  test('getDistanceBetweenAllCoords', () => expect(ps1.getDistanceBetweenAllCoords(10), 1030));

  test('getDistanceBetweenAllCoords', () => expect(ps1.getDistanceBetweenAllCoords(100), 8410));
}
