import 'package:collection/collection.dart' hide ListExtensions;

import '/utils/utils.dart';

class Pipe {
  final String name;
  final int row;
  final int column;

  bool isPartOfLoop = false;
  bool isEnclosedByLoop = false;

  Pipe(this.name, this.row, this.column) : isPartOfLoop = name == 'S';

  @override
  String toString() => name;

  Direction comesFrom(Pipe other) =>
      other.row == row ? (other.column > column ? Direction.up : Direction.down) : (other.row > row ? Direction.left : Direction.right);

  bool isConnectedTo(Pipe other) {
    final otherComesFrom = other.comesFrom(this);

    return switch (name) {
      '|' => otherComesFrom == Direction.up || otherComesFrom == Direction.down,
      '-' => otherComesFrom == Direction.left || otherComesFrom == Direction.right,
      'L' => otherComesFrom == Direction.up || otherComesFrom == Direction.right,
      'J' => otherComesFrom == Direction.up || otherComesFrom == Direction.left,
      '7' => otherComesFrom == Direction.down || otherComesFrom == Direction.left,
      'F' => otherComesFrom == Direction.down || otherComesFrom == Direction.right,
      '.' => false,
      'S' => true,
      _ => throw Exception('Unknown pipe: $name'),
    };
  }

  move({required Pipe other, required PipeSystem system}) {
    final otherComesFrom = other.comesFrom(this);

    final next = switch (name) {
      // | is a vertical pipe connecting north and south.
      '|' => system.pipes[column + (otherComesFrom == Direction.up ? 1 : -1)][row],

      // - is a horizontal pipe connecting east and west.
      '-' => system.pipes[column][row + (otherComesFrom == Direction.left ? 1 : -1)],

      // L is a 90-degree bend connecting north and east.
      'L' => otherComesFrom == Direction.up ? system.pipes[column][row + 1] : system.pipes[column - 1][row],

      // J is a 90-degree bend connecting north and west.
      'J' => otherComesFrom == Direction.up ? system.pipes[column][row - 1] : system.pipes[column - 1][row],

      // 7 is a 90-degree bend connecting south and west.
      '7' => otherComesFrom == Direction.left ? system.pipes[column + 1][row] : system.pipes[column][row - 1],

      // F is a 90-degree bend connecting south and east.
      'F' => otherComesFrom == Direction.down ? system.pipes[column][row + 1] : system.pipes[column + 1][row],

      // S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.
      'S' => throw Exception('Cannot move from S'),

      // . is ground; there is no pipe in this tile.
      '.' || _ => throw Exception('Unknown pipe: $name'),
    };

    return next;
  }
}

class PipeSystem {
  final List<List<Pipe>> pipes;

  PipeSystem(String s) : pipes = s.split('\n').mapIndexed((e, column) => e.split('').mapIndexed((e, row) => Pipe(e, row, column)));

  Pipe start() => pipes.flattened.firstWhere((e) => e.name == 'S')..isPartOfLoop = true;

  void debugLog() {
    print(pipes
        .map((e) => e
            .map(
              (e) => e.isPartOfLoop
                  ? e.name
                  : e.isEnclosedByLoop
                      ? 'o'
                      : ' ',
            )
            .join(''))
        .join('\n'));
  }
}

extension ToPipeSystem on String {
  PipeSystem toPipeSystem() => PipeSystem(this);
}

main(List<String> args) => runSolutions((i) => i.raw().toPipeSystem(), part1, part2);

int part1(PipeSystem input) {
  var from = input.start();
  final startNeighbors = input.pipes.neighbors(from.row, from.column, includeDiagonals: false);
  var to = startNeighbors.map((coords) => input.pipes[coords.$2][coords.$1]).where((e) => e.isConnectedTo(from)).first;
  to.isPartOfLoop = true;

  while (to.name != 'S') {
    final nextTo = to.move(other: from, system: input);

    from = to;
    to = nextTo;
    to.isPartOfLoop = true;
  }

  return (input.pipes.flattened.where((e) => e.isPartOfLoop).length / 2).floor();
}

int part2(PipeSystem input) {
  part1(input);

  var insideCounts = [];

  for (final line in input.pipes) {
    for (final pipe in line) {
      if (pipe.isPartOfLoop) continue;

      final loopPipesOnLeft = line.sublist(0, pipe.row).where((element) => element.isPartOfLoop).length;
      final loopPipesOnRight = line.sublist(pipe.row + 1).where((element) => element.isPartOfLoop).length;

      if (loopPipesOnLeft > 0 && loopPipesOnRight > 0 && (loopPipesOnLeft % 2 == 1 || loopPipesOnRight % 2 == 1)) {
        insideCounts.add(pipe);
        pipe.isEnclosedByLoop = true;
      }
    }
  }

  input.debugLog();
  return insideCounts.length;
}
