import '/utils/utils.dart';

class Walker {
  final List<Direction> directions;

  final Map<String, ({String left, String right})> map;

  Walker(this.directions, this.map);

  factory Walker.fromString(String input) {
    final lines = input.split('\n\n');

    final inputs = lines[0].split('').map(Direction.fromString).toList();

    final map = <String, ({String left, String right})>{};

    for (final line in lines[1].split('\n')) {
      final parts = line.split(' = ');
      final key = parts[0];
      final values = parts[1].substring(1, parts[1].length - 1).split(', ');
      map[key] = (left: values[0], right: values[1]);
    }

    return Walker(inputs, map);
  }

  String nextPoint(String current, Direction direction) {
    final nextPossibilities = map[current]!;
    if (direction == Direction.left) {
      return nextPossibilities.left;
    } else {
      return nextPossibilities.right;
    }
  }

  int stepsFromStartToEndsWith({String start = 'AAA', String endsWith = 'ZZZ'}) {
    var current = start;
    var steps = 0;

    while (!current.endsWith(endsWith)) {
      final currentDirection = directions[steps % directions.length];
      current = nextPoint(current, currentDirection);
      steps++;
    }

    return steps;
  }

  int findAllEndingWithAEndingWithZ() {
    final startingPoints = map.keys.where((key) => key.endsWith('A')).toList();
    final howManyToEnd = startingPoints.map((e) => stepsFromStartToEndsWith(start: e, endsWith: 'Z')).toList();

    // find the least common multiple of all the numbers
    return howManyToEnd.reduce((a, b) => (a * b) ~/ a.gcd(b));
  }
}

main(List<String> args) => runSolutions((i) => Walker.fromString(i.raw()), part1, part2);

int part1(Walker input) => input.stepsFromStartToEndsWith();

int part2(Walker input) => input.findAllEndingWithAEndingWithZ();
