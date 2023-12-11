import 'dart:math';

import 'package:trotter/trotter.dart';

import '/utils/utils.dart';

class Universe {
  final List<List<String>> grid;
  final List<Point<int>> galaxies;

  final List<int> emptyRowIndices;
  final List<int> emptyColumnIndices;

  Universe(this.grid, this.galaxies, this.emptyColumnIndices, this.emptyRowIndices);

  factory Universe.fromString(String input) {
    final grid = input.split('\n').map((e) => e.split('')).toList();

    final emptyRowIndices = grid.indexed.where((e) => e.$2.every((c) => c == '.')).map((e) => e.$1).toList();
    final emptyColumnIndices = grid.flipped().indexed.where((e) => e.$2.every((c) => c == '.')).map((e) => e.$1).toList();

    final galaxies = <Point<int>>[];

    for (int x = 0; x < grid.length; x++) {
      final row = grid[x];

      for (int y = 0; y < row.length; y++) {
        if (row[y] == '#') {
          galaxies.add(Point<int>(x, y));
        }
      }
    }

    return Universe(grid, galaxies, emptyColumnIndices, emptyRowIndices);
  }

  List<Point<int>> grow(int factor) {
    final galaxies = this.galaxies.map(
      (e) {
        final emptyRowsToPoint = emptyRowIndices.where((x) => x <= e.x).length;
        final emptyColumnsToPoint = emptyColumnIndices.where((x) => x <= e.y).length;

        return Point(
          e.x + (factor * emptyRowsToPoint) - emptyRowsToPoint,
          e.y + (factor * emptyColumnsToPoint) - emptyColumnsToPoint,
        );
      },
    ).toList();
    return galaxies;
  }

  int getDistanceBetweenAllCoords(int emptyLineGrowFactor) {
    final combinations = Combinations(2, grow(emptyLineGrowFactor))().toList();

    return combinations.map((e) {
      final first = e[0];
      final second = e[1];

      return (first.x - second.x).abs() + (first.y - second.y).abs();
    }).sum;
  }
}

main(List<String> args) => runSolutions((i) => Universe.fromString(i.raw()), part1, part2);

int part1(Universe input) => input.getDistanceBetweenAllCoords(2);

int part2(Universe input) => input.getDistanceBetweenAllCoords(1000000);
