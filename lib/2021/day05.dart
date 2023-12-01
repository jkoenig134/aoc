import 'dart:math';

import '/utils/utils.dart';

class Position {
  final int x, y;

  Position(this.x, this.y);

  @override
  String toString() => '$x,$y';
}

class Path {
  late Position start;
  late Position end;

  Path.fromString(String input) {
    final split = input.split(" -> ");

    final startSplit = split[0].split(",");
    start = Position(int.parse(startSplit[0]), int.parse(startSplit[1]));

    final endSplit = split[1].split(",");
    end = Position(int.parse(endSplit[0]), int.parse(endSplit[1]));
  }

  List<Position> calculatePositions(bool includeDiagonals) {
    if (start.x == end.x) {
      final startY = min(start.y, end.y);
      final endY = max(start.y, end.y);

      return List.generate(
        endY - startY + 1,
        (i) => Position(start.x, startY + i),
      );
    } else if (start.y == end.y) {
      final startX = min(start.x, end.x);
      final endX = max(start.x, end.x);

      return List.generate(
        endX - startX + 1,
        (i) => Position(startX + i, start.y),
      );
    }

    if (!includeDiagonals) return [];

    return [
      for (int x = start.x, y = start.y;
          x != end.x;
          x += (start.x > end.x ? -1 : 1), y += (start.y > end.y ? -1 : 1))
        Position(x, y),
      Position(end.x, end.y),
    ];
  }
}

int findCommonPoints(List<String> input, [bool includeDiagonals = false]) {
  final positions = input
      .map((line) => Path.fromString(line))
      .map((e) => e.calculatePositions(includeDiagonals))
      .expand((e) => e)
      .map((e) => e.toString());

  final occurences = <String, int>{};
  positions.forEach(
    (p) => occurences[p] = occurences.putIfAbsent(p, () => 0) + 1,
  );

  return occurences.values.where((v) => v > 1).length;
}

main(List<String> args) => runSolutions((i) => i.asString(), part1, part2);

int part1(List<String> input) => findCommonPoints(input);

int part2(List<String> input) => findCommonPoints(input, true);
