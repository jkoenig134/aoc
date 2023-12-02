import 'package:collection/collection.dart';

import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.raw(), part1, part2);

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  Point move(String direction) => switch (direction) {
        '^' => Point(x, y + 1),
        'v' => Point(x, y - 1),
        '>' => Point(x + 1, y),
        '<' => Point(x - 1, y),
        _ => this,
      };
}

int part1(String input) {
  final split = input.split('');

  var current = Point(0, 0);
  final points = <Point>{current};

  split.forEach((element) {
    current = current.move(element);
    points.add(current);
  });

  return points.length;
}

int part2(String input) {
  final split = input.split('');

  var currentSanta = Point(0, 0);
  var currentRobot = Point(0, 0);
  final points = <Point>{currentSanta};

  split.forEachIndexed((index, element) {
    if (index % 2 == 0) {
      currentSanta = currentSanta.move(element);
      points.add(currentSanta);
    } else {
      currentRobot = currentSanta.move(element);
      points.add(currentRobot);
    }
  });

  return points.length;
}
